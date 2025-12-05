"""Handlers for info upload/download commands."""

from __future__ import annotations

import logging

from .. import constants, serialization
from ..io import ResponseBuilder
from .base import CommandContext
from .common import UserLookupError, error_response, lock_users


def handle_status(ctx: CommandContext, data: bytearray) -> bytes:
    ctx.log(logging.DEBUG, "status requested", command=constants.Command.STATUS)
    user = ctx.current_user()
    builder = ResponseBuilder(constants.Command.STATUS)
    builder.append_byte(user.user_id & 0xFF)
    return builder.build()


def handle_disconnect(ctx: CommandContext, data: bytearray) -> None:
    ctx.disconnect()


def handle_setinfo(ctx: CommandContext, data: bytearray) -> bytes:
    ctx.log(logging.DEBUG, "setinfo chunk received", command=constants.Command.SETINFO)
    ctx.require(data, 2)
    chunk_id = data[1]
    try:
        chunk_length = serialization.user_chunk_size(chunk_id)
    except ValueError:
        ctx.log(
            logging.WARNING,
            "invalid setinfo chunk id",
            command=constants.Command.SETINFO,
            chunk_id=str(chunk_id),
            error=constants.Error.BAD_INFO.name,
        )
        return error_response(constants.Error.BAD_INFO)

    ctx.require(data, 2 + chunk_length)
    payload = bytes(memoryview(data)[2 : 2 + chunk_length])
    user = ctx.current_user()
    try:
        with lock_users(ctx.state, user.user_id) as (locked_user,):
            try:
                locked_user.apply_chunk(chunk_id, payload)
            except ValueError:
                ctx.log(
                    logging.WARNING,
                    "setinfo chunk length mismatch",
                    command=constants.Command.SETINFO,
                    chunk_id=str(chunk_id),
                    error=constants.Error.BAD_INFO.name,
                )
                return error_response(constants.Error.BAD_INFO)
            ctx.state.persist_user(locked_user)
    except UserLookupError:
        ctx.log(
            logging.WARNING,
            "setinfo target missing",
            command=constants.Command.SETINFO,
            error=constants.Error.UNKNOWN_USER.name,
        )
        return error_response(constants.Error.UNKNOWN_USER)

    return ResponseBuilder(constants.Command.SETINFO).build()


def handle_getinfo(ctx: CommandContext, data: bytearray) -> bytes:
    ctx.log(logging.DEBUG, "getinfo request", command=constants.Command.GETINFO)
    ctx.require(data, 3)
    target_id = data[1]
    chunk_id = data[2]
    try:
        with lock_users(ctx.state, target_id) as (target,):
            try:
                payload = target.serialize_chunk(chunk_id)
            except ValueError:
                ctx.log(
                    logging.WARNING,
                    "getinfo chunk id invalid",
                    command=constants.Command.GETINFO,
                    chunk_id=str(chunk_id),
                    error=constants.Error.BAD_INFO.name,
                )
                return error_response(constants.Error.BAD_INFO)
    except UserLookupError:
        ctx.log(
            logging.WARNING,
            "getinfo unknown user",
            command=constants.Command.GETINFO,
            user=str(target_id),
            error=constants.Error.UNKNOWN_USER.name,
        )
        return error_response(constants.Error.UNKNOWN_USER)

    builder = ResponseBuilder(constants.Command.GETINFO)
    builder.append_bytes(payload)
    return builder.build()


def handle_getinfo_version(ctx: CommandContext, data: bytearray) -> bytes:
    ctx.log(logging.DEBUG, "getinfo version request", command=constants.Command.GETINFO_VER)
    ctx.require(data, 2)
    target_id = data[1]
    try:
        with lock_users(ctx.state, target_id) as (target,):
            version = target.info_version & 0xFF
    except UserLookupError:
        ctx.log(
            logging.WARNING,
            "getinfo version unknown user",
            command=constants.Command.GETINFO_VER,
            user=str(target_id),
            error=constants.Error.UNKNOWN_USER.name,
        )
        return error_response(constants.Error.UNKNOWN_USER)

    builder = ResponseBuilder(constants.Command.GETINFO_VER)
    builder.append_byte(version)
    return builder.build()
