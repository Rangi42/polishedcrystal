from __future__ import annotations

import logging

from netcode import constants
from netcode.handlers import battle
from netcode.handlers.base import CommandContext
from netcode.models import Session
from netcode.settings import Settings
from netcode.state import ServerState


def _build_ctx(state: ServerState, user_id: int) -> CommandContext:
    return CommandContext(
        state=state,
        session=Session(sock=None, user_id=user_id),
        settings=Settings(),
        logger=logging.getLogger(__name__),
    )


def _setup_battle(state: ServerState) -> tuple[int, int, int]:
    host = state.add_user()
    client = state.add_user()
    battle_obj = state.add_battle(host.user_id, client.user_id)
    host.battle_id = battle_obj.battle_id
    client.battle_id = battle_obj.battle_id
    return host.user_id, client.user_id, battle_obj.battle_id


def test_handle_set_reply_reject_clears_battle() -> None:
    state = ServerState()
    host_id, client_id, battle_id = _setup_battle(state)
    ctx = _build_ctx(state, client_id)

    response = battle.handle_set_reply(
        ctx,
        bytearray([constants.Command.SETREPLY, constants.Reply.REJECT]),
    )

    assert response[1] == constants.Command.SETREPLY
    assert response[2] == 0
    assert state.get_user(host_id).battle_id == 0
    assert state.get_user(client_id).battle_id == 0
    assert state.get_battle(battle_id) is None
    assert state.get_user(host_id).pending_error == constants.Error.REJECTED


def test_handle_set_reply_host_rejects_clears_battle() -> None:
    state = ServerState()
    host_id, client_id, battle_id = _setup_battle(state)
    ctx = _build_ctx(state, host_id)

    response = battle.handle_set_reply(
        ctx,
        bytearray([constants.Command.SETREPLY, constants.Reply.REJECT]),
    )

    assert response[1] == constants.Command.SETREPLY
    assert response[2] == 0
    assert state.get_user(host_id).battle_id == 0
    assert state.get_user(client_id).battle_id == 0
    assert state.get_battle(battle_id) is None


def test_handle_set_reply_wait_after_reject_returns_error() -> None:
    state = ServerState()
    host_id, client_id, _ = _setup_battle(state)
    reject_ctx = _build_ctx(state, client_id)
    battle.handle_set_reply(
        reject_ctx,
        bytearray([constants.Command.SETREPLY, constants.Reply.REJECT]),
    )

    wait_ctx = _build_ctx(state, host_id)
    response = battle.handle_set_reply(
        wait_ctx,
        bytearray([constants.Command.SETREPLY, constants.Reply.WAIT]),
    )

    assert response[1] == constants.Signal.ERROR
    assert response[2] == constants.Error.REJECTED
