# Netcode Compatibility Notes

Polished Online must remain bit-for-bit compatible with the original `testserver.py`. The refactor preserves this by:

- Keeping every wire struct identical. `netcode/tests/test_compatibility.py` freezes representative `SETINFO` payloads so regressions show up immediately.
- Maintaining the same battle/trade flow semantics: host actions remain in the high nibble for hosts, client views are swapped, pending invite signals still use `ASKBATTLE`/`ASKTRADE` with the opposing user ID.
- Documenting the lock and disconnect lifecycle so new code never changes observable timing (see `docs/netcode-locking.md`).

When extending the protocol, add new regression fixtures alongside the feature so we know exactly what the handheld expects.

## ROM expectations

- `home/mobile.asm::PO_ExchangeData` always transmits a single command byte first and then streams the payload without a length prefix. The server-side `ensure_length` calls must mirror the handheld’s incremental `recv` pattern or commands like `SETINFO` will desync.
- `engine/mobile/server.asm::PO_UploadPlayerData` sends chunks strictly in the order `0..3` and refuses to retry if the connection is dropped mid-stream. Tests should therefore exercise all four `SETINFO` uploads on one socket to ensure our persistence hooks stay atomic.
- `engine/mobile/server.asm::PO_ServerCommand` expects `LISTUSERS` replies to start with a player count byte followed by `[user_id, otid_hi, otid_lo, name]` entries. The new socket-level test asserts this so ROM side parsing continues to work without changes.
- `netcode/tests/fixtures/sample_chunk0.hex` freezes the exact bytes produced by the ROM's chunk-0 upload routine (OTID `0x1234`, party count `5`). Tests load the hex fixture and compare it against `User.serialize_chunk(0)` so we notice any padding/ordering regressions immediately.
