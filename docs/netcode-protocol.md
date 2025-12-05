# Polished Online Link Protocol

This document freezes the protocol spoken between the Polished Online TCP server and the Game Boy ROM as originally implemented in `testserver.py` (now superseded by `netcode.server`). All byte counts remain wire-compatible with that legacy script.

## Transport basics

- TCP server listens on port `57409` (`PO_PORT`).
- Client requests begin with a single command byte (`PO_CMD_*`) followed by a fixed-length payload that the server determines from the command and any chunk selector bytes. Requests have no length prefix.
- Server responses always start with a one-byte payload length (`len(payload)`), followed by either the echoed command byte or a signal byte. The remaining bytes are command-specific data.
- Signals (`PO_SIGNAL_*`) replace the echoed command byte whenever the server needs to notify the client asynchronously (e.g., when someone issues a battle invite). Signals are only emitted immediately before servicing `LISTUSERS`, `BATTLEUSER`, or `TRADEUSER` commands while a pending invite exists.

## Command reference

| ID (hex) | Command | Request payload | Success reply payload | Notes |
| --- | --- | --- | --- | --- |
| `00` | `PO_CMD_DISCONNECT` | none | none (server closes socket) | Server also marks the user slot as disconnected.
| `01` | `PO_CMD_STATUS` | none | `01, <user_id>` | `<user_id>` is the server-assigned slot. If the server is closing, it returns `PO_STATUS_CLOSED (0x00)` instead.
| `02` | `PO_CMD_WONDERTRADE` | *not implemented* | *not implemented* | Placeholder only.
| `03` | `PO_CMD_SETINFO` | `<chunk_id>, <chunk_payload>` | `03` | Uploads player data in chunks (see "Player info chunks"). Each successful chunk bumps the user’s `infoversion`.
| `04` | `PO_CMD_GETINFO` | `<target_id>, <chunk_id>` | `04, <chunk_bytes>` | Returns the exact bytes previously uploaded via `SETINFO`. Chunk selection matches uploads.
| `05` | `PO_CMD_LISTUSERS` | none | `05, <count>, ...entries` | Each entry is `<user_id>, <ot_id_hi>, <ot_id_lo>, <NAME_LENGTH bytes player name>` for every connected user.
| `06` | `PO_CMD_BATTLEUSER` | `<target_id>` | `06, 0` or `06, <host_id>, <client_id>` | Returns `0` until both sides accept. Errors return `PO_SIGNAL_ERROR, <err>`.
| `07` | `PO_CMD_TRADEUSER` | `<target_id>` | `07, 0` or `07, <host_id>, <client_id>` | Identical flow to `BATTLEUSER`, but sets `battle.is_trade = True`.
| `08` | `PO_CMD_GETBATTLE` | *not implemented* | *not implemented* | Placeholder only.
| `09` | `PO_CMD_BATTLETURN` | `<action_byte>` | `09, <turn_byte>, <RNG stream?>` | Solicits or delivers battle RNG results. See "Battle/Trade flow".
| `0A` | `PO_CMD_TRADETURN` | `<action_byte>` | `0A, <turn_byte>` | Mirrors battle turns but sends single trade action bytes.
| `0B` | `PO_CMD_SETREPLY` | `<reply_code>` | `0B, 0` or `0B, <host_id>, <client_id>` | `PO_REPLY_ACCEPT (0)`, `PO_REPLY_REJECT (1)`, `PO_REPLY_WAIT (2)`. Reject resets `battleid` to 0.
| `0C` | `PO_CMD_GETINFO_VER` | `<target_id>` | `0C, <version>` | `version` increments every time the target user uploads any info chunk.

### Signals and errors

- `PO_SIGNAL_ERROR (0x81)` is followed by a single error code byte (`PO_ERROR_*`).
- `PO_SIGNAL_ASKBATTLE (0x86)` / `PO_SIGNAL_ASKTRADE (0x87)` are followed by `<challenger_user_id>`. These are only sent while processing `LISTUSERS`, `BATTLEUSER`, or `TRADEUSER` so legacy clients poll for them.

Error codes:

| Code | Meaning |
| --- | --- |
| `00` | OK (used internally)
| `01` | Unknown command
| `02` | Unknown or disconnected user
| `03` | Invalid player info blob
| `04` | Incompatible game versions
| `05` | Action not permitted (self-battle, etc.)
| `06` | User busy with another battle/trade
| `07` | Invite rejected earlier
| `08` | Battle desync detected

## Player info chunks (SETINFO / GETINFO)

All info transfers mirror each other. Requests include `<chunk_id>` immediately after the command byte. Chunk payloads must have the exact lengths below:

| Chunk | Bytes | Contents |
| --- | --- | --- |
| `0` | `2 + 1 + 1 + 11 + 4*0x30 = 207` | `OT ID (big endian)`, `party count`, `gender`, `player name (NAME_LENGTH)`, first four party Pokémon structs (`PARTYMON_STRUCT_LENGTH`).
| `1` | `2*0x30 + 2*NAME_LENGTH*PARTY_LENGTH = 228` | Remaining two party Pokémon structs, all OT names, then all nicknames.
| `2` | `5*MAIL_STRUCT_LENGTH = 235` | First five mail entries.
| `3` | `MAIL_STRUCT_LENGTH = 47` | Sixth mail entry.

`SERIALIZED_USER` is therefore 433 bytes (`2 + NAME_LENGTH + (PARTYMON_STRUCT_LENGTH + 2*NAME_LENGTH) * PARTY_LENGTH`). Each successful upload increments `User.infoversion`. `GETINFO` responses stream the selected byte ranges verbatim; clients must request chunks sequentially to reconstruct the full struct.

## Battle / Trade flow quirks

- Battle and trade invites share the same `Battle` object pool (`users[userid].battleid`). Trades merely flip `battle.is_trade`. A `battleid` of `-1` flags "busy trading" and blocks new invites.
- Acceptance requires the challenger to mark themselves ready via `BATTLEUSER`/`TRADEUSER` (this sets `host_accepted=True`) **and** the invitee to explicitly call `SETREPLY PO_REPLY_ACCEPT` after seeing the ROM prompt. Until both `host_accepted` and `client_accepted` are true, the server keeps returning `0` to invite commands.
- When the invitee next polls and receives `PO_SIGNAL_ASK*`, the ROM now opens an accept/decline prompt showing the challenger’s user ID/name. Choosing “Accept” issues `SETREPLY PO_REPLY_ACCEPT`; choosing “Decline” issues `SETREPLY PO_REPLY_REJECT`. Legacy ROMs that still mirror `BATTLEUSER` remain compatible.
- The server will re-send asynchronous `PO_SIGNAL_ASK*` only when the invitee next issues `LISTUSERS`, `BATTLEUSER`, or `TRADEUSER`. There is no idle push.
- `SETREPLY` with `PO_REPLY_REJECT` now clears **both** users’ `battleid` fields immediately and deletes the shared `Battle`. The challenger learns about the decline via `PO_SIGNAL_ERROR (PO_ERROR_REJECTED)` on their next poll.
- `BATTLETURN` high nibble stores the number of RNG bytes consumed that turn; low nibble stores the action. The first turn forces RNG bytes to zero. Logged RNG bytes are appended to `battle.log` so late responders can catch up.
- `TRADETURN` reuses the same machinery but only exchanges a single action byte per turn (no RNG stream). When both users have submitted matching offsets, the server appends the action to the shared log and unlocks the next turn.

## Known behavior to preserve

- `requestdata` performs blocking reads until the exact byte count for a command chunk arrives. Clients that short-write cause the server to disconnect.
- `PO_CMD_GETBATTLE` and `PO_CMD_WONDERTRADE` are reserved but currently unimplemented; clients never send them in production, so future implementations must keep the IDs intact.
- The user list (`LISTUSERS`) is built under a global lock so the roster order matches connection order. Each entry is exactly `1 + 2 + NAME_LENGTH = 14` bytes to stay consistent with existing parsing logic.
- Battle logs are deleted (`del battles[battleid]`) only when the inviter polls again and the server notices both sides accepted earlier. New code must keep this cleanup behavior or explicitly replace it with equivalent lifecycle hooks.
- Disconnecting a user sets `users[userid].battleid = -1`, ensuring any pending invites against that slot fail with `PO_ERROR_WITHANOTHER` until the slot is recycled.

## Captured quirks for regression tests

1. **Partial info uploads** must arrive in four separate `SETINFO` calls; chunk `0` contains metadata + first four Pokémon only. Attempting to send all 433 bytes at once is rejected.
2. **Asymmetric invite signaling:** signals are only piggybacked on the next list/battle/trade poll. Automated tests should verify that a challenger does **not** receive signals while issuing unrelated commands.
3. **Invite acceptance timing:** if either player disconnects before the opponent polls again, the server clears both `battleid` fields and drops the `Battle` object silently.
4. **Battle RNG logging:** when one side lags behind, `BATTLETURN` responses replay from the accumulated log before emitting fresh RNG bytes.
5. **Info version counter:** every chunk upload increments `infoversion`, so four uploads in a row increase the version by four. Clients rely on this to detect partial updates.

These notes should be mirrored in future implementations and regression fixtures.

## Flow walkthroughs

### Connection and info uploads

1. **STATUS** – the cartridge sends `PO_CMD_STATUS` immediately after connecting. The server responds with the assigned user ID (and `PO_STATUS_CLOSED` if maintenance mode is active).
2. **SETINFO x4** – clients must upload chunks `0` through `3` sequentially. The server increments `User.info_version` after each chunk and persists the blob through `ServerState.persist_user`.
3. **LISTUSERS** – once info is uploaded, clients poll the roster. The response mirrors what the ROM expects (`[count][user entries…]`). Any pending battle/trade signals are piggybacked here.
4. **GETINFO / GETINFO_VER** – when selecting an opponent, the ROM fetches the remote user's chunks and version before starting a link session. Tests must ensure the server always returns bytes identical to what the opponent uploaded.

### Battle invite flow

1. **Host issues `BATTLEUSER <target>`** – `battle.handle_battle_user` allocates a `Battle`, marks the host as accepted, and returns `0` until the opponent answers. The host keeps polling once per second by sending `SETREPLY PO_REPLY_WAIT` (see `PO_RequestBattle`).
2. **Signal propagation** – the next time the opponent issues `LISTUSERS`, `BATTLEUSER`, or `TRADEUSER`, `maybe_pending_signal` sends `PO_SIGNAL_ASKBATTLE` with the host's user ID.
3. **Invite prompt** – upon receiving the signal, the ROM shows the challenger’s ID/name and asks whether to accept. Declining immediately sends `SETREPLY PO_REPLY_REJECT`, clears both players’ `battleid`, and shows “Battle declined” before returning to the roster.
4. **Acceptance** – if the invitee chooses “Accept”, the ROM issues `SETREPLY PO_REPLY_ACCEPT`. Mirroring `BATTLEUSER` is no longer required (though legacy ROMs that still do so stay compatible). When both sides have responded positively, subsequent `BATTLEUSER` polls return `[host_id, client_id]`, signalling readiness.
5. **Data fetch** – both parties run `GETINFO`/`GETINFO_VER` to pull the opponent's profile.
6. **Turn exchange** – once in-battle, every `BATTLETURN` call writes the action (low nibble) and RNG byte count (high nibble) into the shared log. Lagging players receive replayed bytes before fresh RNG is appended.

### Trade invite flow

Trades reuse the same structures with `battle.is_trade=True`:

1. Challenger issues `TRADEUSER <target>` and, like battles, loops by sending `SETREPLY PO_REPLY_WAIT` while awaiting the opponent.
2. Invitee polls `LISTUSERS`, receives `PO_SIGNAL_ASKTRADE`, and sees the same accept/decline prompt with the challenger’s identity.
3. Accepting sends `SETREPLY PO_REPLY_ACCEPT` (mirroring `TRADEUSER` is optional); declining sends `PO_REPLY_REJECT`, clears both `battleid`s, and displays “Trade declined.”
4. When both users have accepted the invite, subsequent `TRADEUSER` polls return `[host_id, client_id]` and the ROM transitions into the link trade UI. `TRADETURN` exchanges single-byte actions; pending inputs replay earlier log bytes so both sides stay in sync when someone lags.

### Extending the protocol

When adding a new command (e.g., Wonder Trade, Spectator Mode):

- Reserve a new `PO_CMD_*` ID and document it in this file before writing code. Consistency here keeps the ROM, server, and tests aligned.
- Define request/response payloads explicitly (length, byte order) and add fixtures in `netcode/tests/fixtures` if the ROM already emits the data.
- Update `netcode.handlers` with a dedicated handler module when the logic is substantial (mirroring `battle.py`, `trade.py`, etc.).
- Add regression tests that serialize exact bytes for the command, both for success and error paths. Use the integration harness in `test_server_integration.py` whenever the feature spans multiple sockets.
- Remember to surface new lock order or persistence requirements in `docs/netcode-locking.md` or `docs/netcode-persistence.md` as needed.
- Wire the feature into the `netcode.server` entrypoint behind a feature flag or config gate, then roll it out through the CLI (`python -m netcode serve`). Keep staged rollouts scripted so we can revert quickly.

## Battle / Trade lifecycle diagram

```
	 +-------+   BATTLEUSER/TRADEUSER   +----------------------+
	 | Idle  | -----------------------> | Pending (host ready) |
	 +-------+                          +----------------------+
	      ^                                     |
	      |   signal on LIST/BATTLE/TRADE       |
	      |                                     v
	      |                           +-------------------------+
	      |                           | Invite prompt (client)  |
	      |                           +-----------+-------------+
	      |                                       |
	      |                          decline -----+----> Cleanup/Idle
	      |                                       |
	      |                                       v
	      |                           +-------------------------+
	      |<--------------------------| Awaiting replies        |
	      |   host polls SETREPLY     +-------------------------+
	      |                                       |
	      +---------------------------------------+
	                      both accepted
	                            |
	                            v
	                    +------------------+
	                    | Active battle /  |
	                    | trade            |
	                    +------------------+
	                            |
	                            |
	                            v
	                    +------------------+
	                    | Cleanup / Idle   |
	                    +------------------+
```

- **Signals + prompt**: while in `Pending`, the invitee only hears about the request when running `LISTUSERS`, `BATTLEUSER`, or `TRADEUSER`. The server injects `PO_SIGNAL_ASK*`, after which the ROM shows the accept/decline prompt and records the challenger ID/name.
- **Disconnects**: if either side disconnects at any stage, `ServerState.handle_disconnect` sets their `battle_id = -1`, clears their session, and releases the `Battle` object. The opponent is returned to `Idle` via the next poll without explicit notification.
- **Rejections**: `SETREPLY PO_REPLY_REJECT` from either user clears both users' `battle_id` fields immediately, deletes the `Battle`, and causes the challenger’s next poll to return `PO_SIGNAL_ERROR (PO_ERROR_REJECTED)`.
- **Waiting loop**: challengers continue calling `SETREPLY PO_REPLY_WAIT` while the invite prompt is outstanding; once the invitee accepts, those polls begin returning the paired IDs and the ROM transitions into the link flow.

This textual diagram is meant to mirror the state machine implemented across `netcode.handlers.battle`, `netcode.handlers.trade`, and the ROM routines in `engine/mobile/server.asm`. Keep it in sync whenever lifecycle logic changes.
