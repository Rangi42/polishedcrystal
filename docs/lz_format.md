# Polished Crystal LZ format (Crystal / LC_LZ3-derived)

This project uses a variant of Pokémon Crystal's LZ compression format,
sometimes referred to as "Polished LZ."

It is broadly compatible with the command set described in the LC_LZ3 reference:
https://github.com/bonimy/MushROMs/blob/master/doc/LC_LZ3%20Compression%20Format.md

However, Polished Crystal has **intentional format differences** (documented below), including new extended opcode bytes. The standard `lzcomp` / `lz.py` tools cannot handle this format; only the custom compressor in `tools/lzcomp` produces valid streams.

Compressed assets use the **`.lzp`** file extension ("LZ Polished") to distinguish them from standard `.lz` files.

## Format history

Polished Crystal's LZ format has diverged from vanilla Pokémon Crystal in
several stages:

1. **Raise minimum counts** (`ca95feb`): Changed `LZ_REPEAT` minimum to 2 and
   `LZ_ALTERNATE` minimum to 3. This slightly improves compression density and
   mostly eliminates overlapping command encodings.
2. **Shorten long-header length field** (`2d48f4f`): Reduced the long-header
   length from 10 bits to 9 bits (`111CCCL0 LLLLLLLL`; bit 1 always `0`).
   This makes decompression noticeably faster with a minor trade-off in maximum
   encodable length.
3. **Extended opcodes** (this branch): Added packed-literal opcodes
   `0xfc`–`0xfe` (`lzpackhi0`, `lzpack16`, `lzpacklo0`) for more compact
   representation of common byte patterns.

See "Key differences vs the LC_LZ3 reference" below for a summary.

## Stream structure

An LZ-compressed stream is a sequence of commands terminated by a single byte:

- `0xff` (`LZ_END`) marks end-of-stream.
- Optional padding bytes may follow the terminator (the build system may align blobs; padding is typically `0x00`).

## Base command headers

### Short header (1 byte)

```
bits: 76543210
      CCCLLLLL

CCC: command id (0..6)
LLLLL: length field (0..31)
```

### Long header (2 bytes)

```
111CCCL0 LLLLLLLL

CCC: command id (0..6)
L LLLLLLLL: 9-bit length field
```

In other words, the first byte is in the range `0xe0..0xff`.

Note: unlike the LC_LZ3 reference (10-bit long lengths), Polished Crystal’s long header stores only **one** high length bit (bit 0). Bit 1 is always `0`. This is an older optimization that trades a slightly smaller length range for faster decompression.

### Output length computation (important customization)

Unlike the LC_LZ3 document (which describes output length as `(L + 1)` for all commands), **this project uses per-command minimum lengths** and stores:

- `encoded_length = output_length - minimum_length(command)`

Minimum output lengths:

- `LZ_DATA` (0): 1
- `LZ_REPEAT` (1): 2
- `LZ_ALTERNATE` (2): 3
- `LZ_ZERO` (3): 1
- `LZ_COPY_NORMAL` (4): 1
- `LZ_COPY_FLIPPED` (5): 1
- `LZ_COPY_REVERSED` (6): 1

So, for example:

- A 2-byte `LZ_REPEAT` is encoded with `encoded_length = 0`.
- A 1-byte `LZ_DATA` is encoded with `encoded_length = 0`.

The current toolchain constrains **base** command output lengths to at most 512 bytes.

The extended pack opcodes (`0xfc..0xfe`) store an 8-bit `len-1` length code, so they are
currently limited to output lengths in `1..256`.

## Base commands (0..6)

Command ids match the LC_LZ3 description:

- `%000` (`LZ_DATA`): literal bytes follow the header.
- `%001` (`LZ_REPEAT`): one byte follows; output it repeatedly.
- `%010` (`LZ_ALTERNATE`): two bytes follow; output them alternating (`ABAB…`).
- `%011` (`LZ_ZERO`): output `0x00` repeatedly.
- `%100` (`LZ_COPY_NORMAL`): copy bytes from prior output.
- `%101` (`LZ_COPY_FLIPPED`): like copy, but bit-reverse each copied byte.
- `%110` (`LZ_COPY_REVERSED`): like copy, but copy bytes in reverse order.

### `LZ_DATA` payload

After the header, `output_length` raw bytes follow and are copied directly to output.

### `LZ_REPEAT` payload

After the header, 1 byte follows (the repeated value).

### `LZ_ALTERNATE` payload

After the header, 2 bytes follow (`A`, then `B`). Output alternates `A`, `B`, `A`, `B`, …

### Copy commands payload (offset encoding)

Copy commands (`LZ_COPY_*`) are followed by either a 1-byte **relative** offset or a 2-byte **absolute** offset.

#### Relative offset (1 byte)

If the first offset byte has bit 7 set (`0x80..0xff`), it encodes a negative offset from the current output position.

- Byte `0x80` means offset `-1`
- Byte `0x81` means offset `-2`
- …
- Byte `0xff` means offset `-128`

Equivalently: `offset = 127 - byte` (yielding `-1..-128`).

This is the “AYYYYYYY with A=1” form in the LC_LZ3 doc.

#### Absolute offset (2 bytes)

If the first offset byte has bit 7 clear (`0x00..0x7f`), a second byte follows.

The 15-bit value is an offset from the **start of the decompression output buffer** (not from the current output position):

- `absolute = (high << 8) | low`
- `source = output_start + absolute`

This is the “AYYYYYYY ZZZZZZZZ with A=0” form in the LC_LZ3 doc.

### Copy variants

- `LZ_COPY_NORMAL`: copy bytes in forward order.
- `LZ_COPY_REVERSED`: copy bytes in reverse order (the address points at the first byte to copy; it decrements each byte).
- `LZ_COPY_FLIPPED`: like normal copy, then bit-reverse each byte (e.g. `0xaf` → `0xf5`).

### LZ77-style overlap

Copy sources may overlap with the region being written. The decompressor reads from the output buffer one byte at a time, so a copy offset of `−1` with length `N` replicates the last emitted byte `N` times (similar to `LZ_REPEAT`). More generally, when the copy source is closer than `count` bytes, the pattern repeats with a period equal to the distance. The compressor exploits this for periodic patterns that `LZ_REPEAT` (period 1) and `LZ_ALTERNATE` (period 2) cannot express.

## Extended opcodes (`0xfc`–`0xfe`) (customization)

Polished Crystal defines additional commands using single-byte “extended opcode” headers:

- `0xfc` (`LZ_EXT_PACKHI0`)
- `0xfd` (`LZ_EXT_PACK16_SHORT`)
- `0xfe` (`LZ_EXT_PACKLO0`)

These values are in the `0xe0..0xff` range, but are treated specially by the decompressor. (`0xff` remains the stream terminator.)

### Common extended header layout

```
byte0: 111111ss  (0xfc..0xfe)
byte1: length code
```

Where `ss` is the subtype:

- `00`: `0xfc` (packhi0)
- `01`: `0xfd` (pack16 short)
- `10`: `0xfe` (packlo0)

### `0xfc` — `lzpackhi0` packed high nibbles

Emit literal bytes whose low nibble is always `0`, packed two bytes per payload byte.

- Header: `0xfc <len-1>`
- Output length: `len` in `1..256`

#### Payload

After the 2-byte header, `ceil(len/2)` payload bytes follow.

Each payload byte contains two 4-bit values:

- high nibble: high nibble of the first output byte
- low nibble: high nibble of the second output byte (absent if `len` is odd)

The output bytes are reconstructed as:

- first output byte = `(payload & 0xf0)`
- second output byte = `((payload & 0x0f) << 4)`

### `0xfd` — `lzpack16` packed literals

Emit literal bytes, but packed as 4-bit indices into a fixed 16-entry table.

#### Length

- `0xfd <len-1>` emits `len` bytes, where `len` is in `1..256`.

#### Payload

After the 2-byte header, `ceil(len/2)` payload bytes follow.

Each payload byte contains two 4-bit indices:

- high nibble: first output byte
- low nibble: second output byte (absent if `len` is odd)

#### Dictionary table

The 16-entry dictionary is:

```
index:  0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F
value: 00   ff   01   02   03   fe   80   07   c0   7f   04   0f   1f   3f   08   fc
```

This choice is intentionally biased toward very common bytes in graphics/tile data.

### `0xfe` — `lzpacklo0` packed low nibbles

Emit literal bytes whose high nibble is always `0`, packed two bytes per payload byte.

- Header: `0xfe <len-1>`
- Output length: `len` in `1..256`

#### Payload

After the 2-byte header, `ceil(len/2)` payload bytes follow.

Each payload byte contains two 4-bit values:

- high nibble: low nibble of the first output byte
- low nibble: low nibble of the second output byte (absent if `len` is odd)

The output bytes are reconstructed as:

- first output byte = `(payload >> 4)`
- second output byte = `(payload & 0x0f)`

## Key differences vs the LC_LZ3 reference

The LC_LZ3 document is a useful mental model for the *base* command set, but Polished Crystal differs in important ways:

1. **Per-command minimum lengths** (see "Format history" §1): output length is **not always** `(L + 1)`. Each command has its own minimum count (e.g., `LZ_REPEAT` stores `output_length - 2`).
2. **Long header length is 9-bit, not 10-bit** (see "Format history" §2): the header is `111CCCL0 LLLLLLLL`, where bit 1 of the first byte is always `0`.
3. **New extended opcode bytes** (see "Format history" §3): `0xfc..0xfe` add `lzpackhi0`, `lzpack16`, and `lzpacklo0` packed-literal commands.
4. **Practical maximum length**: the current compressor/tooling bounds **base** command output lengths to 512 bytes (the extended pack opcodes are `1..256`).

## Implementation reference

| Component | Language | Location |
|---|---|---|
| Runtime decompressor | Game Boy ASM | `home/decompress.asm` |
| Compressor (DP‑optimal) | C | `tools/lz/dpcomp.c` |
| Serialization / output | C | `tools/lz/output.c` |
| Decompressor (tool‑side) | C | `tools/lz/uncomp.c` |
| Shared constants & helpers | C | `tools/lz/proto.h`, `tools/lz/util.c` |
| Post‑hoc analysis | Python | `utils/lz_analyze_pack16.py` |

## Named constants

Key named constants from `tools/lz/proto.h`:

| Constant | Value | Meaning |
|---|---|---|
| `MAX_FILE_SIZE` | 32768 | Maximum uncompressed data size |
| `SHORT_COMMAND_COUNT` | 32 | Short-header count field range (5 bits) |
| `MAX_COMMAND_COUNT` | 512 | Max encoded count for base commands |
| `MAX_EXT_COUNT` | 256 | Max output count for extended opcodes |
| `LOOKBACK_LIMIT` | 128 | Max negative offset for copy commands |
| `PACK16_TABLE_SIZE` | 16 | Entries in the pack16 dictionary |
| `LZ_END` | `0xff` | Stream terminator byte |

## Tooling notes

The `tools/lzcomp` sources use an internal pseudo-command id `7` to represent extended opcodes while optimizing/printing commands. This `7` is **not** written as a base-format `LZ_LONG` command; it is serialized using the `0xfc..0xfe` bytes described above.
