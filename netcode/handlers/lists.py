"""Handlers that return list-style responses (users, battles, etc.)."""

from __future__ import annotations

import logging

from .. import constants
from ..io import ResponseBuilder
from .base import CommandContext


def handle_list_users(ctx: CommandContext, data: bytearray) -> bytes:
    ctx.log(logging.DEBUG, "list users", command=constants.Command.LISTUSERS)
    builder = ResponseBuilder(constants.Command.LISTUSERS)
    builder.append_byte(0)
    count = 0
    with ctx.state.users_lock:
        for user in ctx.state.iter_users(connected_only=True):
            count += 1
            builder.append_byte(user.user_id & 0xFF)
            builder.append_byte((user.otid >> 8) & 0xFF)
            builder.append_byte(user.otid & 0xFF)
            builder.append_bytes(user.name)
    builder.buffer[2] = count & 0xFF
    ctx.log(logging.DEBUG, "list users count", command=constants.Command.LISTUSERS, count=str(count))
    return builder.build()
