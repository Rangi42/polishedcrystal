from __future__ import annotations

from netcode.models import Session
from netcode.state import ServerState
from netcode.storage import (
    InMemoryBattleRepository,
    InMemoryTradeRepository,
    InMemoryUserRepository,
    InMemoryWonderTradeQueue,
)


def test_add_user_and_iter_connected():
    user_repo = InMemoryUserRepository()
    state = ServerState(user_repository=user_repo)
    u1 = state.add_user()
    u2 = state.add_user()
    u2.connected = False

    assert u1.user_id == 1
    assert state.get_user(u1.user_id) is u1
    connected = list(state.iter_users(connected_only=True))
    assert connected == [u1]
    assert user_repo.users[u1.user_id] is u1


def test_add_battle_and_cleanup():
    battle_repo = InMemoryBattleRepository()
    state = ServerState(battle_repository=battle_repo)
    u1 = state.add_user()
    u2 = state.add_user()
    battle = state.add_battle(u1.user_id, u2.user_id)
    assert battle.battle_id == 1
    assert state.get_battle(battle.battle_id) is battle
    assert battle_repo.battles[battle.battle_id] is battle
    state.cleanup_battle(battle.battle_id)
    assert state.get_battle(battle.battle_id) is None
    assert battle_repo.battles.get(battle.battle_id) is None


def test_session_registration_and_detach():
    state = ServerState()
    user = state.add_user()
    session = Session(sock=object(), user_id=user.user_id)
    state.attach_session(session)
    assert state.get_session(user.user_id) is session
    state.detach_session(user.user_id)
    assert state.get_session(user.user_id) is None


def test_battle_and_trade_logging():
    battle_repo = InMemoryBattleRepository()
    trade_repo = InMemoryTradeRepository()
    state = ServerState(battle_repository=battle_repo, trade_repository=trade_repo)
    u1 = state.add_user()
    u2 = state.add_user()
    battle = state.add_battle(u1.user_id, u2.user_id)
    state.record_battle_event(battle.battle_id, b"turn")
    state.record_trade_event(battle.battle_id, b"trade")
    assert battle_repo.events[battle.battle_id] == [b"turn"]
    assert trade_repo.logs[battle.battle_id] == [b"trade"]


def test_wonder_trade_queue_hooks():
    queue = InMemoryWonderTradeQueue()
    state = ServerState(wonder_trade_queue=queue)
    blob = b"partydata"
    state.enqueue_wonder_trade(blob)
    assert queue.dequeue() == blob


def test_handle_disconnect_releases_battle_and_session():
    state = ServerState()
    host = state.add_user()
    client = state.add_user()
    battle = state.add_battle(host.user_id, client.user_id)
    host.battle_id = battle.battle_id
    client.battle_id = battle.battle_id
    session = Session(sock=object(), user_id=host.user_id)
    state.attach_session(session)

    state.handle_disconnect(host.user_id)

    assert state.get_battle(battle.battle_id) is None
    assert client.battle_id == 0
    assert host.battle_id == -1
    assert state.get_session(host.user_id) is None


def test_purge_stale_sessions_drops_closed_entries():
    state = ServerState()
    user = state.add_user()
    session = Session(sock=None, user_id=user.user_id)
    state.attach_session(session)
    state.purge_stale_sessions()
    assert state.get_session(user.user_id) is None
