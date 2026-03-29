#!/usr/bin/env python3

from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

# Each entry maps to the make targets required for a given artifact prefix.
VARIANTS = [
    ("polishedcrystal", []),
    ("polishedcrystal-faithful", ["faithful"]),
    ("polishedcrystal-debug", ["debug"]),
    ("polishedcrystal-faithful-debug", ["faithful", "debug"]),
]


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Build release-ready Polished Crystal artifacts and collect them in ./build."
    )
    parser.add_argument(
        "-v",
        "--version",
        help="Release version identifier, e.g. 3.1.0. If omitted, you will be prompted.",
    )
    parser.add_argument(
        "-j",
        "--jobs",
        type=int,
        help="Number of parallel jobs to pass to make (defaults to CPU count).",
    )
    return parser.parse_args()


def prompt_for_version() -> str:
    response = input("Enter release version (e.g. 3.1.0): ").strip()
    if not response:
        print("Version is required to tag artifacts.", file=sys.stderr)
        sys.exit(1)
    return response


def run_make(repo_root: Path, version: str, jobs: int, goals: list[str]) -> None:
    job_flag = f"-j{jobs}" if jobs > 0 else "-j"
    cmd = ["make", job_flag, f"VERSION={version}"] + goals
    print(" ".join(cmd), flush=True)
    subprocess.run(cmd, cwd=repo_root, check=True)


def move_into_build(repo_root: Path, build_dir: Path, filename: str) -> None:
    src = repo_root / filename
    if not src.exists():
        raise FileNotFoundError(f"Expected artifact missing: {filename}")
    dest = build_dir / filename
    if dest.exists():
        dest.unlink()
    shutil.move(str(src), str(dest))


def build_variant(repo_root: Path, build_dir: Path, version: str, jobs: int, prefix: str, goals: list[str]) -> None:
    print(f"Building {prefix}-{version}")
    run_make(repo_root, version, jobs, goals)
    move_into_build(repo_root, build_dir, f"{prefix}-{version}.gbc")
    move_into_build(repo_root, build_dir, f"{prefix}-{version}.sym")
    run_make(repo_root, version, jobs, ["tidy"])
    run_make(repo_root, version, jobs, goals + ["vc"])
    move_into_build(repo_root, build_dir, f"{prefix}-{version}.patch")
    run_make(repo_root, version, jobs, ["tidy"])


def main() -> None:
    args = parse_args()
    version = args.version or prompt_for_version()
    jobs = args.jobs or (os.cpu_count() or 1)

    script_dir = Path(__file__).resolve().parent
    repo_root = script_dir.parent
    build_dir = repo_root / "build"
    build_dir.mkdir(exist_ok=True)

    try:
        for prefix, goals in VARIANTS:
            build_variant(repo_root, build_dir, version, jobs, prefix, goals)
    except subprocess.CalledProcessError as error:
        print(f"make failed with exit code {error.returncode}", file=sys.stderr)
        sys.exit(error.returncode)
    except FileNotFoundError as error:
        print(error, file=sys.stderr)
        sys.exit(1)

    print("All artifacts ready in ./build")


if __name__ == "__main__":
    main()
