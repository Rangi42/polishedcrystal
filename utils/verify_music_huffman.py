#!/usr/bin/env python3
"""Verify streamed music blocks against the Huffman tables in a built ROM."""

from __future__ import annotations

import argparse
import re
from pathlib import Path


CODE_RE = re.compile(r"^musichuff(?:map|esc) \$([0-9a-f]{2}), (?:\d+, )?([01]+)")
SYMBOL_RE = re.compile(r"^([0-9a-f]+):([0-9a-f]+) (.+)$", re.IGNORECASE)
TREE_SYMBOL = "MusicHuffmanTree"
LEAVES_SYMBOL = "MusicHuffmanLeaves"
FIRST_LEAF = 0x80
ESCAPE_LEAF = 0xFF


def rom_offset(bank: int, address: int) -> int:
	return bank * 0x4000 + address - 0x4000 if bank else address


def read_symbols(path: Path) -> dict[str, tuple[int, int]]:
	symbols: dict[str, tuple[int, int]] = {}
	for line in path.read_text(encoding="utf-8").splitlines():
		match = SYMBOL_RE.match(line)
		if match:
			bank, address, name = match.groups()
			symbols[name] = int(bank, 16), int(address, 16)
	return symbols


def read_codes(path: Path) -> dict[int, str]:
	codes: dict[int, str] = {}
	for line in path.read_text(encoding="utf-8").splitlines():
		match = CODE_RE.match(line)
		if match:
			value, bits = match.groups()
			codes[int(value, 16)] = bits
	if len(codes) != 256:
		raise SystemExit(f"expected 256 generated music codes, found {len(codes)}")
	return codes


def resolve_marker(
	marker: str, symbols: dict[str, tuple[int, int]]
) -> tuple[int, int]:
	if not marker.startswith("~"):
		if marker in symbols:
			return symbols[marker]
		if marker.startswith("."):
			candidates = [
				location for name, location in symbols.items() if name.endswith(marker)
			]
			if len(candidates) == 1:
				return candidates[0]
		raise SystemExit(f"missing music marker symbol {marker!r}")
	root, unique = marker[1:].split(":", 1)
	root_bank = symbols[root][0]
	suffix = f".___music_restart_{unique}"
	candidates = [
		location
		for name, location in symbols.items()
		if location[0] == root_bank and name.endswith(suffix)
	]
	if len(candidates) != 1:
		raise SystemExit(
			f"restart marker {marker!r} resolved to {len(candidates)} symbols"
		)
	return candidates[0]


def read_blocks(path: Path) -> list[tuple[str, list[int]]]:
	blocks: list[tuple[str, list[int]]] = []
	marker: str | None = None
	values: list[int] = []
	for line in path.read_text(encoding="utf-8").splitlines():
		line = line.strip()
		if line.startswith("!"):
			if marker is not None:
				blocks.append((marker, values))
			marker = line[1:]
			values = []
		elif re.fullmatch(r"\$[0-9a-f]{2}", line):
			if marker is None:
				raise SystemExit("music corpus byte appears before its first marker")
			values.append(int(line[1:], 16))
	if marker is not None:
		blocks.append((marker, values))
	return blocks


def decode_value(
	rom: bytes,
	tree_offset: int,
	leaves_offset: int,
	data: bytes,
	bit_position: int,
) -> tuple[int, int]:
	node = 0
	while True:
		if bit_position >= len(data) * 8:
			raise ValueError("compressed music block ended inside a Huffman code")
		byte = data[bit_position // 8]
		branch = (byte >> (7 - bit_position % 8)) & 1
		bit_position += 1
		node = rom[tree_offset + node * 2 + branch]
		if node < FIRST_LEAF:
			continue
		if node == ESCAPE_LEAF:
			if bit_position + 8 > len(data) * 8:
				raise ValueError("compressed music block ended inside a literal byte")
			value = 0
			for _ in range(8):
				byte = data[bit_position // 8]
				value = (value << 1) | ((byte >> (7 - bit_position % 8)) & 1)
				bit_position += 1
			return value, bit_position
		return rom[leaves_offset + node - FIRST_LEAF], bit_position


def main() -> None:
	parser = argparse.ArgumentParser()
	parser.add_argument("rom", type=Path)
	parser.add_argument("sym", type=Path)
	parser.add_argument("corpus", type=Path)
	parser.add_argument(
		"--codes", type=Path, default=Path("constants/music_huffman.asm")
	)
	args = parser.parse_args()

	rom = args.rom.read_bytes()
	symbols = read_symbols(args.sym)
	codes = read_codes(args.codes)
	blocks = read_blocks(args.corpus)
	tree_offset = rom_offset(*symbols[TREE_SYMBOL])
	leaves_offset = rom_offset(*symbols[LEAVES_SYMBOL])
	verified_bytes = 0
	verified_blocks = 0
	verified_pointers = 0
	symbol_locations = set(symbols.values())
	for marker, values in blocks:
		location = resolve_marker(marker, symbols)
		if marker.startswith("~"):
			pointer_offset = rom_offset(*location) - 2
			target = int.from_bytes(rom[pointer_offset : pointer_offset + 2], "little")
			if not 0x4000 <= target < 0x8000:
				raise SystemExit(
					f"raw pointer before {marker} targets non-ROM address ${target:04x}"
				)
			if (location[0], target) not in symbol_locations:
				raise SystemExit(
					f"raw pointer before {marker} has no target symbol at "
					f"{location[0]:02x}:{target:04x}"
				)
			verified_pointers += 1
		if not values:
			continue
		bits = "".join(codes[value] for value in values)
		padding = (-len(bits)) % 8
		bits += "0" * padding
		encoded = bytes(int(bits[index : index + 8], 2) for index in range(0, len(bits), 8))
		start = rom_offset(*location)
		actual = rom[start : start + len(encoded)]
		if actual != encoded:
			first_difference = next(
				index
				for index, (expected_byte, actual_byte) in enumerate(
					zip(encoded, actual)
				)
				if expected_byte != actual_byte
			)
			raise SystemExit(
				f"encoded block mismatch at {marker} ({location[0]:02x}:"
				f"{location[1]:04x}) byte {first_difference}: "
				f"expected {encoded.hex(' ')}, got {actual.hex(' ')}"
			)
		position = 0
		for index, expected in enumerate(values):
			value, position = decode_value(
				rom, tree_offset, leaves_offset, actual, position
			)
			if value != expected:
				raise SystemExit(
					f"decode mismatch at {marker} byte {index}: "
					f"expected ${expected:02x}, got ${value:02x}"
				)
		verified_bytes += len(values)
		verified_blocks += 1
	print(
		f"verified {verified_bytes:,} music bytes in "
		f"{verified_blocks:,} non-empty restart blocks and "
		f"{verified_pointers:,} raw control-flow pointers"
	)


if __name__ == "__main__":
	main()
