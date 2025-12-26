"""Runtime settings for the Polished Online server."""

from __future__ import annotations

import os
from dataclasses import dataclass
from typing import Any, Mapping

from . import constants

ENV_PREFIX = "PO_SERVER_"


@dataclass(slots=True)
class Settings:
    host: str = constants.DEFAULT_HOST
    port: int = constants.DEFAULT_PORT
    log_level: str = "INFO"
    backlog: int = 5
    recv_chunk: int = 256
    client_timeout: float = 30.0
    enable_persistence: bool = False
    persistence_dir: str | None = None

    @classmethod
    def from_env(cls, env: Mapping[str, str] | None = None) -> "Settings":
        env = env or os.environ
        kw: dict[str, Any] = {}
        if f"{ENV_PREFIX}HOST" in env:
            kw["host"] = env[f"{ENV_PREFIX}HOST"]
        if f"{ENV_PREFIX}PORT" in env:
            kw["port"] = int(env[f"{ENV_PREFIX}PORT"])
        if f"{ENV_PREFIX}LOG_LEVEL" in env:
            kw["log_level"] = env[f"{ENV_PREFIX}LOG_LEVEL"]
        if f"{ENV_PREFIX}BACKLOG" in env:
            kw["backlog"] = int(env[f"{ENV_PREFIX}BACKLOG"])
        if f"{ENV_PREFIX}RECV_CHUNK" in env:
            kw["recv_chunk"] = int(env[f"{ENV_PREFIX}RECV_CHUNK"])
        if f"{ENV_PREFIX}CLIENT_TIMEOUT" in env:
            kw["client_timeout"] = float(env[f"{ENV_PREFIX}CLIENT_TIMEOUT"])
        if f"{ENV_PREFIX}ENABLE_PERSISTENCE" in env:
            kw["enable_persistence"] = env[f"{ENV_PREFIX}ENABLE_PERSISTENCE"].lower() in {"1", "true", "yes", "on"}
        if f"{ENV_PREFIX}PERSISTENCE_DIR" in env:
            kw["persistence_dir"] = env[f"{ENV_PREFIX}PERSISTENCE_DIR"]
        return cls(**kw)

    def apply_cli_overrides(
        self,
        *,
        host: str | None = None,
        port: int | None = None,
        log_level: str | None = None,
        enable_persistence: bool | None = None,
        persistence_dir: str | None = None,
    ) -> None:
        if host is not None:
            self.host = host
        if port is not None:
            self.port = port
        if log_level is not None:
            self.log_level = log_level
        if enable_persistence is not None:
            self.enable_persistence = enable_persistence
        if persistence_dir is not None:
            self.persistence_dir = persistence_dir
