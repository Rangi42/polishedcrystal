"""Holds global-ish state so we can drop module-level globals."""

from __future__ import annotations

from dataclasses import dataclass, field
from threading import RLock
from typing import Callable, Dict, Iterable, Optional

from .models import Battle, LinkType, Session, User
from .storage import BattleRepository, TradeRepository, UserRepository, WonderTradeQueue

UserFactory = Callable[[int], User]
BattleFactory = Callable[[int, int, int, LinkType], Battle]


@dataclass
class ServerState:
    """Owns users, battles, sessions, and helper locks."""

    users: Dict[int, User] = field(default_factory=dict)
    battles: Dict[int, Battle] = field(default_factory=dict)
    sessions: Dict[int, Session] = field(default_factory=dict)
    _next_user_id: int = 1
    _next_battle_id: int = 1
    lock: RLock = field(default_factory=RLock, repr=False)
    users_lock: RLock = field(default_factory=RLock, repr=False)
    battles_lock: RLock = field(default_factory=RLock, repr=False)
    user_factory: Optional[UserFactory] = None
    battle_factory: Optional[BattleFactory] = None
    user_repository: Optional[UserRepository] = None
    battle_repository: Optional[BattleRepository] = None
    trade_repository: Optional[TradeRepository] = None
    wonder_trade_queue: Optional[WonderTradeQueue] = None

    def add_user(self, *, factory: Optional[UserFactory] = None) -> User:
        creator = factory or self.user_factory or (lambda user_id: User(user_id))
        with self.lock:
            user_id = self._next_user_id
            self._next_user_id += 1
        user = creator(user_id)
        with self.users_lock:
            self.users[user_id] = user
        self._persist_user(user)
        return user

    def register_user(self, user: User) -> None:
        with self.users_lock:
            self.users[user.user_id] = user

    def remove_user(self, user_id: int) -> None:
        with self.users_lock:
            self.users.pop(user_id, None)
        self.sessions.pop(user_id, None)
        if self.user_repository is not None:
            self.user_repository.delete(user_id)

    def get_user(self, user_id: int) -> Optional[User]:
        return self.users.get(user_id)

    def iter_users(self, *, connected_only: bool = False) -> Iterable[User]:
        for user in self.users.values():
            if connected_only and not getattr(user, "connected", False):
                continue
            yield user

    def add_battle(
        self,
        host_id: int,
        client_id: int,
        *,
        link_type: LinkType = LinkType.BATTLE,
        factory: Optional[BattleFactory] = None,
    ) -> Battle:
        creator = factory or self.battle_factory or (lambda bid, h, c, link_type=LinkType.BATTLE: Battle(bid, h, c, link_type=link_type))
        with self.lock:
            battle_id = self._next_battle_id
            self._next_battle_id += 1
        battle = creator(battle_id, host_id, client_id, link_type)
        with self.battles_lock:
            self.battles[battle_id] = battle
        if self.battle_repository is not None:
            self.battle_repository.save(battle)
        return battle

    def get_battle(self, battle_id: int) -> Optional[Battle]:
        return self.battles.get(battle_id)

    def cleanup_battle(self, battle_id: int) -> None:
        with self.battles_lock:
            self.battles.pop(battle_id, None)
        if self.battle_repository is not None:
            self.battle_repository.delete(battle_id)

    def attach_session(self, session: Session) -> None:
        if session.user_id is None:
            raise ValueError("session must have a user id before registration")
        self.sessions[session.user_id] = session

    def get_session(self, user_id: int) -> Optional[Session]:
        return self.sessions.get(user_id)

    def detach_session(self, user_id: int) -> None:
        self.sessions.pop(user_id, None)

    def purge_stale_sessions(self) -> None:
        stale = [user_id for user_id, session in self.sessions.items() if session.sock is None or user_id not in self.users]
        for user_id in stale:
            self.sessions.pop(user_id, None)

    def handle_disconnect(self, user_id: int) -> None:
        user = self.get_user(user_id)
        if user is not None:
            with user.lock:
                battle_id = getattr(user, "battle_id", 0)
                user.connected = False
                user.battle_id = -1
        else:
            battle_id = 0

        if battle_id > 0:
            self._release_battle_for_disconnect(battle_id, user_id)

        self.detach_session(user_id)
        self.purge_stale_sessions()

    def persist_user(self, user: User) -> None:
        self._persist_user(user)

    def record_battle_event(self, battle_id: int, payload: bytes) -> None:
        if self.battle_repository is not None:
            self.battle_repository.log_event(battle_id, payload)

    def record_trade_event(self, battle_id: int, payload: bytes) -> None:
        if self.trade_repository is not None:
            self.trade_repository.log_trade(battle_id, payload)

    def enqueue_wonder_trade(self, blob: bytes) -> None:
        if self.wonder_trade_queue is not None:
            self.wonder_trade_queue.enqueue(blob)

    def _persist_user(self, user: User) -> None:
        if self.user_repository is not None:
            self.user_repository.save(user)

    def _release_battle_for_disconnect(self, battle_id: int, user_id: int) -> None:
        battle = self.get_battle(battle_id)
        if battle is None:
            return
        try:
            opponent_id = battle.other_user_id(user_id)
        except ValueError:
            opponent_id = None
        if opponent_id is not None:
            opponent = self.get_user(opponent_id)
            if opponent is not None:
                opponent.battle_id = 0
        self.cleanup_battle(battle_id)
