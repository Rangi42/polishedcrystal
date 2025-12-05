from __future__ import annotations

import logging

from netcode import constants
from netcode.handlers import lists
from netcode.handlers.base import CommandContext
from netcode.models import Session
from netcode.settings import Settings
from netcode.state import ServerState


def test_handle_list_users_counts_only_connected() -> None:
    state = ServerState()
    user = state.add_user()
    user.name[:] = b"ASH" + b"\x00" * (constants.NAME_LENGTH - 3)
    user.otid = 0x1234
    other = state.add_user()
    other.connected = False

    ctx = CommandContext(
        state=state,
        session=Session(sock=None),
        settings=Settings(),
        logger=logging.getLogger(__name__),
    )

    response = lists.handle_list_users(ctx, bytearray([constants.Command.LISTUSERS]))
    assert response[1] == constants.Command.LISTUSERS
    assert response[2] == 1
    assert response[3] == user.user_id & 0xFF
    assert response[4:6] == bytes([0x12, 0x34])
    assert response[6 : 6 + constants.NAME_LENGTH] == bytes(user.name)
