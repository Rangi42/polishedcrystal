"""Integration-style tests that speak the legacy socket protocol."""

from __future__ import annotations

import socket
import threading

from netcode import constants
from netcode.metrics import InMemoryMetrics
from netcode.models import User
from netcode.server import serve
from netcode.settings import Settings
from netcode.state import ServerState
from netcode.storage import InMemoryUserRepository


def _pattern(length: int, seed: int) -> bytes:
    return bytes(((seed + i) & 0xFF for i in range(length)))


def _build_sample_user(user_id: int, *, label: str = "RED") -> User:
    user = User(user_id=user_id)
    user.otid = 0xBEEF
    user.gender = 1
    user.party_count = 2
    encoded = label.encode("ascii")[: constants.NAME_LENGTH]
    user.name[:] = encoded + b"\x00" * (constants.NAME_LENGTH - len(encoded))
    user.mons[:] = _pattern(len(user.mons), 0x10)
    user.ot_names[:] = _pattern(len(user.ot_names), 0x40)
    user.nicknames[:] = _pattern(len(user.nicknames), 0x60)
    user.mail[:] = _pattern(len(user.mail), 0x80)
    return user


def _start_server(state: ServerState, settings: Settings) -> tuple[threading.Event, threading.Thread]:
    stop_event = threading.Event()
    ready_event = threading.Event()
    thread = threading.Thread(
        target=serve,
        kwargs={
            "settings": settings,
            "state": state,
            "metrics": InMemoryMetrics(),
            "stop_event": stop_event,
            "ready_event": ready_event,
        },
        daemon=True,
    )
    thread.start()
    started = ready_event.wait(timeout=5)
    assert started, "server failed to bind in time"
    return stop_event, thread


def _send_and_receive(sock: socket.socket, command: constants.Command, payload: bytes = b"") -> bytes:
    message = bytes((int(command),)) + payload
    sock.sendall(message)
    return _read_response(sock)


def _read_response(sock: socket.socket) -> bytes:
    header = sock.recv(1)
    if not header:
        raise AssertionError("socket closed before response header")
    remaining = header[0]
    payload = bytearray()
    while len(payload) < remaining:
        chunk = sock.recv(remaining - len(payload))
        if not chunk:
            raise AssertionError("socket closed before response payload")
        payload.extend(chunk)
    return bytes(payload)


def _connect_client(settings: Settings) -> tuple[socket.socket, int]:
    sock = socket.create_connection((settings.host, settings.port), timeout=2)
    status = _send_and_receive(sock, constants.Command.STATUS)
    assert status[0] == constants.Command.STATUS
    user_id = status[1]
    assert user_id != 0
    return sock, user_id


def _upload_profile(sock: socket.socket, user: User) -> None:
    for chunk_id in range(4):
        payload = bytes([chunk_id]) + user.serialize_chunk(chunk_id)
        response = _send_and_receive(sock, constants.Command.SETINFO, payload)
        assert response[0] == constants.Command.SETINFO


def _battle_turn(sock: socket.socket, action: int) -> bytes:
    return _send_and_receive(sock, constants.Command.BATTLETURN, bytes([action & 0xFF]))


def _trade_turn(sock: socket.socket, action: int) -> bytes:
    return _send_and_receive(sock, constants.Command.TRADETURN, bytes([action & 0xFF]))


def test_server_handles_status_setinfo_and_listusers():
    settings = Settings(host="127.0.0.1", port=0, client_timeout=1.0)
    repository = InMemoryUserRepository()
    state = ServerState(user_repository=repository)
    stop_event, thread = _start_server(state, settings)

    client = None
    try:
        client, user_id = _connect_client(settings)
        sample = _build_sample_user(user_id)
        _upload_profile(client, sample)

        listing = _send_and_receive(client, constants.Command.LISTUSERS)
        assert listing[0] == constants.Command.LISTUSERS
        assert listing[1] == 1  # only the current user is online
        assert listing[2] == user_id
        otid = (listing[3] << 8) | listing[4]
        assert otid == sample.otid
        name_start = listing[5 : 5 + constants.NAME_LENGTH]
        assert name_start.startswith(b"RED")

        assert user_id in repository.users
        persisted = repository.users[user_id]
        assert persisted.info_version == 4
        assert persisted.party_count == sample.party_count
    finally:
        if client is not None:
            client.close()
        stop_event.set()
        thread.join(timeout=5)


def test_server_handles_battle_and_trade_flow():
    settings = Settings(host="127.0.0.1", port=0, client_timeout=1.0)
    state = ServerState(user_repository=InMemoryUserRepository())
    stop_event, thread = _start_server(state, settings)

    sockets: list[socket.socket] = []
    try:
        host_sock, host_id = _connect_client(settings)
        client_sock, client_id = _connect_client(settings)
        sockets.extend([host_sock, client_sock])

        host_profile = _build_sample_user(host_id, label="RED")
        client_profile = _build_sample_user(client_id, label="BLU")
        _upload_profile(host_sock, host_profile)
        _upload_profile(client_sock, client_profile)

        chunk = _send_and_receive(client_sock, constants.Command.GETINFO, bytes([host_id & 0xFF, 0]))
        assert chunk[0] == constants.Command.GETINFO
        assert chunk[1:] == host_profile.serialize_chunk(0)
        version = _send_and_receive(client_sock, constants.Command.GETINFO_VER, bytes([host_id & 0xFF]))
        assert version[0] == constants.Command.GETINFO_VER
        assert version[1] == 4  # four chunks uploaded this session

        battle_request = _send_and_receive(host_sock, constants.Command.BATTLEUSER, bytes([client_id & 0xFF]))
        assert battle_request[0] == constants.Command.BATTLEUSER
        assert battle_request[1] == 0

        wait_ping = _send_and_receive(host_sock, constants.Command.SETREPLY, bytes([constants.Reply.WAIT]))
        assert wait_ping[0] == constants.Command.SETREPLY
        assert wait_ping[1] == 0

        signal = _send_and_receive(client_sock, constants.Command.LISTUSERS)
        assert signal[0] == constants.Signal.ASKBATTLE
        assert signal[1] == (host_id & 0xFF)

        reply_client = _send_and_receive(client_sock, constants.Command.SETREPLY, bytes([constants.Reply.ACCEPT]))
        assert reply_client[0] == constants.Command.SETREPLY
        assert reply_client[1] == (host_id & 0xFF)
        assert reply_client[2] == (client_id & 0xFF)
        reply_host = _send_and_receive(host_sock, constants.Command.SETREPLY, bytes([constants.Reply.ACCEPT]))
        assert reply_host[0] == constants.Command.SETREPLY
        assert reply_host[1] == (host_id & 0xFF)
        assert reply_host[2] == (client_id & 0xFF)

        host_first = _battle_turn(host_sock, 0x05)
        assert host_first[0] == constants.Command.BATTLETURN
        assert host_first[1] == 0xFF
        client_first = _battle_turn(client_sock, 0x07)
        assert client_first[0] == constants.Command.BATTLETURN
        assert client_first[1] != 0xFF
        host_catchup = _battle_turn(host_sock, 0x00)
        assert host_catchup[0] == constants.Command.BATTLETURN
        assert host_catchup[1] == client_first[1]

        host_sock.close()
        client_sock.close()

        trader_sock, trader_id = _connect_client(settings)
        tradee_sock, tradee_id = _connect_client(settings)
        sockets.extend([trader_sock, tradee_sock])

        trader_profile = _build_sample_user(trader_id, label="GRN")
        tradee_profile = _build_sample_user(tradee_id, label="YLW")
        _upload_profile(trader_sock, trader_profile)
        _upload_profile(tradee_sock, tradee_profile)

        trade_request = _send_and_receive(trader_sock, constants.Command.TRADEUSER, bytes([tradee_id & 0xFF]))
        assert trade_request[0] == constants.Command.TRADEUSER
        assert trade_request[1] == 0

        trade_wait = _send_and_receive(trader_sock, constants.Command.SETREPLY, bytes([constants.Reply.WAIT]))
        assert trade_wait[0] == constants.Command.SETREPLY
        assert trade_wait[1] == 0

        trade_signal = _send_and_receive(tradee_sock, constants.Command.LISTUSERS)
        assert trade_signal[0] == constants.Signal.ASKTRADE
        assert trade_signal[1] == (trader_id & 0xFF)

        trade_reply_client = _send_and_receive(tradee_sock, constants.Command.SETREPLY, bytes([constants.Reply.ACCEPT]))
        assert trade_reply_client[0] == constants.Command.SETREPLY
        assert trade_reply_client[1] == (trader_id & 0xFF)
        assert trade_reply_client[2] == (tradee_id & 0xFF)
        trade_reply_host = _send_and_receive(trader_sock, constants.Command.SETREPLY, bytes([constants.Reply.ACCEPT]))
        assert trade_reply_host[0] == constants.Command.SETREPLY
        assert trade_reply_host[1] == (trader_id & 0xFF)
        assert trade_reply_host[2] == (tradee_id & 0xFF)

        trade_host_first = _trade_turn(trader_sock, 0x02)
        assert trade_host_first[0] == constants.Command.TRADETURN
        assert trade_host_first[1] == 0xFF
        trade_client_first = _trade_turn(tradee_sock, 0x08)
        assert trade_client_first[0] == constants.Command.TRADETURN
        assert trade_client_first[1] == 0x02
        trade_host_catchup = _trade_turn(trader_sock, 0x00)
        assert trade_host_catchup[0] == constants.Command.TRADETURN
        assert trade_host_catchup[1] == 0x08
    finally:
        for sock in sockets:
            try:
                sock.close()
            except OSError:
                pass
        stop_event.set()
        thread.join(timeout=5)


def test_invitee_can_reject_battle_request() -> None:
    settings = Settings(host="127.0.0.1", port=0, client_timeout=1.0)
    state = ServerState(user_repository=InMemoryUserRepository())
    stop_event, thread = _start_server(state, settings)

    sockets: list[socket.socket] = []
    try:
        host_sock, host_id = _connect_client(settings)
        invitee_sock, invitee_id = _connect_client(settings)
        sockets.extend([host_sock, invitee_sock])

        _upload_profile(host_sock, _build_sample_user(host_id, label="RED"))
        _upload_profile(invitee_sock, _build_sample_user(invitee_id, label="BLU"))

        battle_request = _send_and_receive(host_sock, constants.Command.BATTLEUSER, bytes([invitee_id & 0xFF]))
        assert battle_request == bytes([constants.Command.BATTLEUSER, 0])

        invitee_signal = _send_and_receive(invitee_sock, constants.Command.LISTUSERS)
        assert invitee_signal == bytes([constants.Signal.ASKBATTLE, host_id & 0xFF])

        wait_response = _send_and_receive(host_sock, constants.Command.SETREPLY, bytes([constants.Reply.WAIT]))
        assert wait_response == bytes([constants.Command.SETREPLY, 0])

        reject_response = _send_and_receive(invitee_sock, constants.Command.SETREPLY, bytes([constants.Reply.REJECT]))
        assert reject_response == bytes([constants.Command.SETREPLY, 0])

        error_response = _send_and_receive(host_sock, constants.Command.SETREPLY, bytes([constants.Reply.WAIT]))
        assert error_response[0] == constants.Signal.ERROR
        assert error_response[1] == constants.Error.REJECTED
    finally:
        for sock in sockets:
            try:
                sock.close()
            except OSError:
                pass
        stop_event.set()
        thread.join(timeout=5)