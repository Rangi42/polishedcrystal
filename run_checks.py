#!/usr/bin/env python3
"""Run #1179 ROM-routine regressions. Requires a compiled probe and local assets."""
import argparse
import subprocess
import tempfile
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument('probe', type=Path)
parser.add_argument('before_rom', type=Path)
parser.add_argument('after_rom', type=Path)
parser.add_argument('rtas_save', type=Path)
parser.add_argument('kido_save', type=Path)
args = parser.parse_args()
with tempfile.TemporaryDirectory() as directory:
    def run(rom, save, mode, expect_failure=False):
        result = subprocess.run([str(args.probe.resolve()), str(rom), str(save),
                                 str(Path(directory) / 'result'), str(mode)],
                                capture_output=True, text=True)
        if expect_failure:
            assert result.returncode != 0 and 'round trip corrupted payload' in result.stderr, result.stdout + result.stderr
        else:
            assert result.returncode == 0, result.stdout + result.stderr
    run(args.before_rom, args.rtas_save, 'check', expect_failure=True)
    print('PASS: original Rtas payload reproduces corruption before the fix')
    run(args.before_rom, args.rtas_save, 'safe-id')
    print('PASS: changing only trainer ID $75FE -> $75FD eliminates corruption before the fix')
    run(args.before_rom, args.kido_save, 'check')
    print('PASS: Kido control before the fix')
    for save in [args.rtas_save, args.kido_save]:
        run(args.after_rom, save, 'check')
    print('PASS: Rtas and Kido trainer IDs, parties, OT names and nicknames match exactly after the fix')
    for position in range(290):
        run(args.after_rom, args.rtas_save, position)
    print('PASS: $FE independently injected into each of 290 player-ID/party bytes, including both patch-list boundaries')
    run(args.after_rom, args.rtas_save, 'versions')
    print('PASS: trades and battles reject versions 3/4 and accept version 5')
