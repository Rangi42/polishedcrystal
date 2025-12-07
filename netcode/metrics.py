"""Lightweight metrics helpers used by the server."""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Dict, Protocol, Tuple


class MetricsRecorder(Protocol):
    """Protocol for recording counters."""

    def incr(self, name: str, *, value: int = 1, **labels: str) -> None: ...


@dataclass
class InMemoryMetrics(MetricsRecorder):
    """Simple in-process counter store."""

    counters: Dict[Tuple[str, Tuple[Tuple[str, str], ...]], int] = field(default_factory=dict)

    def incr(self, name: str, *, value: int = 1, **labels: str) -> None:
        key = (name, tuple(sorted(labels.items())))
        self.counters[key] = self.counters.get(key, 0) + value


@dataclass
class NoOpMetrics(MetricsRecorder):
    """Default recorder that intentionally drops all metrics."""

    def incr(self, name: str, *, value: int = 1, **labels: str) -> None:  # pragma: no cover - trivial
        return None


__all__ = ["MetricsRecorder", "InMemoryMetrics", "NoOpMetrics"]
