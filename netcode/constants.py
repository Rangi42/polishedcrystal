"""Wire-level constants shared by the Game Boy link protocol and the server."""

from __future__ import annotations

from enum import IntEnum, unique

DEFAULT_HOST = "0.0.0.0"
DEFAULT_PORT = 57409

MON_NAME_LENGTH = 11
NAME_LENGTH = 11
PARTY_LENGTH = 6
BOXMON_STRUCT_LENGTH = 0x20
PARTYMON_STRUCT_LENGTH = 0x30
MAIL_STRUCT_LENGTH = 0x2F
RNG_LENGTH = 15
SERIALIZED_USER = 2 + NAME_LENGTH + (PARTYMON_STRUCT_LENGTH + NAME_LENGTH * 2) * PARTY_LENGTH


@unique
class Command(IntEnum):
    DISCONNECT = 0x00
    STATUS = 0x01
    WONDERTRADE = 0x02
    SETINFO = 0x03
    GETINFO = 0x04
    LISTUSERS = 0x05
    BATTLEUSER = 0x06
    TRADEUSER = 0x07
    GETBATTLE = 0x08
    BATTLETURN = 0x09
    TRADETURN = 0x0A
    SETREPLY = 0x0B
    GETINFO_VER = 0x0C


@unique
class Signal(IntEnum):
    ERROR = 0x81
    ASKBATTLE = 0x86
    ASKTRADE = 0x87


@unique
class Reply(IntEnum):
    ACCEPT = 0x00
    REJECT = 0x01
    WAIT = 0x02


@unique
class Error(IntEnum):
    OK = 0x00
    UNKNOWN_COMMAND = 0x01
    UNKNOWN_USER = 0x02
    BAD_INFO = 0x03
    INCOMPATIBLE = 0x04
    UNAUTHORIZED = 0x05
    BUSY = 0x06
    REJECTED = 0x07
    DESYNCED = 0x08
