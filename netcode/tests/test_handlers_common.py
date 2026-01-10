from __future__ import annotations

import threading

import pytest

from netcode.handlers import common
from netcode.state import ServerState


def test_lock_users_returns_requested_order() -> None:
    state = ServerState()
    user_a = state.add_user()
    user_b = state.add_user()
    with common.lock_users(state, user_b.user_id, user_a.user_id) as (locked_b, locked_a):
        assert locked_b.user_id == user_b.user_id
        assert locked_a.user_id == user_a.user_id
    # Locks should be released, so we can acquire again without hanging.
    with common.lock_users(state, user_a.user_id):
        pass


def test_lock_users_raises_for_missing_user() -> None:
    state = ServerState()
    with pytest.raises(common.UserLookupError):
        with common.lock_users(state, 99):
            pass


def test_lock_users_concurrent_opposite_order() -> None:
    state = ServerState()
    user_a = state.add_user()
    user_b = state.add_user()
    barrier = threading.Barrier(2)
    results: list[tuple[int, int]] = []
    errors: list[BaseException] = []

    def worker(first: int, second: int) -> None:
        try:
            barrier.wait(timeout=2)
            with common.lock_users(state, first, second) as (locked_first, locked_second):
                results.append((locked_first.user_id, locked_second.user_id))
        except BaseException as exc:  # pragma: no cover - defensive
            errors.append(exc)

    threads = [
        threading.Thread(target=worker, args=(user_a.user_id, user_b.user_id)),
        threading.Thread(target=worker, args=(user_b.user_id, user_a.user_id)),
    ]
    for thread in threads:
        thread.start()
    for thread in threads:
        thread.join(timeout=2)
        assert not thread.is_alive(), "lock_users deadlocked"

    assert not errors
    assert len(results) == 2
    assert set(results) == {
        (user_a.user_id, user_b.user_id),
        (user_b.user_id, user_a.user_id),
    }
