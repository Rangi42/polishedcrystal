"""Polished Online server package."""

from __future__ import annotations

from importlib import import_module

__all__ = [
    "__version__",
    "serve",
]

__version__ = "0.1.0-dev"


def serve(*, host: str = "0.0.0.0", port: int | None = None, **opts) -> None:
    """Convenience wrapper that defers to :mod:`netcode.server`.

    Delaying the import keeps handler modules lightweight for tooling and unit
    tests that only need serialization or constants.
    """

    server = import_module("netcode.server")
    server.serve(host=host, port=port, **opts)
