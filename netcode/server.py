"""Socket server entrypoint for the refactored netcode."""

from __future__ import annotations

import argparse
import logging
import socket
import threading
from contextlib import suppress
from pathlib import Path
from typing import Sequence

from . import constants
from .handlers import link as link_handlers
from .handlers import dispatch as dispatch_command
from .handlers.base import CommandContext
from .handlers.common import error_response
from .io import ConnectionClosed, ensure_length
from .models import Session
from .metrics import MetricsRecorder, NoOpMetrics
from .settings import Settings
from .state import ServerState
from .storage import (
    FilesystemBattleRepository,
    FilesystemTradeRepository,
    FilesystemUserRepository,
    FilesystemWonderTradeQueue,
)

logger = logging.getLogger(__name__)


def serve(
    *,
    host: str | None = None,
    port: int | None = None,
    state: ServerState | None = None,
    settings: Settings | None = None,
    metrics: MetricsRecorder | None = None,
    stop_event: threading.Event | None = None,
    ready_event: threading.Event | None = None,
) -> None:
    """Start the TCP server using the refactored stack."""

    settings = settings or Settings.from_env()
    if host is not None:
        settings.host = host
    if port is not None:
        settings.port = port
    if state is None:
        state = ServerState()
    _configure_persistence(state, settings)
    metrics = metrics or NoOpMetrics()

    server_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_sock.bind((settings.host, settings.port))
    settings.port = server_sock.getsockname()[1]
    server_sock.listen(settings.backlog)
    server_sock.settimeout(1.0)
    logger.info("Polished Online server listening on %s:%s", settings.host, settings.port)
    if ready_event is not None:
        ready_event.set()

    workers: list[ClientWorker] = []
    try:
        while stop_event is None or not stop_event.is_set():
            try:
                client_sock, client_address = server_sock.accept()
            except socket.timeout:
                continue
            except OSError:
                break
            client_sock.settimeout(settings.client_timeout)
            worker = ClientWorker(
                state=state,
                settings=settings,
                sock=client_sock,
                address=client_address,
                metrics=metrics,
            )
            worker.start()
            workers.append(worker)
    except KeyboardInterrupt:
        logger.info("Shutting down server")
    finally:
        server_sock.close()
        for worker in workers:
            worker.join(timeout=1.0)


class ClientWorker(threading.Thread):
    """Dedicated thread that processes a single client connection."""

    def __init__(self, *, state: ServerState, settings: Settings, sock: socket.socket, address, metrics: MetricsRecorder) -> None:
        super().__init__(daemon=True)
        self.state = state
        self.settings = settings
        self.sock = sock
        self.address = address
        self.session = Session(sock=sock)
        self.metrics = metrics
        peer = self._format_peer(address)
        self.logger = logging.LoggerAdapter(logger, {"peer": peer})

    def run(self) -> None:  # pragma: no cover - relies on sockets
        self.metrics.incr("connections.opened")
        user = self.state.add_user()
        self.session.user_id = user.user_id
        self.state.attach_session(self.session)
        ctx = CommandContext(
            state=self.state,
            session=self.session,
            settings=self.settings,
            logger=self.logger,
            chunk_size=self.settings.recv_chunk,
        )
        self.logger.info("Client connected", extra={"user_id": user.user_id})

        try:
            while True:
                frame = bytearray()
                try:
                    ensure_length(self.session.sock, frame, 1, chunk_size=self.settings.recv_chunk)
                except TimeoutError:
                    # Idle clients (thinking between turns) can hit read timeouts; keep the session alive.
                    self.metrics.incr("connections.timeout")
                    self.logger.debug("Client read timed out; continuing")
                    continue
                command_value = frame[0]
                try:
                    command = constants.Command(command_value)
                except ValueError:
                    ctx.log(
                        logging.WARNING,
                        "unknown command",
                        command=f"0x{command_value:02X}",
                        error=constants.Error.UNKNOWN_COMMAND.name,
                    )
                    payload = error_response(constants.Error.UNKNOWN_COMMAND)
                    self._send(payload)
                    self.metrics.incr("commands.error", command="UNKNOWN")
                    continue

                ctx.log(logging.DEBUG, "command received", command=command)
                self.metrics.incr("commands.received", command=command.name)
                signal = link_handlers.maybe_pending_signal(ctx, command, frame)
                if signal is not None:
                    ctx.log(logging.INFO, "sent pending signal", command=command)
                    self.metrics.incr("signals.sent", command=command.name)
                    self._send(signal)
                    continue

                response = dispatch_command(command, ctx, frame)
                if response is not None:
                    ctx.log(logging.DEBUG, "sending response", command=command)
                    self._send(response)
                    if self._is_error_response(response):
                        self.metrics.incr("commands.error", command=command.name)
                    else:
                        self.metrics.incr("commands.ok", command=command.name)
        except ConnectionClosed:
            self.metrics.incr("connections.closed")
            self.logger.info("Client disconnected")
        except Exception:  # pragma: no cover - defensive logging
            self.metrics.incr("connections.errored")
            self.logger.exception("Unhandled client error")
        finally:
            with suppress(ConnectionClosed):
                ctx.disconnect(raise_exc=False)
            self.metrics.incr("connections.cleaned")

    def _send(self, payload: bytes) -> None:
        sock = self.session.sock
        if sock is None:
            raise ConnectionClosed("session socket missing")
        sock.sendall(payload)

    @staticmethod
    def _is_error_response(payload: bytes) -> bool:
        return len(payload) >= 2 and payload[1] == constants.Signal.ERROR

    @staticmethod
    def _format_peer(address) -> str:
        try:
            host, port = address
            return f"{host}:{port}"
        except Exception:  # pragma: no cover - defensive guard
            return str(address)


def build_arg_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Run the Polished Online netcode server")
    parser.add_argument("--host", default=None, help="Interface to bind (overrides env/Settings)")
    parser.add_argument("--port", type=int, default=None, help="TCP port to bind (overrides env/Settings)")
    parser.add_argument("--log-level", default=None, help="Python logging level")
    parser.add_argument("--enable-persistence", action="store_true", help="Persist user/battle data to disk")
    parser.add_argument("--persistence-dir", default=None, help="Directory to store persistence artifacts")
    return parser


def main(argv: Sequence[str] | None = None) -> int:
    parser = build_arg_parser()
    args = parser.parse_args(argv)
    settings = Settings.from_env()
    settings.apply_cli_overrides(
        host=args.host,
        port=args.port,
        log_level=args.log_level,
        enable_persistence=args.enable_persistence,
        persistence_dir=args.persistence_dir,
    )
    logging.basicConfig(level=getattr(logging, settings.log_level.upper(), logging.INFO))
    serve(settings=settings)
    return 0


if __name__ == "__main__":  # pragma: no cover
    raise SystemExit(main())


def _configure_persistence(state: ServerState, settings: Settings) -> None:
    if not settings.enable_persistence:
        return

    root = Path(settings.persistence_dir or "data/netcode")
    user_root = root / "users"
    battle_root = root / "battles"
    trade_root = root / "trades"
    queue_path = root / "wondertrade.queue"

    if state.user_repository is None:
        state.user_repository = FilesystemUserRepository(user_root)
    if state.battle_repository is None:
        state.battle_repository = FilesystemBattleRepository(battle_root)
    if state.trade_repository is None:
        state.trade_repository = FilesystemTradeRepository(trade_root)
    if state.wonder_trade_queue is None:
        state.wonder_trade_queue = FilesystemWonderTradeQueue(queue_path)
