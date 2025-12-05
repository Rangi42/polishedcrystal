# Netcode Migration Plan

The migration is complete: `netcode.server` is now the sole Polished Online entrypoint and the legacy `testserver.py` script has been removed. Operators should launch the server with `python -m netcode serve` (or the equivalent module invocation in their process manager).

## Operational checklist

1. **Deploy the new entrypoint** – update service units/launch scripts to run `python -m netcode serve --host 0.0.0.0 --port 57409` (plus any desired flags). There is no longer a legacy code path.
2. **Verify parity** – keep running the pytest integration suite (`netcode/tests/test_server_integration.py`) and the ROM smoke tests whenever protocol changes are made to guarantee ongoing compatibility with the handheld client.
3. **Monitor persistence** – enable filesystem persistence (or a custom repository implementation) in staging before rolling to production so you can validate disk usage and backup flows.

## Persistence feature flag

Use the new feature flag to stage durable storage independently of the server swap:

```bash
# Enable filesystem persistence and store artifacts under /var/polished-online
PO_SERVER_ENABLE_PERSISTENCE=1 \
PO_SERVER_PERSISTENCE_DIR=/var/polished-online \
python -m netcode serve --host 0.0.0.0 --port 57409
```

Keeping the flag optional lets us test migrations, backups, and schema changes in isolation. When the real database layer is ready, hook the repository interfaces into the new backend but keep the same environment variables/CLI switches so operators can fall back to the filesystem staging area by toggling the flag.
