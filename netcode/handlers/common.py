"""Common helpers shared by multiple handlers."""

from __future__ import annotations

from contextlib import contextmanager
from typing import Iterator, List

from .. import constants
from ..io import ResponseBuilder
from ..models import Battle, User
from ..state import ServerState


class UserLookupError(LookupError):
    """Raised when a requested user slot is missing."""


@contextmanager
def lock_users(state: ServerState, *user_ids: int) -> Iterator[List[User]]:
    """Acquire per-user locks in a deterministic order to avoid deadlocks."""

    if not user_ids:
        yield []
        return

    unique_ids: list[int] = []
    seen: set[int] = set()
    for user_id in user_ids:
        if user_id in seen:
            continue
        seen.add(user_id)
        unique_ids.append(user_id)

    ordered_ids = sorted(unique_ids)
    acquired: list[User] = []
    try:
        for user_id in ordered_ids:
            user = state.get_user(user_id)
            if user is None:
                raise UserLookupError(f"user {user_id} not found")
            user.lock.acquire()
            acquired.append(user)
        lookup = {user.user_id: user for user in acquired}
        yield [lookup[user_id] for user_id in user_ids]
    finally:
        for user in reversed(acquired):
            user.lock.release()


def error_response(error: constants.Error) -> bytes:
    builder = ResponseBuilder(constants.Signal.ERROR)
    builder.append_byte(int(error) & 0xFF)
    return builder.build()


def is_battler(state: ServerState, battle_id: int, user_id: int) -> bool:
    if battle_id <= 0:
        return False
    battle = state.get_battle(battle_id)
    if battle is None:
        return False
    return user_id in (battle.host_id, battle.client_id)


def matchmaking_status(state: ServerState, requester: User, target: User) -> constants.Error:
    if not requester.connected or not target.connected:
        return constants.Error.UNKNOWN_USER
    if requester.user_id == target.user_id:
        return constants.Error.UNAUTHORIZED
    user_battle = getattr(requester, "battle_id", 0)
    target_battle = getattr(target, "battle_id", 0)
    if user_battle == -1 or target_battle == -1:
        return constants.Error.BUSY
    if user_battle == target_battle:
        return constants.Error.OK
    if (
        user_battle != 0 and is_battler(state, user_battle, target.user_id)
    ) or (
        target_battle != 0 and is_battler(state, target_battle, requester.user_id)
    ):
        return constants.Error.REJECTED
    return constants.Error.BUSY


def battle_partner_id(battle: Battle, user_id: int) -> int:
    if user_id == battle.host_id:
        return battle.client_id
    return battle.host_id


def may_battle(state: ServerState, requester_id: int, target_id: int) -> constants.Error:
    try:
        with lock_users(state, requester_id, target_id) as (requester, target):
            return matchmaking_status(state, requester, target)
    except UserLookupError:
        return constants.Error.UNKNOWN_USER
