"""Trade invite and turn handlers."""

from __future__ import annotations

import logging
import secrets

from .. import constants
from ..io import ResponseBuilder
from ..models import LinkType
from . import link
from .base import CommandContext
from .common import error_response


def handle_trade_user(ctx: CommandContext, data: bytearray) -> bytes:
    ctx.log(logging.DEBUG, "trade invite requested", command=constants.Command.TRADEUSER)
    return link.matchmaking_request(ctx, data, link_type=LinkType.TRADE)


def handle_trade_turn(ctx: CommandContext, data: bytearray) -> bytes:
    user = ctx.current_user()
    ctx.require(data, 2)
    action = data[1]
    battle_obj = link.get_active_session(ctx, user.user_id)
    if battle_obj is None:
        ctx.log(
            logging.WARNING,
            "trade turn rejected: no active trade",
            command=constants.Command.TRADETURN,
            error=constants.Error.UNAUTHORIZED.name,
        )
        return error_response(constants.Error.UNAUTHORIZED)

    builder = ResponseBuilder(constants.Command.TRADETURN)
    with battle_obj.lock:
        battle_obj.set_action(user.user_id, action)
        payload = battle_obj.pending_input_trade(user.user_id)
    builder.append_bytes(payload)
    if payload:
        ctx.state.record_trade_event(battle_obj.battle_id, bytes(payload))
        ctx.log(logging.DEBUG, "trade turn payload generated", command=constants.Command.TRADETURN)
    return builder.build()


def handle_wonder_trade(ctx: CommandContext, data: bytearray) -> bytes:
    blob = secrets.token_bytes(32)
    ctx.state.enqueue_wonder_trade(blob)
    builder = ResponseBuilder(constants.Command.WONDERTRADE)
    builder.append_bytes(blob)
    ctx.log(logging.INFO, "wonder trade enqueued", command=constants.Command.WONDERTRADE)
    return builder.build()
