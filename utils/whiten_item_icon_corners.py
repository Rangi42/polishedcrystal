#!/usr/bin/env python3

"""Replace black corner pixels with white in item icon source PNGs.

By default this scans `gfx/items/*.png`, but only edits files that are:
- 24x24 pixels
- 2-bit greyscale PNGs (the standard item icon format)

It only changes the four outermost corner pixels when they are black (value 0),
turning them white (value 3).
"""

from __future__ import annotations

import argparse
from pathlib import Path
import sys

import png


def iter_targets(patterns: list[str]) -> list[Path]:
    seen = set()
    files = []
    for pattern in patterns:
        for path in sorted(Path().glob(pattern)):
            if path.is_file() and path.suffix.lower() == ".png" and path not in seen:
                seen.add(path)
                files.append(path)
    return files


def fix_file(path: Path, apply: bool) -> tuple[bool, str]:
    reader = png.Reader(filename=str(path))
    width, height, rows_iter, info = reader.read()
    rows = [list(row) for row in rows_iter]

    if width != 24 or height != 24:
        return False, "skip: not 24x24"
    if not info.get("greyscale", False):
        return False, "skip: not greyscale"
    if info.get("bitdepth") != 2:
        return False, "skip: not 2bpp greyscale"
    if info.get("planes") != 1:
        return False, "skip: unexpected planes"

    corners = ((0, 0), (width - 1, 0), (0, height - 1), (width - 1, height - 1))
    changed = 0
    for x, y in corners:
        if rows[y][x] == 0:
            rows[y][x] = 3
            changed += 1

    if changed == 0:
        return False, "ok: no black corners"

    if apply:
        writer = png.Writer(width, height, greyscale=True, bitdepth=2, compression=9)
        with path.open("wb") as out:
            writer.write(out, rows)

    return True, f"changed {changed} corner(s)"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "patterns",
        nargs="*",
        default=["gfx/items/*.png"],
        help="Glob pattern(s) to scan (default: gfx/items/*.png)",
    )
    parser.add_argument(
        "--apply",
        action="store_true",
        help="Write changes to disk (default is dry-run)",
    )
    args = parser.parse_args()

    targets = iter_targets(args.patterns)
    if not targets:
        print("No PNG files matched.", file=sys.stderr)
        return 1

    changed_files = 0
    for path in targets:
        changed, message = fix_file(path, apply=args.apply)
        if changed:
            changed_files += 1
        prefix = (
            "EDIT"
            if (changed and args.apply)
            else ("WOULD_EDIT" if changed else "SKIP")
        )
        print(f"{prefix:10} {path} - {message}")

    if args.apply:
        print(f"\nUpdated {changed_files} file(s).")
    else:
        print(
            f"\nDry-run: {changed_files} file(s) would be updated. Use --apply to write."
        )

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
