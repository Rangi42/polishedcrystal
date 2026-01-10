from __future__ import annotations

from netcode.metrics import InMemoryMetrics, NoOpMetrics


def test_in_memory_metrics_counts_labels() -> None:
    metrics = InMemoryMetrics()
    metrics.incr("commands.ok", command="STATUS")
    metrics.incr("commands.ok", command="STATUS")
    metrics.incr("commands.error", command="LISTUSERS")
    assert metrics.counters[("commands.ok", (("command", "STATUS"),))] == 2
    assert metrics.counters[("commands.error", (("command", "LISTUSERS"),))] == 1


def test_noop_metrics_drops_data() -> None:
    metrics = NoOpMetrics()
    metrics.incr("anything")
    assert isinstance(metrics, NoOpMetrics)
