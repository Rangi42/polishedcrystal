"""Handlers related to battles and battles' turn exchange."""

from __future__ import annotations

import logging

from .. import constants
from ..io import ResponseBuilder
from ..models import Battle, LinkType
from . import link
from .base import CommandContext
from .common import error_response


def handle_battle_user(ctx: CommandContext, data: bytearray) -> bytes:
    ctx.log(logging.DEBUG, "battle invite requested", command=constants.Command.BATTLEUSER)
    return link.matchmaking_request(ctx, data, link_type=LinkType.BATTLE)


def handle_battle_turn(ctx: CommandContext, data: bytearray) -> bytes:
    user = ctx.current_user()
    ctx.require(data, 2)
    action = data[1]
    battle = link.get_active_session(ctx, user.user_id)
    if battle is None:
        ctx.log(
            logging.WARNING,
            "battle turn rejected: no active battle",
            command=constants.Command.BATTLETURN,
            error=constants.Error.UNAUTHORIZED.name,
        )
        return error_response(constants.Error.UNAUTHORIZED)

    builder = ResponseBuilder(constants.Command.BATTLETURN)
    with battle.lock:
        battle.set_action(user.user_id, action)
        payload = battle.pending_input(user.user_id)
    builder.append_bytes(payload)
    if payload:
        ctx.state.record_battle_event(battle.battle_id, bytes(payload))
        ctx.log(logging.DEBUG, "battle turn payload generated", command=constants.Command.BATTLETURN)
        return builder.build()


    def get_active_battle(ctx: CommandContext, user_id: int, *, require_accepted: bool = True) -> Battle | None:
        return link.get_active_session(ctx, user_id, require_accepted=require_accepted)
