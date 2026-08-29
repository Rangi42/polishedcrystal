#!/usr/bin/env python3
"""Verify generated contextual codes against the Huffman trees in a built ROM."""

from __future__ import annotations

import argparse
import ast
import re
from pathlib import Path

from huffman import TERMINATORS, context_after


TREE_SYMBOLS = {
	"b": "TextCompressionHuffmanTreeBoundary",
	"v": "TextCompressionHuffmanTreeVowel",
	"o": "TextCompressionHuffmanTreeOther",
}
FIRST_LEAF_NODE_ID = 0x7F
FIRST_SHIFTED_LEAF_NODE_ID = 0xEC
FIRST_SHIFTED_LEAF_CHAR_ID = 0x4D
CONTEXT_ESCAPE_NODE_ID = 0xFC


def read_charmap(path: Path) -> dict[str, int]:
	pattern = re.compile(
		r'^\s*charmap\s+("(?:[^"\\]|\\.)*")\s*,\s*\$([0-9a-fA-F]+)'
	)
	values: dict[str, int] = {}
	for line in path.read_text(encoding="utf-8").splitlines():
		match = pattern.match(line)
		if match:
			values[ast.literal_eval(match.group(1))] = int(match.group(2), 16)
	return values


def read_codes(path: Path) -> dict[str, dict[str, str]]:
	pattern = re.compile(
		r'^huff(?:map|esc)\s+([bvo]),\s+("(?:[^"\\]|\\.)*"),\s+([01]+)'
	)
	codes = {context: {} for context in TREE_SYMBOLS}
	for line in path.read_text(encoding="utf-8").splitlines():
		match = pattern.match(line)
		if match:
			context, quoted, bits = match.groups()
			codes[context][ast.literal_eval(quoted)] = bits
	return codes


def read_tree_addresses(path: Path) -> dict[str, int]:
	addresses: dict[str, int] = {}
	for line in path.read_text(encoding="utf-8").splitlines():
		parts = line.split(maxsplit=1)
		if len(parts) != 2 or parts[1] not in TREE_SYMBOLS.values():
			continue
		bank, address = parts[0].split(":")
		if bank != "00":
			raise SystemExit(f"Huffman tree {parts[1]} is not in ROM0")
		context = next(key for key, value in TREE_SYMBOLS.items() if value == parts[1])
		addresses[context] = int(address, 16)
	missing = TREE_SYMBOLS.keys() - addresses.keys()
	if missing:
		raise SystemExit(f"missing tree symbols: {sorted(missing)}")
	return addresses


def read_streams(path: Path) -> list[list[str]]:
	streams: list[list[str]] = []
	stream: list[str] = []
	for raw_line in path.read_text(encoding="utf-8").splitlines():
		line = raw_line.strip()
		if not (line.startswith('"') and line.endswith('"')):
			continue
		token = ast.literal_eval(line)
		stream.append(token)
		if token in TERMINATORS:
			streams.append(stream)
			stream = []
	if stream:
		streams.append(stream)
	return streams


def decode_symbol(rom: bytes, tree: int, bits: str, position: int) -> tuple[int, int]:
	node = 0
	while True:
		if position >= len(bits):
			raise ValueError("compressed stream ended inside a Huffman code")
		branch = int(bits[position])
		position += 1
		node = rom[tree + node * 2 + branch]
		if node < FIRST_LEAF_NODE_ID:
			continue
		if node == CONTEXT_ESCAPE_NODE_ID:
			if position + 8 > len(bits):
				raise ValueError("compressed stream ended inside an escaped byte")
			value = int(bits[position : position + 8], 2)
			return value, position + 8
		if node >= FIRST_SHIFTED_LEAF_NODE_ID:
			node -= FIRST_SHIFTED_LEAF_NODE_ID - FIRST_SHIFTED_LEAF_CHAR_ID
		return node, position


def main() -> None:
	parser = argparse.ArgumentParser()
	parser.add_argument("rom", type=Path)
	parser.add_argument("sym", type=Path)
	parser.add_argument("corpus", type=Path)
	parser.add_argument(
		"--charmap", type=Path, default=Path("constants/charmap.asm")
	)
	parser.add_argument(
		"--codes", type=Path, default=Path("constants/huffman_text.inc")
	)
	args = parser.parse_args()

	rom = args.rom.read_bytes()
	values = read_charmap(args.charmap)
	codes = read_codes(args.codes)
	trees = read_tree_addresses(args.sym)
	streams = read_streams(args.corpus)
	decoded_count = 0
	for stream_index, stream in enumerate(streams):
		previous: str | None = None
		bits = ""
		for token in stream:
			context = context_after(previous)
			bits += codes[context][token]
			previous = token
		position = 0
		previous = None
		for token_index, expected in enumerate(stream):
			context = context_after(previous)
			actual, position = decode_symbol(rom, trees[context], bits, position)
			if actual != values[expected]:
				raise SystemExit(
					f"stream {stream_index}, token {token_index}: "
					f"expected {expected!r} (${values[expected]:02x}), got ${actual:02x}"
				)
			previous = expected
			decoded_count += 1
	print(f"verified {decoded_count:,} tokens in {len(streams):,} streams")


if __name__ == "__main__":
	main()
