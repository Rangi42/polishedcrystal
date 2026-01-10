"""Request handlers grouped by verb."""

from __future__ import annotations

from typing import Callable, Dict

from .. import constants
from . import battle, info, link, lists, trade
from .base import CommandContext
from .common import error_response

Handler = Callable[[CommandContext, bytearray], bytes | None]


COMMAND_HANDLERS: Dict[constants.Command, Handler] = {
    constants.Command.DISCONNECT: info.handle_disconnect,
    constants.Command.STATUS: info.handle_status,
    constants.Command.WONDERTRADE: trade.handle_wonder_trade,
    constants.Command.SETINFO: info.handle_setinfo,
    constants.Command.GETINFO: info.handle_getinfo,
    constants.Command.LISTUSERS: lists.handle_list_users,
    constants.Command.BATTLEUSER: battle.handle_battle_user,
    constants.Command.TRADEUSER: trade.handle_trade_user,
    constants.Command.BATTLETURN: battle.handle_battle_turn,
    constants.Command.TRADETURN: trade.handle_trade_turn,
    constants.Command.SETREPLY: link.handle_set_reply,
    constants.Command.GETINFO_VER: info.handle_getinfo_version,
}


def dispatch(command: constants.Command, ctx: CommandContext, data: bytearray) -> bytes | None:
    handler = COMMAND_HANDLERS.get(command)
    if handler is None:
        return error_response(constants.Error.UNKNOWN_COMMAND)
    return handler(ctx, data)


__all__ = [
    "COMMAND_HANDLERS",
    "dispatch",
    "battle",
    "info",
    "link",
    "lists",
    "trade",
]
