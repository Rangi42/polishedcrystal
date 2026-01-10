"""Shared helpers for battle and trade link flows."""

from __future__ import annotations

import logging

from .. import constants
from ..io import ResponseBuilder
from ..models import Battle, LinkType
from .base import CommandContext
from .common import (
    UserLookupError,
    battle_partner_id,
    error_response,
    lock_users,
    matchmaking_status,
    may_battle,
)


_INVITE_COMMAND = {
    LinkType.BATTLE: constants.Command.BATTLEUSER,
    LinkType.TRADE: constants.Command.TRADEUSER,
}

_PENDING_SIGNAL = {
    LinkType.BATTLE: constants.Signal.ASKBATTLE,
    LinkType.TRADE: constants.Signal.ASKTRADE,
}


def matchmaking_request(ctx: CommandContext, data: bytearray, *, link_type: LinkType) -> bytes:
    command = _INVITE_COMMAND[link_type]
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
                    battle = ctx.state.add_battle(requester.user_id, target.user_id, link_type=link_type)
                    requester.battle_id = battle.battle_id
                    target.battle_id = battle.battle_id
                    battle.host_accepted = True
                    battle.client_accepted = False
                    battle.link_type = link_type
                else:
                    battle.link_type = LinkType.TRADE if link_type is LinkType.TRADE else battle.link_type

                if requester.user_id == battle.host_id:
                    battle.host_accepted = True
                else:
                    battle.client_accepted = True

                ctx.log(
                    logging.DEBUG,
                    "matchmaking state",
                    command=command,
                    battle_id=battle.battle_id,
                    host=battle.host_id,
                    client=battle.client_id,
                    host_accepted=battle.host_accepted,
                    client_accepted=battle.client_accepted,
                    link_type=battle.link_type.value,
                )

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
    ctx.log(
        logging.DEBUG,
        "set reply received",
        command=constants.Command.SETREPLY,
        reply=reply_code,
        user_id=user.user_id,
    )
    battle = get_active_session(ctx, user.user_id, require_accepted=False)
    if battle is None:
        ctx.log(
            logging.WARNING,
            "set reply without active session",
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
        _cleanup_finished_session(ctx, battle)
        ctx.log(
            logging.INFO,
            "link invite rejected",
            command=constants.Command.SETREPLY,
            target=partner_id,
            link_type=battle.link_type.value,
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
    ctx.log(
        logging.INFO,
        "link reply processed",
        command=constants.Command.SETREPLY,
        link_type=battle.link_type.value,
        host_accepted=battle.host_accepted,
        client_accepted=battle.client_accepted,
        partner_id=partner_id,
        reply=reply_code,
    )
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
        signal_code = _PENDING_SIGNAL[battle.link_type]
        builder = ResponseBuilder(signal_code)
        builder.append_byte(battle_partner_id(battle, user.user_id))
        ctx.log(
            logging.INFO,
            "sending pending invite signal",
            command=command,
            signal=signal_code.name,
            link_type=battle.link_type.value,
            host_accepted=battle.host_accepted,
            client_accepted=battle.client_accepted,
        )
        return builder.build()

    # Session is accepted; leave it intact so turn handlers can proceed.
    ctx.log(
        logging.DEBUG,
        "pending signal skip: already accepted",
        command=command,
        battle_id=battle.battle_id,
        host=battle.host_id,
        client=battle.client_id,
        host_accepted=battle.host_accepted,
        client_accepted=battle.client_accepted,
        link_type=battle.link_type.value,
    )
    return None


def get_active_session(ctx: CommandContext, user_id: int, *, require_accepted: bool = True) -> Battle | None:
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


def _cleanup_finished_session(ctx: CommandContext, battle: Battle) -> None:
    host = ctx.state.get_user(battle.host_id)
    client = ctx.state.get_user(battle.client_id)
    if host is not None:
        host.battle_id = 0
    if client is not None:
        client.battle_id = 0
    ctx.state.cleanup_battle(battle.battle_id)