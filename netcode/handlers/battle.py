"""Handlers related to battles and battles' turn exchange."""

from __future__ import annotations

import logging

from .. import constants
from ..io import ResponseBuilder
from ..models import Battle
from .base import CommandContext
from .common import (
    UserLookupError,
    battle_partner_id,
    error_response,
    is_battler,
    lock_users,
    matchmaking_status,
    may_battle,
)


def handle_battle_user(ctx: CommandContext, data: bytearray) -> bytes:
    ctx.log(logging.DEBUG, "battle invite requested", command=constants.Command.BATTLEUSER)
    return _handle_matchmaking(ctx, data, command=constants.Command.BATTLEUSER, is_trade=False)


def handle_battle_turn(ctx: CommandContext, data: bytearray) -> bytes:
    user = ctx.current_user()
    ctx.require(data, 2)
    action = data[1]
    battle = get_active_battle(ctx, user.user_id)
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


def handle_set_reply(ctx: CommandContext, data: bytearray) -> bytes:
    user = ctx.current_user()
    pending_error = getattr(user, "pending_error", constants.Error.OK)
    if pending_error is not constants.Error.OK:
        user.pending_error = constants.Error.OK
        ctx.log(
            logging.INFO,
            "delivering pending error",
            command=constants.Command.SETREPLY,
            error=pending_error.name,
        )
        return error_response(pending_error)
    ctx.require(data, 2)
    reply_code = data[1]
    battle = get_active_battle(ctx, user.user_id, require_accepted=False)
    if battle is None:
        ctx.log(
            logging.WARNING,
            "set reply without battle",
            command=constants.Command.SETREPLY,
            error=constants.Error.UNAUTHORIZED.name,
        )
        return error_response(constants.Error.UNAUTHORIZED)

    builder = ResponseBuilder(constants.Command.SETREPLY)
    partner_id = battle_partner_id(battle, user.user_id)
    if reply_code == constants.Reply.REJECT:
        partner = ctx.state.get_user(partner_id)
        if partner is not None:
            partner.pending_error = constants.Error.REJECTED
        builder.append_byte(0)
        _cleanup_finished_battle(ctx, battle)
        ctx.log(
            logging.INFO,
            "battle invite rejected",
            command=constants.Command.SETREPLY,
            target=partner_id,
        )
        return builder.build()

    if reply_code == constants.Reply.ACCEPT:
        if user.user_id == battle.host_id:
            battle.host_accepted = True
        else:
            battle.client_accepted = True

    err = may_battle(ctx.state, user.user_id, partner_id)
    if err is not constants.Error.OK:
        ctx.log(
            logging.WARNING,
            "set reply validation failed",
            command=constants.Command.SETREPLY,
            error=err.name,
        )
        return error_response(err)

    if battle.host_accepted and battle.client_accepted:
        builder.append_byte(battle.host_id & 0xFF)
        builder.append_byte(battle.client_id & 0xFF)
    else:
        builder.append_byte(0)
    ctx.log(logging.INFO, "battle reply processed", command=constants.Command.SETREPLY)
    return builder.build()


def maybe_pending_signal(ctx: CommandContext, command: constants.Command, data: bytearray) -> bytes | None:
    user = ctx.current_user()
    battle_id = getattr(user, "battle_id", 0)
    if battle_id <= 0:
        return None
    if command not in (
        constants.Command.LISTUSERS,
        constants.Command.BATTLEUSER,
        constants.Command.TRADEUSER,
    ):
        return None

    battle = ctx.state.get_battle(battle_id)
    if battle is None:
        user.battle_id = 0
        return None

    if command in (constants.Command.BATTLEUSER, constants.Command.TRADEUSER):
        ctx.require(data, 2)
        if battle_partner_id(battle, user.user_id) == data[1]:
            return None

    if not battle.client_accepted:
        signal_code = constants.Signal.ASKTRADE if battle.is_trade else constants.Signal.ASKBATTLE
        builder = ResponseBuilder(signal_code)
        builder.append_byte(battle_partner_id(battle, user.user_id))
        ctx.log(logging.INFO, "sending pending invite signal", command=command, signal=signal_code.name)
        return builder.build()

    _cleanup_finished_battle(ctx, battle)
    ctx.log(logging.INFO, "cleaned up finished battle", command=command)
    return None


def _handle_matchmaking(
    ctx: CommandContext,
    data: bytearray,
    *,
    command: constants.Command,
    is_trade: bool,
) -> bytes:
    user = ctx.current_user()
    ctx.require(data, 2)
    target_id = data[1]
    try:
        with lock_users(ctx.state, user.user_id, target_id) as (requester, target):
            with ctx.state.battles_lock:
                status = matchmaking_status(ctx.state, requester, target)
                if status is not constants.Error.OK:
                    ctx.log(
                        logging.WARNING,
                        "matchmaking rejected",
                        command=command,
                        target=str(target_id),
                        error=status.name,
                    )
                    return error_response(status)

                battle = ctx.state.get_battle(requester.battle_id) if requester.battle_id > 0 else None
                if battle is None:
                    battle = ctx.state.add_battle(requester.user_id, target.user_id, is_trade=is_trade)
                    requester.battle_id = battle.battle_id
                    target.battle_id = battle.battle_id
                    battle.host_accepted = True
                    battle.client_accepted = False
                    battle.is_trade = is_trade
                else:
                    battle.is_trade = battle.is_trade or is_trade

                if requester.user_id == battle.host_id:
                    battle.host_accepted = True
                else:
                    battle.client_accepted = True

                builder = ResponseBuilder(command)
                if battle.host_accepted and battle.client_accepted:
                    builder.append_byte(battle.host_id & 0xFF)
                    builder.append_byte(battle.client_id & 0xFF)
                else:
                    builder.append_byte(0)
                ctx.log(logging.INFO, "matchmaking updated", command=command, battle=str(battle.battle_id))
                return builder.build()
    except UserLookupError:
        ctx.log(
            logging.WARNING,
            "matchmaking user missing",
            command=command,
            target=str(target_id),
            error=constants.Error.UNKNOWN_USER.name,
        )
        return error_response(constants.Error.UNKNOWN_USER)


def get_active_battle(ctx: CommandContext, user_id: int, *, require_accepted: bool = True) -> Battle | None:
    user = ctx.state.get_user(user_id)
    if user is None:
        return None
    battle_id = getattr(user, "battle_id", 0)
    if battle_id <= 0:
        return None
    battle = ctx.state.get_battle(battle_id)
    if battle is None:
        user.battle_id = 0
        return None
    if require_accepted and (not battle.host_accepted or not battle.client_accepted):
        return None
    if user_id not in (battle.host_id, battle.client_id):
        return None
    return battle


def _cleanup_finished_battle(ctx: CommandContext, battle: Battle) -> None:
    host = ctx.state.get_user(battle.host_id)
    client = ctx.state.get_user(battle.client_id)
    if host is not None:
        host.battle_id = 0
    if client is not None:
        client.battle_id = 0
    ctx.state.cleanup_battle(battle.battle_id)


def matchmaking_request(ctx: CommandContext, data: bytearray, *, is_trade: bool) -> bytes:
    command = constants.Command.TRADEUSER if is_trade else constants.Command.BATTLEUSER
    return _handle_matchmaking(ctx, data, command=command, is_trade=is_trade)
