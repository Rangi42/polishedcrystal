#!/usr/bin/env python3

"""Analyze Polished Crystal .lzp assets for further compression opportunities.

Focus:
- Remaining literal payload bytes (LZ_DATA) after current compressor decisions
- Coverage of the current pack16 dictionary and run-length distribution
- A rough upper bound on additional savings from better pack16 exploitation

This script parses the *on-disk* LZ stream as implemented by:
- home/decompress.asm
- tools/lz/uncomp.c

It understands the extended opcode bytes $fc-$fe.

Usage:
  utils/lz_analyze_pack16.py [root]

Default root is the repo root.
"""

from __future__ import annotations

import argparse
from collections import Counter
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, Iterator

LZ_END = 0xFF

# Base commands (ids 0..7; 7 is the long prefix)
LZ_DATA          = 0
LZ_REPEAT        = 1
LZ_ALTERNATE     = 2
LZ_ZERO          = 3
LZ_COPY_NORMAL   = 4
LZ_COPY_FLIPPED  = 5
LZ_COPY_REVERSED = 6
LZ_LONG          = 7

# Extended opcode bytes ($fc-$fe)
LZ_EXT_MASK = 0b11111100
LZ_EXT_BASE = 0xFC
LZ_EXT_PACKHI0 = LZ_EXT_BASE + 0  # 0xFC
LZ_EXT_PACK16_SHORT = LZ_EXT_BASE + 1  # 0xFD
LZ_EXT_PACKLO0 = LZ_EXT_BASE + 2  # 0xFE

PACK16_TABLE = bytes(
    [
        0x00, 0xFF, 0x01, 0x02, 0x03, 0xFE, 0x80, 0x07,
        0xC0, 0x7F, 0x04, 0x0F, 0x1F, 0x3F, 0x08, 0xFC,
    ]
)

PACK16_SET = set(PACK16_TABLE)


def _payload_len_packed(out_len: int) -> int:
    return (out_len + 1) // 2


def min_count(cmd: int) -> int:
    # Mirrors tools/lz/util.c:minimum_count
    if cmd == LZ_ALTERNATE:
        return 3
    if cmd == LZ_REPEAT:
        return 2
    return 1


@dataclass(frozen=True)
class ParsedCommand:
    kind: str
    out_len: int
    comp_len: int
    literal_payload: bytes = b""  # only for LZ_DATA


def parse_stream(buf: bytes) -> Iterator[ParsedCommand]:
    i = 0
    n = len(buf)

    while i < n:
        b0 = buf[i]
        i += 1

        if b0 == LZ_END:
            return

        # Extended opcode bytes: $fc-$fe
        if (b0 & LZ_EXT_MASK) == LZ_EXT_BASE:
            if i >= n:
                return
            len_code = buf[i]
            i += 1

            if b0 == LZ_EXT_PACKHI0:
                out_len = len_code + 1
                payload = _payload_len_packed(out_len)
                if i + payload > n:
                    return
                i += payload
                yield ParsedCommand("ext_packhi0", out_len=out_len, comp_len=2 + payload)
                continue

            if b0 == LZ_EXT_PACKLO0:
                out_len = len_code + 1
                payload = _payload_len_packed(out_len)
                if i + payload > n:
                    return
                i += payload
                yield ParsedCommand("ext_packlo0", out_len=out_len, comp_len=2 + payload)
                continue

            if b0 == LZ_EXT_PACK16_SHORT:
                out_len = len_code + 1
            else:
                # 0xFF handled above; 0xFC..0xFE only expected
                return

            payload = _payload_len_packed(out_len)
            if i + payload > n:
                return
            i += payload
            yield ParsedCommand("ext_pack16", out_len=out_len, comp_len=2 + payload)
            continue

        cmd = (b0 >> 5) & 0x7

        if cmd == LZ_LONG:
            # Long header: 111CCCL0 LLLLLLLL (9-bit length; bit 1 is always 0)
            if i >= n:
                return
            b1 = buf[i]
            i += 1
            real_cmd = (b0 >> 2) & 0x7
            enc_len = ((b0 & 0x1) << 8) | b1
            out_len = enc_len + min_count(real_cmd)
            cmd = real_cmd
            header_len = 2
        else:
            enc_len = b0 & 0b11111
            out_len = enc_len + min_count(cmd)
            header_len = 1

        if cmd == LZ_DATA:
            if i + out_len > n:
                return
            payload = buf[i : i + out_len]
            i += out_len
            yield ParsedCommand("data", out_len=out_len, comp_len=header_len + out_len, literal_payload=payload)
        elif cmd == LZ_ZERO:
            yield ParsedCommand("zero", out_len=out_len, comp_len=header_len)
        elif cmd == LZ_REPEAT:
            if i >= n:
                return
            i += 1
            yield ParsedCommand("repeat", out_len=out_len, comp_len=header_len + 1)
        elif cmd == LZ_ALTERNATE:
            if i + 2 > n:
                return
            i += 2
            yield ParsedCommand("alternate", out_len=out_len, comp_len=header_len + 2)
        elif cmd in (LZ_COPY_NORMAL, LZ_COPY_FLIPPED, LZ_COPY_REVERSED):
            if i >= n:
                return
            off0 = buf[i]
            i += 1
            if off0 & 0x80:
                # relative
                yield ParsedCommand("copy", out_len=out_len, comp_len=header_len + 1)
            else:
                if i >= n:
                    return
                i += 1
                yield ParsedCommand("copy", out_len=out_len, comp_len=header_len + 2)
        else:
            # invalid
            return


def find_lz_files(root: Path) -> Iterable[Path]:
    # Avoid build artifacts and git metadata.
    excluded = {".git", "build"}

    for path in root.rglob("*.lzp"):
        # Skip dirs that include excluded components
        if any(part in excluded for part in path.parts):
            continue
        yield path


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("root", nargs="?", default=".")
    ap.add_argument("--top", type=int, default=32, help="show top N literal bytes")
    args = ap.parse_args()

    root = Path(args.root)

    totals = Counter()
    literal_byte_hist = Counter()
    literal_in_table = 0
    literal_total = 0

    run_len_hist = Counter()
    run_savings_bestcase = 0

    file_count = 0
    bad_files = 0

    for f in find_lz_files(root):
        try:
            buf = f.read_bytes()
        except Exception:
            bad_files += 1
            continue

        file_count += 1
        totals["files"] += 1
        totals["compressed_bytes"] += len(buf)

        stream_comp = 0
        stream_out = 0

        for cmd in parse_stream(buf):
            totals[f"cmd_{cmd.kind}"] += 1
            totals[f"out_{cmd.kind}"] += cmd.out_len
            totals[f"comp_{cmd.kind}"] += cmd.comp_len
            stream_comp += cmd.comp_len
            stream_out += cmd.out_len

            if cmd.kind == "data":
                payload = cmd.literal_payload
                literal_total += len(payload)
                literal_byte_hist.update(payload)

                in_table_flags = [b in PACK16_SET for b in payload]
                literal_in_table += sum(in_table_flags)

                # Scan maximal runs of table bytes.
                run = 0
                for ok in in_table_flags:
                    if ok:
                        run += 1
                    else:
                        if run:
                            run_len_hist[run] += 1
                            # Best-case savings if this run were encoded as pack16
                            # instead of raw literal bytes (ignoring any header split costs).
                            run_savings_bestcase += max(0, run - (2 + (run + 1) // 2))
                            run = 0
                if run:
                    run_len_hist[run] += 1
                    run_savings_bestcase += max(0, run - (2 + (run + 1) // 2))

        # If our parser computed fewer bytes than file size, remaining are padding.
        totals["stream_bytes"] += stream_comp + 1  # + terminator
        totals["stream_out_bytes"] += stream_out

    print(".lzp analysis")
    print(f"  files: {file_count}  (read errors: {bad_files})")
    print(f"  total compressed bytes (file sizes): {totals['compressed_bytes']:,}")
    print(f"  total stream bytes (parsed, incl terminators): {totals['stream_bytes']:,}")
    print(f"  total decompressed bytes (sum of command outputs): {totals['stream_out_bytes']:,}")

    if literal_total:
        frac = literal_in_table / literal_total
        print("\nRemaining LZ_DATA payload bytes")
        print(f"  total literal payload bytes: {literal_total:,}")
        print(f"  bytes in current pack16 table: {literal_in_table:,} ({frac:.1%})")

        print("\nTop literal bytes (LZ_DATA payload)")
        for b, c in literal_byte_hist.most_common(args.top):
            mark = "*" if b in PACK16_SET else " "
            print(f"  {mark} 0x{b:02x}: {c:,} ({c / literal_total:.2%})")

        # Run-length overview
        if run_len_hist:
            total_runs = sum(run_len_hist.values())
            long_runs = sum(cnt for rl, cnt in run_len_hist.items() if rl >= 6)
            print("\nRuns of table-bytes inside LZ_DATA payload")
            print(f"  runs: {total_runs:,}  (len>=6: {long_runs:,})")
            # Show a compact tail of run lengths.
            for rl in sorted(run_len_hist)[:12]:
                print(f"  len {rl:2d}: {run_len_hist[rl]:,}")
            tail = sorted([rl for rl in run_len_hist if rl > 12])
            if tail:
                for rl in tail[:10]:
                    print(f"  len {rl:2d}: {run_len_hist[rl]:,}")
                if len(tail) > 10:
                    print("  …")

            print("\nPack16 extra-savings best-case (very optimistic)")
            print("  This assumes every table-only run inside remaining literals could be encoded")
            print("  as pack16 with no extra splitting/header overhead and no interaction with other opcodes.")
            print(f"  estimated upper bound: {run_savings_bestcase:,} bytes")

    print("\nCommand mix (compressed bytes by kind)")
    for kind in ("data", "repeat", "alternate", "zero", "copy", "ext_packhi0", "ext_packlo0", "ext_pack16"):
        comp = totals.get(f"comp_{kind}", 0)
        out = totals.get(f"out_{kind}", 0)
        if comp or out:
            print(f"  {kind:10s} comp={comp:,}  out={out:,}")

    print("\nNext-step ideas to evaluate")
    print("  - If a large fraction of remaining LZ_DATA bytes are in the pack16 table, but broken up")
    print("    by a few out-of-table bytes, an 'escape' variant of pack16 (table indices + escape literal)")
    print("    could yield another multi-KB win without needing table-perfect runs.")
    print("  - If a small set of *out-of-table* bytes dominate the remaining literals, retuning PACK16_TABLE")
    print("    (or adding a second dictionary opcode) may yield more savings.")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
