from __future__ import annotations

import json

from netcode.models import Battle, User
from netcode.storage import (
    FilesystemBattleRepository,
    FilesystemTradeRepository,
    FilesystemUserRepository,
    FilesystemWonderTradeQueue,
)


def _sample_user(user_id: int) -> User:
    user = User(user_id=user_id)
    user.otid = 0xBEEF
    user.gender = 1
    user.party_count = 2
    user.name[:] = b"ASH" + b"\x00" * (len(user.name) - 3)
    return user


def test_filesystem_user_repository_persists_bytes(tmp_path):
    repo = FilesystemUserRepository(tmp_path)
    user = _sample_user(42)
    repo.save(user)
    path = tmp_path / "user_42.bin"
    assert path.read_bytes() == user.serialize_full()
    repo.delete(42)
    assert not path.exists()


def test_filesystem_battle_repository_logs_and_deletes(tmp_path):
    repo = FilesystemBattleRepository(tmp_path)
    battle = Battle(battle_id=7, host_id=1, client_id=2)
    repo.save(battle)
    meta_path = tmp_path / "battle_7.json"
    meta = json.loads(meta_path.read_text())
    assert meta["host_id"] == 1
    repo.log_event(7, b"\x01\x02")
    log_path = tmp_path / "battle_7.log"
    assert log_path.read_text().strip() == "0102"
    repo.delete(7)
    assert not meta_path.exists()
    assert not log_path.exists()


def test_filesystem_trade_repository_logs(tmp_path):
    repo = FilesystemTradeRepository(tmp_path)
    repo.log_trade(5, b"\xAA")
    log_path = tmp_path / "trade_5.log"
    assert log_path.read_text().strip() == "aa"


def test_filesystem_wondertrade_queue_roundtrip(tmp_path):
    queue = FilesystemWonderTradeQueue(tmp_path / "queue.bin")
    queue.enqueue(b"hello")
    assert queue.dequeue() == b"hello"
    assert queue.dequeue() is None
