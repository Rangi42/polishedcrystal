# Netcode Locking Guide

The refactored server keeps a handful of locks to coordinate concurrent socket threads. Follow this order whenever multiple locks are required:

1. `ServerState.lock` – ID generation for users/battles.
2. `ServerState.users_lock` – mutations to the user dictionary.
3. Per-user `User.lock` – acquired via `netcode.handlers.common.lock_users`.
4. `ServerState.battles_lock` – mutations to the battle dictionary.
5. Per-battle `Battle.lock` – protects turn logs and RNG buffers.

Acquire locks in ascending order and release them in reverse to avoid deadlocks. The `lock_users` helper already sorts user IDs before grabbing their `User.lock` instances, so handler code can simply write `with lock_users(state, requester_id, target_id)` without worrying about ordering.

## Disconnect cleanup

`ServerState.handle_disconnect` centralizes the teardown for dropped clients: it marks the user as disconnected, releases any pending battle/trade (resetting the opponent's `battle_id` if necessary), detaches the session entry, and prunes stale sessions whose sockets were already closed. Always call `CommandContext.disconnect`, which delegates to this helper before shutting down the socket.
