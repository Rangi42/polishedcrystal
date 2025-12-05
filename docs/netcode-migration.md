# Netcode Migration Plan

The refactored `netcode/` package now runs side-by-side with the legacy `testserver.py` script so we can switch gradually without disrupting the existing deployment.

## Phased rollout

1. **Shadow traffic** – deploy the refactor behind the legacy CLI: `python testserver.py --refactor`. This spins up the new `netcode.server` entrypoint but keeps the old script available (default behavior with no flags).
2. **Parity verification** – run the existing ROM/client test suites against both `python testserver.py` (legacy) and `python testserver.py --refactor` to confirm the new stack is stable. The pytest integration suite (`netcode/tests/test_server_integration.py`) covers the most critical flows automatically.
3. **Flip the default** – once parity is proven, update operational scripts/service units to call `python -m netcode serve` directly, leaving the legacy script only for emergency fallback.

## Persistence feature flag

Use the new feature flag to stage durable storage independently of the server swap:

```bash
# Enable filesystem persistence and store artifacts under /var/polished-online
PO_SERVER_ENABLE_PERSISTENCE=1 \
PO_SERVER_PERSISTENCE_DIR=/var/polished-online \
python -m netcode serve --host 0.0.0.0 --port 57409
```

Keeping the flag optional lets us test migrations, backups, and schema changes in isolation. When the real database layer is ready, hook the repository interfaces into the new backend but keep the same environment variables/CLI switches so operators can fall back to the filesystem staging area by toggling the flag.
