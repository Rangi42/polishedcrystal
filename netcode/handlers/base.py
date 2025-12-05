"""Shared context passed into each handler."""

from __future__ import annotations

import logging
import socket
from dataclasses import dataclass

from .. import constants
from ..io import ConnectionClosed, ensure_length, DEFAULT_CHUNK_SIZE
from ..models import Session, User
from ..settings import Settings
from ..state import ServerState


@dataclass
class CommandContext:
    state: ServerState
    session: Session
    settings: Settings
    logger: logging.Logger
    chunk_size: int = DEFAULT_CHUNK_SIZE

    def require(self, data: bytearray, length: int) -> None:
        if length <= len(data):
            return
        sock = self.session.sock
        if sock is None:
            raise ConnectionClosed("session detached from socket")
        ensure_length(sock, data, length, chunk_size=self.chunk_size)

    def current_user(self) -> User:
        user_id = self.session.user_id
        if user_id is None:
            raise ConnectionClosed("session missing user id")
        user = self.state.get_user(user_id)
        if user is None:
            raise ConnectionClosed("user slot recycled")
        return user

    def log(
        self,
        level: int,
        message: str,
        *,
        command: constants.Command | None = None,
        battle_id: int | None = None,
        **extra,
    ) -> None:
        user_id = self.session.user_id
        if battle_id is None and user_id is not None:
            user = self.state.get_user(user_id)
            if user is not None:
                battle_id = getattr(user, "battle_id", 0)
        context = {
            "user_id": user_id,
            "battle_id": battle_id,
            "command": command.name if isinstance(command, constants.Command) else command,
        }
        context.update(extra)
        self.logger.log(level, message, extra=context)

    def disconnect(self, *, raise_exc: bool = True) -> None:
        sock = self.session.sock
        user_id = self.session.user_id
        if user_id is not None:
            self.state.handle_disconnect(user_id)
        if sock is not None:
            try:
                sock.shutdown(socket.SHUT_RDWR)
            except OSError:
                pass
            sock.close()
            self.session.sock = None
        if raise_exc:
            raise ConnectionClosed("client disconnected")
