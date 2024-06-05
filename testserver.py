#!/usr/bin/env python3

# Server port
PO_PORT            = 57409

# Commands sent by the client
PO_CMD_DISCONNECT  = 0x00 # Disconnect from server
PO_CMD_STATUS      = 0x01 # Server status
PO_CMD_WONDERTRADE = 0x02 # Get a series of random bytes
PO_CMD_SETINFO     = 0x03 # Set info (player name, ID, party)
PO_CMD_GETINFO     = 0x04 # Get info about someone else
PO_CMD_LISTUSERS   = 0x05 # List connected users
PO_CMD_BATTLEUSER  = 0x06 # Battle an user
PO_CMD_TRADEUSER   = 0x07 # Trade with an user
PO_CMD_GETBATTLE   = 0x08 # Watch someone else's battle
PO_CMD_BATTLETURN  = 0x09 # Battle turn
PO_CMD_TRADETURN   = 0x0A # Offer trade or check if other side did
PO_CMD_SETREPLY    = 0x0B # View or change battle/trade request response

# Signals the client about an error, or if someone wants to battle/trade
PO_SIGNAL_ERROR       = 0x81 # There was an error
PO_SIGNAL_ASKBATTLE   = 0x86 # Someone asked to battle the user
PO_SIGNAL_ASKTRADE    = 0x87 # Someone asked to trade with the user

# Status normally returns user ID, but has a special value if closed
PO_STATUS_CLOSED      = 0x00 # Server closed

# Reply variants
PO_REPLY_ACCEPT       = 0x00 # Accept reply to battle/trade
PO_REPLY_REJECT       = 0x01 # Reject, or abort invite to, battle/trade
PO_REPLY_WAIT         = 0x02 # Checks if the request remains

# Error parameters
PO_ERROR_OK           = 0x00 # no error (returned by some server functions)
PO_ERROR_UNKNCMD      = 0x01 # Unknown command
PO_ERROR_UNKNUSER     = 0x02 # Unknown or disconnected user
PO_ERROR_BADINFO      = 0x03 # Illegitimate player information
PO_ERROR_INCOMPATIBLE = 0x04 # The games between the users are incompatible
PO_ERROR_UNAUTHORIZED = 0x05 # Action not permitted (e.g. battling yourself)
PO_ERROR_WITHANOTHER  = 0x06 # User is battling/trading with someone else
PO_ERROR_REJECTED     = 0x07 # User rejected battle/trade
PO_ERROR_DESYNCED     = 0x08 # Desync detected

# pokecrystal constants
MON_NAME_LENGTH = 11
NAME_LENGTH = 11
PARTY_LENGTH = 6
BOXMON_STRUCT_LENGTH = 0x20
PARTYMON_STRUCT_LENGTH = 0x30
RNG_LENGTH = 15

import socket
import threading
import secrets
from dataclasses import dataclass

def uint16(bytes, offset = 0):
    return bytes[offset] << 8 | bytes[offset + 1]

def setbytes(set, get, length = -1, getoff = 0, setoff = 0):
    lencap = min(len(set), len(get))
    if length < 0 or length > lencap:
        length = lencap

    for i in range(length):
        set[setoff] = get[getoff]
        setoff += 1
        getoff += 1

def bytes2hexstr(bytes):
    return " ".join(["{:02X}".format(x) for x in bytes])

class UserDisconnected(Exception):
    pass

@dataclass
class User:
    userid: int
    name: bytearray(NAME_LENGTH)
    mons: bytearray(PARTYMON_STRUCT_LENGTH * PARTY_LENGTH)
    ot: bytearray(NAME_LENGTH * PARTY_LENGTH)
    nicks: bytearray(MON_NAME_LENGTH * PARTY_LENGTH)
    lock: threading.RLock()
    partymons: int = 0
    gender: int = 0
    otid: int = 0
    connected: bool = True
    battleid: int = 0

    def serialize(self) -> bytearray():
        ret = bytearray()
        ret.append(self.otid >> 8)
        ret.append(self.otid & 0xFF)
        ret.append(self.partymons & 0xFF)
        ret.append(self.gender & 0xFF)
        ret.extend(self.name)
        ret.extend(self.mons)
        ret.extend(self.ot)
        ret.extend(self.nicks)
        return ret

    def unserialize(self, bytes):
        bc = 2
        if bytes[1] == 0:
            self.otid = uint16(bytes, bc)
            bc += 2
            self.partymons = bytes[bc]
            bc += 1
            self.gender = bytes[bc]
            bc += 1
            setbytes(self.name, bytes, NAME_LENGTH, bc)
            bc += NAME_LENGTH
            setbytes(self.mons, bytes, PARTYMON_STRUCT_LENGTH * 4, bc)
        elif bytes[1] == 1:
            setbytes(self.mons, bytes, PARTYMON_STRUCT_LENGTH * 2, bc,
                     PARTYMON_STRUCT_LENGTH * 4)
            bc += PARTYMON_STRUCT_LENGTH * 2
            setbytes(self.ot, bytes, NAME_LENGTH * PARTY_LENGTH, bc)
            bc += NAME_LENGTH * PARTY_LENGTH
            setbytes(self.nicks, bytes, MON_NAME_LENGTH * PARTY_LENGTH, bc)

@dataclass
class Battle:
    battleid: int
    log: bytearray()
    rng: bytearray(RNG_LENGTH)
    lock: threading.RLock()
    host: int = 0
    client: int = 0
    host_accepted: bool = True
    client_accepted: bool = False
    host_action: int = 0xFF
    client_action: int = 0xFF
    host_offset: int = 0
    client_offset: int = 0

    def is_host(self, user):
        if user == users[self.host]:
            return True
        return False

    def otheruser(self, user) -> User:
        if self.is_host(user):
            return users[self.client]
        return users[self.host]

    def get_action(self, user) -> int:
        if self.is_host(user):
            return self.host_action
        return self.client_action

    def set_action(self, user, action) -> bool:
        opp = self.otheruser(user)
        if self.get_offset(user) < self.get_offset(opp):
            return False

        # First battle turn has no RNG requests
        if self.get_offset(user) == 0:
            action &= 0x0F

        if self.is_host(user):
            self.host_action = action
        else:
            self.client_action = action
        return True

    def get_offset(self, user):
        if self.is_host(user):
            return self.host_offset
        return self.client_offset

    def set_offset(self, user, offset):
        if self.is_host(user):
            self.host_offset = offset
        else:
            self.client_offset = offset

    def add_offset(self, user, offset):
        prev_offset = self.get_offset(user)
        self.set_offset(user, offset + prev_offset)

    def pending_input_trade(self, user) -> bytearray():
        opp = self.otheruser(user)
        ret = bytearray()
        action = self.get_action(user) & 0xF
        action_opp = self.get_action(opp) & 0xF

        # Check if we are ready for sending battle data
        if self.get_offset(user) < self.get_offset(opp):
            # The other user has already received the battle data for this turn.
            # Send from the battle log.

            # Append this decision
            ret.append(self.log[self.get_offset(user)])

            # Move offset to next turn
            self.add_offset(user, 1)

            # Set action as unperformed for next turn
            self.set_action(user, 0xFF)
            return ret

        # Check if both users have made their decision
        if (self.get_offset(user) == self.get_offset(opp) and
            self.get_action(user) != 0xFF and
            self.get_action(opp) != 0xFF):

            self.log.append(self.get_action(user))

           # Send trade turn to user
            ret.append(self.get_action(opp))
            self.add_offset(user, 1)

            # Set action as unperformed for next turn
            self.set_action(user, 0xFF)
            return ret

        # Otherwise, just send 0xFF
        ret.append(0xFF)
        return ret

    # Returns a bytearray of battle turn data to send
    def pending_input(self, user) -> bytearray():
        opp = self.otheruser(user)
        ret = bytearray()

        rng_bytes = self.get_action(user) >> 4
        rng_bytes_opp = self.get_action(opp) >> 4
        action = self.get_action(user) & 0xF
        action_opp = self.get_action(opp) & 0xF

        # Check if we are ready for sending battle data
        if self.get_offset(user) < self.get_offset(opp):
            # The other user has already received the battle data for this turn.
            # Send from the battle log.

            # Skip logged RNG bytes
            self.add_offset(user, rng_bytes)

            # Append this decision
            ret.append(self.log[self.get_offset(user)])

            # Move offset to next turn
            self.add_offset(user, 1)

            # Set action as unperformed for next turn
            self.set_action(user, 0xFF)

            # Append RNG stream
            ret.extend(self.rng)
            return ret

        # Check if both users have made their decision
        if (self.get_offset(user) == self.get_offset(opp) and
            self.get_action(user) != 0xFF and
            self.get_action(opp) != 0xFF):
            # TODO: We can use the higher nibble in each action as simple
            # desync detection. Currently, however, we don't

            # Extend battle log with the used amount of RNG bytes
            self.log.extend(self.rng[:rng_bytes])

            # Set offset past RNG bytes
            self.add_offset(user, rng_bytes)

            # Append battle turn decision
            turn_action = (action << 4) | (action_opp)
            if not self.is_host(user):
                turn_action = (((turn_action & 0x0F) << 4) |
                               ((turn_action & 0xF0) >> 4))
            self.log.append(turn_action)

            # Send battle turn to user
            ret.append(turn_action)
            self.add_offset(user, 1)

            # Set action as unperformed for next turn
            self.set_action(user, 0xFF)

            # Generate a new set of random numbers
            self.rng = secrets.token_bytes(RNG_LENGTH)
            ret.extend(self.rng)
            return ret

        # Otherwise, just send 0xFF
        ret.append(0xFF)
        return ret

#                ID   Name          Party                     Nicks+OT
SERIALIZED_USER = 2 + NAME_LENGTH + (PARTYMON_STRUCT_LENGTH + NAME_LENGTH * 2) * PARTY_LENGTH

users = []
ulock = threading.RLock()
battles = []
block = threading.RLock()

def addbattle() -> int:
    block.acquire()
    battlecount = len(battles)
    log = bytearray()
    rng = bytearray(RNG_LENGTH)
    lock = threading.RLock()
    battles.append(Battle(battlecount, log, rng, lock))
    ret = battlecount
    block.release()
    return ret

def is_battler(battleid, userid) -> bool:
    # Is this a valid battle ID?
    if (battleid == 0):
        return False

    # If so, check if given user is a battler
    if battles[battleid].host == userid or battles[battleid].client == userid:
        return True
    return False

def adduser() -> int:
    ulock.acquire()
    usercount = len(users)
    name = bytearray(NAME_LENGTH)
    mons = bytearray(PARTYMON_STRUCT_LENGTH * PARTY_LENGTH)
    ot = bytearray(NAME_LENGTH * PARTY_LENGTH)
    nicks = bytearray(MON_NAME_LENGTH * PARTY_LENGTH)
    lock = threading.RLock()
    users.append(User(usercount, name, mons, ot, nicks, lock))
    ret = usercount
    ulock.release()
    return ret

def lock_users(*userlist) -> bool:
    # First check that all user IDs are valid
    for user in userlist:
        if len(users) <= user:
            return False

    # Lock all user threads
    for user in userlist:
        users[user].lock.acquire()

    return True

def release_users(*userlist) -> bool:
    # First check that all user IDs are valid
    for user in userlist:
        if len(users) <= user:
            return False

    # Release all user threads
    for user in userlist:
        users[user].lock.release()

    return True

def connected(userid) -> bool:
    if len(users) <= userid:
        return False
    return users[userid].connected

def may_battle(userid, target) -> int:
    if not lock_users(userid, target):
        return PO_ERROR_UNKNUSER

    try:
        # Verify that both are connected
        if not connected(userid) or not connected(target):
            return PO_ERROR_UNKNUSER

        # You can't battle with yourself
        if userid == target:
            return PO_ERROR_UNAUTHORIZED

        # A battleid of -1 means they're busy trading
        userbattle = users[userid].battleid
        targetbattle = users[target].battleid
        if userbattle == -1 or targetbattle == -1:
            return PO_ERROR_WITHANOTHER

        # If their battle IDs are equal (free, or same ID), we may battle them
        if userbattle == targetbattle:
            return PO_ERROR_OK

        # If there was a pending battle between the 2, someone rejected
        if ((userbattle != 0 and is_battler(userbattle, target)) or
            targetbattle != 0 and is_battler(targetbattle, userid)):
            return PO_ERROR_REJECTED

        # Otherwise, someone is battling another
        return PO_ERROR_WITHANOTHER

    finally:
        release_users(userid, target)

# dummy entries so array index and id coincide
adduser()
users[0].connected = False
addbattle()

def requestdata(client, data, length = 1):
    prevlen = len(data)
    while (prevlen < length):
        data.extend(client.csocket.recv(256))
        if len(data) == prevlen:
            raise UserDisconnected
        prevlen = len(data)

def disconnect(client, userid, raiseException = True):
    if users[userid].connected:
        client.csocket.close()
        users[userid].connected = False
        users[userid].battleid = -1
        if raiseException:
            raise UserDisconnected

class ClientThread(threading.Thread):
    def __init__(self,clientAddress,clientsocket):
        threading.Thread.__init__(self)
        self.csocket = clientsocket
    def run(self):
        userid = adduser()
        print("New user", clientAddress, "connected:", userid)
        try:
            while True:
                data = bytearray()
                requestdata(self, data)

                # Check if we disconnected
                if len(data) == 0:
                    break

                response = bytearray()

                # Replaced with size of content later
                response.append(0)

                # We typically want to response beginning with the command
                response.append(data[0])

                # Check if we should signal for a battle request
                battleid = users[userid].battleid
                signal = bytearray()
                if (battleid > 0 and is_battler(battleid, userid) and
                    (data[0] == PO_CMD_LISTUSERS or
                     data[0] == PO_CMD_BATTLEUSER or
                     data[0] == PO_CMD_TRADEUSER)):
                    same_target = False

                    # No need to ask if BATTLEUSER target is the same
                    if data[0] == PO_CMD_BATTLEUSER:
                        requestdata(self, data, 2)
                        if is_battler(battleid, data[1]):
                            same_target = True

                    if not same_target:
                        target = 0
                        if userid == battles[battleid].host:
                            target = battles[battleid].client
                        else:
                            target = battles[battleid].host

                        signal.append(0)
                        if data[0] == PO_CMD_BATTLEUSER:
                            signal.append(PO_SIGNAL_ASKBATTLE)
                        else:
                            signal.append(PO_SIGNAL_ASKTRADE)
                        signal.append(target)

                if len(signal) > 0:
                    response = signal
                elif data[0] == PO_CMD_STATUS:
                    print(userid, ">>> Status")
                    response.append(userid)

                elif data[0] == PO_CMD_DISCONNECT:
                    print(userid, ">>> Disconnect")
                    disconnect(self, userid)

                elif data[0] == PO_CMD_SETINFO:
                    print(userid, ">>> Set info")
                    lock_users(userid)
                    reqlen = 2
                    requestdata(self, data, reqlen)
                    if data[1] == 0:
                        # first half
                        reqlen += 4 # player ID + party size + gender
                        reqlen += NAME_LENGTH # player name
                        reqlen += PARTYMON_STRUCT_LENGTH * 4 # 4 mons
                    elif data[1] == 1:
                        reqlen += PARTYMON_STRUCT_LENGTH * 2 # 2 mons
                        reqlen += NAME_LENGTH * PARTY_LENGTH # otnames
                        reqlen += NAME_LENGTH * PARTY_LENGTH # nicknames
                    requestdata(self, data, reqlen)
                    users[userid].unserialize(data)
                    release_users(userid)

                elif data[0] == PO_CMD_GETINFO:
                    print(userid, ">>> Get info")
                    requestdata(self, data, 3)
                    target = data[1]
                    ret = bytearray()
                    if not lock_users(target):
                        response[1] = PO_SIGNAL_ERROR
                        response.append(PO_ERROR_UNKNUSER)
                    else:
                        ret = users[target].serialize()

                    if len(ret) > 0:
                        reqlen = 0
                        reqlen += 4 # player ID + party size + gender
                        reqlen += NAME_LENGTH # player name
                        reqlen += PARTYMON_STRUCT_LENGTH * 4 # 4 mons

                        # Check which half to return
                        if data[2] == 0:
                            response.extend(ret[:reqlen])
                        else:
                            response.extend(ret[reqlen:])
                        release_users(target)

                elif data[0] == PO_CMD_LISTUSERS:
                    # stores user list
                    print(userid, ">>> List users")
                    response.append(0)

                    # don't allow messing with the user list meanwhile
                    ulock.acquire()
                    for user in users:
                        if not user.connected:
                            continue
                        response[2] += 1
                        response.append(user.userid)
                        response.append(user.otid >> 8)
                        response.append(user.otid & 0xFF)
                        response.extend(user.name)
                    ulock.release()

                elif data[0] == PO_CMD_TRADEUSER:
                    # who do we want to battle
                    print(userid, ">>> Trade user")
                    requestdata(self, data, 2)
                    target = data[1]
                    lock_users(userid, target)
                    block.acquire()
                    errcode = may_battle(userid, target)
                    if errcode == PO_ERROR_OK:
                        if battleid > 0:
                            # Mark ourself as having accepted the battle
                            if userid == battles[battleid].host:
                                battles[battleid].host_accepted = True
                            else:
                                battles[battleid].client_accepted = True
                        else:
                            battleid = addbattle()
                            battles[battleid].host = userid
                            battles[battleid].client = target
                            users[userid].battleid = battleid
                            users[target].battleid = battleid

                        if (battles[battleid].host_accepted and
                            battles[battleid].client_accepted):
                            response.append(battles[battleid].host)
                            response.append(battles[battleid].client)
                        else:
                            response.append(0)
                    else:
                        response[1] = PO_SIGNAL_ERROR
                        response.append(errcode)

                    block.release()
                    release_users(userid, target)

                elif data[0] == PO_CMD_BATTLEUSER:
                    # who do we want to battle
                    print(userid, ">>> Battle user")
                    requestdata(self, data, 2)
                    target = data[1]
                    lock_users(userid, target)
                    block.acquire()
                    errcode = may_battle(userid, target)
                    if errcode == PO_ERROR_OK:
                        if battleid > 0:
                            # Mark ourself as having accepted the battle
                            if userid == battles[battleid].host:
                                battles[battleid].host_accepted = True
                            else:
                                battles[battleid].client_accepted = True
                        else:
                            battleid = addbattle()
                            battles[battleid].host = userid
                            battles[battleid].client = target
                            users[userid].battleid = battleid
                            users[target].battleid = battleid

                        if (battles[battleid].host_accepted and
                            battles[battleid].client_accepted):
                            response.append(battles[battleid].host)
                            response.append(battles[battleid].client)
                        else:
                            response.append(0)
                    else:
                        response[1] = PO_SIGNAL_ERROR
                        response.append(errcode)

                    block.release()
                    release_users(userid, target)

                elif data[0] == PO_CMD_BATTLETURN:
                    print(userid, ">>> Battle turn")
                    requestdata(self, data, 2)
                    if (battleid == 0 or not is_battler(battleid, userid) or
                        not battles[battleid].host_accepted or
                        not battles[battleid].client_accepted):
                        response[1] = PO_SIGNAL_ERROR
                        response.append(PO_ERROR_UNAUTHORIZED)
                    else:
                        battle = battles[battleid]
                        battle.lock.acquire()
                        user = users[userid]
                        opp = battle.otheruser(user)
                        battle.set_action(user, data[1])
                        response.extend(battle.pending_input(user))
                        battle.lock.release()

                elif data[0] == PO_CMD_TRADETURN:
                    print(userid, ">>> Trade turn")
                    requestdata(self, data, 2)
                    if (battleid == 0 or not is_battler(battleid, userid) or
                        not battles[battleid].host_accepted or
                        not battles[battleid].client_accepted):
                        response[1] = PO_SIGNAL_ERROR
                        response.append(PO_ERROR_UNAUTHORIZED)
                    else:
                        battle = battles[battleid]
                        battle.lock.acquire()
                        user = users[userid]
                        opp = battle.otheruser(user)
                        battle.set_action(user, data[1])
                        response.extend(battle.pending_input_trade(user))
                        battle.lock.release()

                elif data[0] == PO_CMD_SETREPLY:
                    print(userid, ">>> Set invite reply")
                    lock_users(userid)
                    requestdata(self, data, 2)

                    # no battle, or we're spectating
                    if battleid == 0 or not is_battler(battleid, userid):
                        response[1] = PO_SIGNAL_ERROR
                        response.append(PO_ERROR_UNAUTHORIZED)
                    else:
                        if data[1] == PO_REPLY_REJECT:
                            users[userid].battleid = 0
                            response.append(0)
                        else:
                            target = battles[battleid].host
                            if userid == target:
                                target = battles[battleid].client

                            # Mark us as having accepted the invite, if not
                            # already marked
                            if data[1] == PO_REPLY_ACCEPT:
                                if userid == battles[battleid].host:
                                    battles[battleid].host_accepted = True
                                else:
                                    battles[battleid].client_accepted = True

                            errcode = may_battle(userid, target)
                            if errcode != PO_ERROR_OK:
                                response[1] = PO_SIGNAL_ERROR
                                response.append(errcode)
                            elif (battles[battleid].host_accepted and
                                  battles[battleid].client_accepted):
                                response.append(battles[battleid].host)
                                response.append(battles[battleid].client)
                            else:
                                response.append(0)

                    release_users(userid)

                else:
                    print(userid, ">>> Unknown command", bytes2hexstr(data))
                    response[1] = PO_SIGNAL_ERROR
                    response.append(PO_ERROR_UNKNCMD)

                response[0] = len(response) - 1
                print(userid, ">>>", bytes2hexstr(data))
                print(userid, "<<<", bytes2hexstr(response))
                self.csocket.send(response)

        except UserDisconnected:
            print("Client at", clientAddress, "disconnected.")
            disconnect(self, userid, False)

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(('0.0.0.0', PO_PORT))
print("Server started")
while True:
    server.listen(1)
    clientsock, clientAddress = server.accept()
    newthread = ClientThread(clientAddress, clientsock)
    newthread.start()
