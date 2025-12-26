"""Repository interfaces, in-memory fallbacks, and simple filesystem backends."""

from __future__ import annotations

import json
from pathlib import Path
from threading import Lock
from collections import deque
from dataclasses import dataclass, field
from typing import Deque, Dict, Optional, Protocol

from .models import Battle, User


class UserRepository(Protocol):
    def save(self, user: User) -> None: ...

    def delete(self, user_id: int) -> None: ...


class BattleRepository(Protocol):
    def save(self, battle: Battle) -> None: ...

    def delete(self, battle_id: int) -> None: ...

    def log_event(self, battle_id: int, payload: bytes) -> None: ...


class TradeRepository(Protocol):
    def log_trade(self, battle_id: int, payload: bytes) -> None: ...


class WonderTradeQueue(Protocol):
    def enqueue(self, blob: bytes) -> None: ...

    def dequeue(self) -> Optional[bytes]: ...


@dataclass
class InMemoryUserRepository(UserRepository):
    users: Dict[int, User] = field(default_factory=dict)

    def save(self, user: User) -> None:
        self.users[user.user_id] = user

    def delete(self, user_id: int) -> None:
        self.users.pop(user_id, None)


@dataclass
class InMemoryBattleRepository(BattleRepository):
    battles: Dict[int, Battle] = field(default_factory=dict)
    events: Dict[int, list[bytes]] = field(default_factory=dict)

    def save(self, battle: Battle) -> None:
        self.battles[battle.battle_id] = battle

    def delete(self, battle_id: int) -> None:
        self.battles.pop(battle_id, None)
        self.events.pop(battle_id, None)

    def log_event(self, battle_id: int, payload: bytes) -> None:
        self.events.setdefault(battle_id, []).append(payload)


@dataclass
class InMemoryTradeRepository(TradeRepository):
    logs: Dict[int, list[bytes]] = field(default_factory=dict)

    def log_trade(self, battle_id: int, payload: bytes) -> None:
        self.logs.setdefault(battle_id, []).append(payload)


@dataclass
class InMemoryWonderTradeQueue(WonderTradeQueue):
    queue: Deque[bytes] = field(default_factory=deque)

    def enqueue(self, blob: bytes) -> None:
        self.queue.append(blob)

    def dequeue(self) -> Optional[bytes]:
        if not self.queue:
            return None
        return self.queue.popleft()


@dataclass
class FilesystemUserRepository(UserRepository):
    root: Path

    def __post_init__(self) -> None:
        self.root = Path(self.root)
        self.root.mkdir(parents=True, exist_ok=True)

    def _path(self, user_id: int) -> Path:
        return self.root / f"user_{user_id}.bin"

    def save(self, user: User) -> None:
        self._path(user.user_id).write_bytes(user.serialize_full())

    def delete(self, user_id: int) -> None:
        path = self._path(user_id)
        if path.exists():
            path.unlink()


@dataclass
class FilesystemBattleRepository(BattleRepository):
    root: Path

    def __post_init__(self) -> None:
        self.root = Path(self.root)
        self.root.mkdir(parents=True, exist_ok=True)

    def _meta_path(self, battle_id: int) -> Path:
        return self.root / f"battle_{battle_id}.json"

    def _log_path(self, battle_id: int) -> Path:
        return self.root / f"battle_{battle_id}.log"

    def save(self, battle: Battle) -> None:
        payload = {
            "battle_id": battle.battle_id,
            "host_id": battle.host_id,
            "client_id": battle.client_id,
            "link_type": battle.link_type.value,
            "is_trade": battle.is_trade,
        }
        self._meta_path(battle.battle_id).write_text(json.dumps(payload, indent=2))

    def delete(self, battle_id: int) -> None:
        for path in (self._meta_path(battle_id), self._log_path(battle_id)):
            if path.exists():
                path.unlink()

    def log_event(self, battle_id: int, payload: bytes) -> None:
        log_path = self._log_path(battle_id)
        with log_path.open("ab") as handle:
            handle.write(payload.hex().encode("ascii"))
            handle.write(b"\n")


@dataclass
class FilesystemTradeRepository(TradeRepository):
    root: Path

    def __post_init__(self) -> None:
        self.root = Path(self.root)
        self.root.mkdir(parents=True, exist_ok=True)

    def _log_path(self, battle_id: int) -> Path:
        return self.root / f"trade_{battle_id}.log"

    def log_trade(self, battle_id: int, payload: bytes) -> None:
        with self._log_path(battle_id).open("ab") as handle:
            handle.write(payload.hex().encode("ascii"))
            handle.write(b"\n")


@dataclass
class FilesystemWonderTradeQueue(WonderTradeQueue):
    path: Path
    lock: Lock = field(default_factory=Lock, repr=False)

    def __post_init__(self) -> None:
        self.path = Path(self.path)
        self.path.parent.mkdir(parents=True, exist_ok=True)
        if not self.path.exists():
            self.path.write_bytes(b"")

    def enqueue(self, blob: bytes) -> None:
        data = len(blob).to_bytes(2, "big") + blob
        with self.lock:
            with self.path.open("ab") as handle:
                handle.write(data)

    def dequeue(self) -> Optional[bytes]:
        with self.lock:
            data = self.path.read_bytes()
            if len(data) < 2:
                return None
            length = int.from_bytes(data[:2], "big")
            if len(data) < 2 + length:
                return None
            payload = data[2 : 2 + length]
            remainder = data[2 + length :]
            self.path.write_bytes(remainder)
            return bytes(payload)
