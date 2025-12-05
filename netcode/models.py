"""Core dataclasses mirroring the legacy globals in ``testserver.py``."""

from __future__ import annotations

import secrets
from dataclasses import dataclass, field
from threading import RLock
from typing import ByteString, Optional

from . import constants, serialization

_FIRST_PARTY_MON_BYTES = constants.PARTYMON_STRUCT_LENGTH * 4
_REMAINING_PARTY_MON_BYTES = constants.PARTYMON_STRUCT_LENGTH * 2
_OT_BLOCK_BYTES = constants.NAME_LENGTH * constants.PARTY_LENGTH
_NICK_BLOCK_BYTES = constants.MON_NAME_LENGTH * constants.PARTY_LENGTH
_MAIL_BLOCK_BYTES = constants.MAIL_STRUCT_LENGTH * constants.PARTY_LENGTH
_MAIL_CHUNK_OFFSET = constants.MAIL_STRUCT_LENGTH * 5


@dataclass(slots=True)
class User:
    """Server-side representation of a connected cartridge."""

    user_id: int
    name: bytearray = field(default_factory=lambda: bytearray(constants.NAME_LENGTH))
    mons: bytearray = field(
        default_factory=lambda: bytearray(constants.PARTYMON_STRUCT_LENGTH * constants.PARTY_LENGTH)
    )
    ot_names: bytearray = field(default_factory=lambda: bytearray(constants.NAME_LENGTH * constants.PARTY_LENGTH))
    nicknames: bytearray = field(default_factory=lambda: bytearray(constants.MON_NAME_LENGTH * constants.PARTY_LENGTH))
    mail: bytearray = field(default_factory=lambda: bytearray(constants.MAIL_STRUCT_LENGTH * constants.PARTY_LENGTH))
    lock: RLock = field(default_factory=RLock, repr=False)
    party_count: int = 0
    gender: int = 0
    otid: int = 0
    connected: bool = True
    battle_id: int = 0
    info_version: int = 0
    pending_error: constants.Error = constants.Error.OK

    def serialize_full(self) -> bytes:
        """Return the entire serialized struct used by ``PO_CMD_GETINFO``."""

        buf = bytearray(constants.SERIALIZED_USER)
        serialization.write_uint16(buf, self.otid, 0)
        buf[2] = self.party_count & 0xFF
        buf[3] = self.gender & 0xFF
        serialization.copy_bytes(buf, self.name, length=constants.NAME_LENGTH, dst_offset=4)
        serialization.copy_bytes(buf, self.mons, length=len(self.mons), dst_offset=4 + constants.NAME_LENGTH)

        offset = 4 + constants.NAME_LENGTH + len(self.mons)
        serialization.copy_bytes(buf, self.ot_names, length=len(self.ot_names), dst_offset=offset)
        offset += len(self.ot_names)
        serialization.copy_bytes(buf, self.nicknames, length=len(self.nicknames), dst_offset=offset)
        offset += len(self.nicknames)
        serialization.copy_bytes(buf, self.mail, length=len(self.mail), dst_offset=offset)
        return bytes(buf)

    def serialize_chunk(self, chunk_id: int) -> bytes:
        """Return one of the four upload/download chunks."""

        size = serialization.user_chunk_size(chunk_id)
        buf = bytearray(size)
        if chunk_id == 0:
            serialization.write_uint16(buf, self.otid, 0)
            buf[2] = self.party_count & 0xFF
            buf[3] = self.gender & 0xFF
            serialization.copy_bytes(buf, self.name, length=constants.NAME_LENGTH, dst_offset=4)
            serialization.copy_bytes(
                buf,
                self.mons,
                length=_FIRST_PARTY_MON_BYTES,
                src_offset=0,
                dst_offset=4 + constants.NAME_LENGTH,
            )
        elif chunk_id == 1:
            serialization.copy_bytes(buf, self.mons, length=_REMAINING_PARTY_MON_BYTES, src_offset=_FIRST_PARTY_MON_BYTES)
            offset = _REMAINING_PARTY_MON_BYTES
            serialization.copy_bytes(buf, self.ot_names, length=_OT_BLOCK_BYTES, dst_offset=offset)
            offset += _OT_BLOCK_BYTES
            serialization.copy_bytes(buf, self.nicknames, length=_NICK_BLOCK_BYTES, dst_offset=offset)
        elif chunk_id == 2:
            serialization.copy_bytes(buf, self.mail, length=constants.MAIL_STRUCT_LENGTH * 5)
        elif chunk_id == 3:
            serialization.copy_bytes(
                buf,
                self.mail,
                length=constants.MAIL_STRUCT_LENGTH,
                src_offset=_MAIL_CHUNK_OFFSET,
            )
        else:  # pragma: no cover - guarded by ``user_chunk_size``
            raise ValueError(f"unknown chunk id {chunk_id}")
        return bytes(buf)

    def apply_chunk(self, chunk_id: int, payload: ByteString) -> None:
        """Apply an uploaded chunk, validating its size and contents."""

        serialization.assert_user_chunk_length(chunk_id, payload)
        view = memoryview(payload)
        if chunk_id == 0:
            self.otid = serialization.read_uint16(view, 0)
            party_count = view[2]
            if not 0 <= party_count <= constants.PARTY_LENGTH:
                raise ValueError("party count exceeds legal bounds")
            self.party_count = party_count
            self.gender = view[3] & 0xFF
            serialization.copy_bytes(self.name, view, length=constants.NAME_LENGTH, src_offset=4)
            serialization.copy_bytes(
                self.mons,
                view,
                length=_FIRST_PARTY_MON_BYTES,
                dst_offset=0,
                src_offset=4 + constants.NAME_LENGTH,
            )
        elif chunk_id == 1:
            serialization.copy_bytes(
                self.mons,
                view,
                length=_REMAINING_PARTY_MON_BYTES,
                dst_offset=_FIRST_PARTY_MON_BYTES,
                src_offset=0,
            )
            offset = _REMAINING_PARTY_MON_BYTES
            serialization.copy_bytes(self.ot_names, view, length=_OT_BLOCK_BYTES, src_offset=offset)
            offset += _OT_BLOCK_BYTES
            serialization.copy_bytes(self.nicknames, view, length=_NICK_BLOCK_BYTES, src_offset=offset)
        elif chunk_id == 2:
            serialization.copy_bytes(self.mail, view, length=constants.MAIL_STRUCT_LENGTH * 5)
        elif chunk_id == 3:
            serialization.copy_bytes(
                self.mail,
                view,
                length=constants.MAIL_STRUCT_LENGTH,
                dst_offset=_MAIL_CHUNK_OFFSET,
            )
        else:  # pragma: no cover - guarded by ``assert_user_chunk_length``
            raise ValueError(f"unknown chunk id {chunk_id}")

        self.info_version += 1

    def serialize_partial(self, chunk_id: int) -> bytes:
        """Alias for ``serialize_chunk`` to match legacy naming."""

        return self.serialize_chunk(chunk_id)


@dataclass(slots=True)
class Battle:
    """In-memory battle/trade session."""

    battle_id: int
    host_id: int
    client_id: int
    is_trade: bool = False
    host_accepted: bool = False
    client_accepted: bool = False
    host_action: int = 0xFF
    client_action: int = 0xFF
    host_offset: int = 0
    client_offset: int = 0
    rng: bytearray = field(default_factory=lambda: bytearray(constants.RNG_LENGTH))
    log: bytearray = field(default_factory=bytearray)
    lock: RLock = field(default_factory=RLock, repr=False)

    def other_user_id(self, user_id: int) -> int:
        self._ensure_participant(user_id)
        return self.client_id if user_id == self.host_id else self.host_id

    def is_host(self, user_id: int) -> bool:
        self._ensure_participant(user_id)
        return user_id == self.host_id

    def get_action(self, user_id: int) -> int:
        return self.host_action if self.is_host(user_id) else self.client_action

    def set_action(self, user_id: int, action: int) -> bool:
        """Record the player's intent; returns False if we're still replaying."""

        if not 0 <= action <= 0xFF:
            raise ValueError("actions must be single bytes")
        opp_id = self.other_user_id(user_id)
        if self.get_offset(user_id) < self.get_offset(opp_id):
            return False
        if self.get_offset(user_id) == 0:
            action &= 0x0F
        if self.is_host(user_id):
            self.host_action = action
        else:
            self.client_action = action
        return True

    def get_offset(self, user_id: int) -> int:
        self._ensure_participant(user_id)
        return self.host_offset if self.is_host(user_id) else self.client_offset

    def set_offset(self, user_id: int, offset: int) -> None:
        if not 0 <= offset <= 0xFFFF:
            raise ValueError("offset must fit in 16 bits")
        if self.is_host(user_id):
            self.host_offset = offset
        else:
            self.client_offset = offset

    def add_offset(self, user_id: int, delta: int) -> None:
        self.set_offset(user_id, self.get_offset(user_id) + delta)

    def pending_input_trade(self, user_id: int) -> bytearray:
        """Return pending trade data for ``user_id`` following legacy rules."""

        opp_id = self.other_user_id(user_id)
        ret = bytearray()
        action = self.get_action(user_id) & 0xF
        action_opp = self.get_action(opp_id) & 0xF

        if self.get_offset(user_id) < self.get_offset(opp_id):
            ret.append(self.log[self.get_offset(user_id)])
            self.add_offset(user_id, 1)
            self._reset_action(user_id)
            return ret

        if (
            self.get_offset(user_id) == self.get_offset(opp_id)
            and self.get_action(user_id) != 0xFF
            and self.get_action(opp_id) != 0xFF
        ):
            self.log.append(self.get_action(user_id))
            ret.append(self.get_action(opp_id))
            self.add_offset(user_id, 1)
            self._reset_action(user_id)
            return ret

        ret.append(0xFF)
        return ret

    def pending_input(self, user_id: int) -> bytearray:
        """Return pending battle turn data for ``user_id``.

        Hosts always see their intent in the high nibble and the opponent's
        action in the low nibble; clients see the inverse. This mirrors
        ``testserver.py`` so the wire format stays stable.
        """

        opp_id = self.other_user_id(user_id)
        ret = bytearray()
        rng_bytes = self.get_action(user_id) >> 4
        action = self.get_action(user_id) & 0xF
        action_opp = self.get_action(opp_id) & 0xF

        if self.get_offset(user_id) < self.get_offset(opp_id):
            self.add_offset(user_id, rng_bytes)
            ret.append(self.log[self.get_offset(user_id)])
            self.add_offset(user_id, 1)
            self._reset_action(user_id)
            ret.extend(self.rng)
            return ret

        if (
            self.get_offset(user_id) == self.get_offset(opp_id)
            and self.get_action(user_id) != 0xFF
            and self.get_action(opp_id) != 0xFF
        ):
            self.log.extend(self.rng[:rng_bytes])
            self.add_offset(user_id, rng_bytes)
            turn_action = (action << 4) | action_opp
            if not self.is_host(user_id):
                turn_action = ((turn_action & 0x0F) << 4) | ((turn_action & 0xF0) >> 4)
            self.log.append(turn_action)
            ret.append(turn_action)
            self.add_offset(user_id, 1)
            self._reset_action(user_id)
            self._refresh_rng()
            ret.extend(self.rng)
            return ret

        ret.append(0xFF)
        return ret

    def _refresh_rng(self) -> None:
        self.rng = bytearray(secrets.token_bytes(constants.RNG_LENGTH))

    def _reset_action(self, user_id: int) -> None:
        if self.is_host(user_id):
            self.host_action = 0xFF
        else:
            self.client_action = 0xFF

    def _ensure_participant(self, user_id: int) -> None:
        if user_id not in (self.host_id, self.client_id):
            raise ValueError(f"user {user_id} is not part of battle {self.battle_id}")


@dataclass(slots=True)
class Session:
    """Wraps the transport socket plus bookkeeping for a single client."""

    sock: object
    user_id: Optional[int] = None
    recv_buffer: bytearray = field(default_factory=bytearray)
    send_buffer: bytearray = field(default_factory=bytearray)
