# Netcode Persistence Plan

The refactored server exposes repository interfaces under `netcode.storage` so that the default in-memory data structures can be swapped for SQLite, Postgres, or any other storage backend without touching the wire protocol.

## User blobs

`UserRepository` receives the entire serialized user payload (OT, nicknames, mail) as opaque byte arrays. Production backends should store these blobs in binary columns (`BYTEA`/`BLOB`) so we keep perfect parity with the Game Boy structs and avoid lossy conversions. The built-in filesystem backend persists each upload to `data/netcode/users/user_<id>.bin` (or the directory configured via `--persistence-dir`).

## Battle and trade logs

`BattleRepository.log_event` and `TradeRepository.log_trade` are triggered whenever new battle or trade turn payloads are generated. These bytes should also be written verbatim to binary fields so investigators can replay turns later. The filesystem backend stages these logs as hex-encoded lines under `battles/battle_<id>.log` and `trades/trade_<id>.log`, while metadata goes into companion JSON files. This is intentionally simple so the feature flag can be enabled before the real database schema lands.

## Wonder Trade queue

`WonderTradeQueue` abstracts the upcoming wonder-trade feature. Its interface mirrors a durable FIFO queue; the default implementation is an in-memory deque, but the filesystem backend flushes the queue to `wondertrade.queue` with length-prefixed blobs so entries survive restarts.

## Feature flag rollout

- Set `PO_SERVER_ENABLE_PERSISTENCE=1` (or pass `--enable-persistence`) to activate the filesystem repositories. Pair it with `PO_SERVER_PERSISTENCE_DIR=/path/to/dir` if the default `data/netcode` is not suitable.
- Leave the flag off in production until the new schema is ready; the legacy script will continue to run in-memory and behave exactly as it always has.
- Once the database migrations are finalized, point the repository hooks to the SQL-backed implementations but keep the same CLI flag so we can toggle back to the filesystem staging area if necessary.

These hooks, combined with the `ServerState` helpers, define explicit transaction boundaries for each mutation (user updates, battle/trade turns, wonder-trade submissions) and make it straightforward to plug in durable storage when the schema is finalized.
