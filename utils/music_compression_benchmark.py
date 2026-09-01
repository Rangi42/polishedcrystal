#!/usr/bin/env python3
"""Estimate stream-safe compression ratios for assembled music sections."""

from __future__ import annotations

import argparse
import heapq
import re
import zlib
from collections import Counter
from dataclasses import dataclass
from pathlib import Path


SECTION_RE = re.compile(
	r'^\s*SECTION: \$([0-9a-f]+)(?:-\$([0-9a-f]+))? '
	r'\(\$([0-9a-f]+) bytes?\) \["([^"]+)"\]$',
	re.IGNORECASE,
)
BANK_RE = re.compile(r"^ROMX bank #(\d+):$")
SYMBOL_RE = re.compile(r"^([0-9a-f]+):([0-9a-f]+) (.+)$", re.IGNORECASE)
POINTER_RE = re.compile(
	r"^\s*(?:dba|compressed_music_pointer)\s+(Music_[A-Za-z0-9_]+)\s*$"
)


@dataclass(frozen=True)
class Section:
	bank: int
	start: int
	end: int
	name: str


@dataclass
class HuffNode:
	value: int | None = None
	left: "HuffNode | None" = None
	right: "HuffNode | None" = None


def parse_sections(map_path: Path) -> list[Section]:
	sections: list[Section] = []
	bank: int | None = None
	for line in map_path.read_text(encoding="utf-8").splitlines():
		bank_match = BANK_RE.match(line)
		if bank_match:
			bank = int(bank_match.group(1))
			continue
		section_match = SECTION_RE.match(line)
		if bank is None or not section_match:
			continue
		start_text, end_text, size_text, name = section_match.groups()
		if not name.startswith("Song -"):
			continue
		start = int(start_text, 16)
		size = int(size_text, 16)
		end = int(end_text, 16) + 1 if end_text else start + size
		assert end - start == size
		sections.append(Section(bank, start, end, name))
	return sections


def parse_symbols(sym_path: Path) -> dict[tuple[int, int], list[str]]:
	symbols: dict[tuple[int, int], list[str]] = {}
	for line in sym_path.read_text(encoding="utf-8").splitlines():
		match = SYMBOL_RE.match(line)
		if not match:
			continue
		bank_text, address_text, name = match.groups()
		key = int(bank_text, 16), int(address_text, 16)
		symbols.setdefault(key, []).append(name)
	return symbols


def parse_roots(pointer_path: Path) -> set[str]:
	return {
		match.group(1)
		for line in pointer_path.read_text(encoding="utf-8").splitlines()
		if (match := POINTER_RE.match(line))
	}


def rom_offset(bank: int, address: int) -> int:
	return bank * 0x4000 + address - 0x4000


def get_blocks(
	rom: bytes,
	sections: list[Section],
	symbols: dict[tuple[int, int], list[str]],
	roots: set[str],
) -> tuple[list[bytes], list[bytes]]:
	raw_blocks: list[bytes] = []
	stream_blocks: list[bytes] = []
	for section in sections:
		points = {section.start, section.end}
		for bank, address in symbols:
			if bank == section.bank and section.start <= address < section.end:
				points.add(address)
		ordered = sorted(points)
		for start, end in zip(ordered, ordered[1:]):
			begin = rom_offset(section.bank, start)
			data = rom[begin : begin + end - start]
			labels = symbols.get((section.bank, start), [])
			if roots.intersection(labels):
				raw_blocks.append(data)
			else:
				stream_blocks.append(data)
	return raw_blocks, stream_blocks


def add_printer_blocks(
	rom: bytes,
	symbols: dict[tuple[int, int], list[str]],
	raw_blocks: list[bytes],
	stream_blocks: list[bytes],
) -> None:
	root = next(key for key, names in symbols.items() if "Music_Printer" in names)
	bank, start = root
	points = sorted(
		address
		for (symbol_bank, address), names in symbols.items()
		if symbol_bank == bank
		and address >= start
		and any(name.startswith("Music_Printer") for name in names)
	)
	# Music_Printer is the last item in its linker section. The next symbol is
	# the first item in the following section.
	end = min(
		address
		for symbol_bank, address in symbols
		if symbol_bank == bank and address > points[-1]
	)
	points.append(end)
	for index, (block_start, block_end) in enumerate(zip(points, points[1:])):
		begin = rom_offset(bank, block_start)
		data = rom[begin : begin + block_end - block_start]
		(raw_blocks if index == 0 else stream_blocks).append(data)


def huffman_lengths(data: bytes) -> dict[int, int]:
	frequencies = Counter(data)
	heap: list[tuple[int, int, HuffNode]] = []
	for serial, value in enumerate(sorted(frequencies)):
		heap.append((frequencies[value], serial, HuffNode(value=value)))
	heapq.heapify(heap)
	serial = len(heap)
	while len(heap) > 1:
		left_frequency, _, left = heapq.heappop(heap)
		right_frequency, _, right = heapq.heappop(heap)
		heapq.heappush(
			heap,
			(left_frequency + right_frequency, serial, HuffNode(left=left, right=right)),
		)
		serial += 1
	lengths: dict[int, int] = {}
	stack = [(heap[0][2], 0)]
	while stack:
		node, depth = stack.pop()
		if node.value is not None:
			lengths[node.value] = max(depth, 1)
			continue
		assert node.left is not None and node.right is not None
		stack.append((node.left, depth + 1))
		stack.append((node.right, depth + 1))
	return lengths


def encoded_huffman_size(blocks: list[bytes], lengths: dict[int, int]) -> int:
	return sum((sum(lengths[value] for value in block) + 7) // 8 for block in blocks)


def capped_huffman_size(
	blocks: list[bytes], frequencies: Counter[int], leaf_count: int
) -> tuple[int, int, int]:
	direct_count = leaf_count - 1
	direct = {
		value
		for value, _ in sorted(
			frequencies.items(), key=lambda item: (-item[1], item[0])
		)[:direct_count]
	}
	escape = 256
	capped_data: list[int] = []
	for value in direct:
		capped_data.extend([value] * frequencies[value])
	capped_data.extend([escape] * sum(
		frequency for value, frequency in frequencies.items() if value not in direct
	))
	lengths = huffman_lengths(capped_data)
	stream_size = 0
	for block in blocks:
		bits = sum(
			lengths[value] if value in direct else lengths[escape] + 8
			for value in block
		)
		stream_size += (bits + 7) // 8
	table_size = 2 * (leaf_count - 1) + direct_count
	max_code = max(
		max(lengths[value] for value in direct), lengths[escape] + 8
	)
	return stream_size, table_size, max_code


def packbits_size(block: bytes) -> int:
	result = 0
	position = 0
	while position < len(block):
		run = 1
		while (
			position + run < len(block)
			and block[position + run] == block[position]
			and run < 128
		):
			run += 1
		if run >= 3:
			result += 2
			position += run
			continue
		literal_start = position
		position += run
		while position < len(block) and position - literal_start < 128:
			next_run = 1
			while (
				position + next_run < len(block)
				and block[position + next_run] == block[position]
				and next_run < 3
			):
				next_run += 1
			if next_run >= 3:
				break
			position += next_run
		result += 1 + position - literal_start
	return result


def main() -> None:
	parser = argparse.ArgumentParser()
	parser.add_argument("rom", type=Path)
	parser.add_argument("map", type=Path)
	parser.add_argument("sym", type=Path)
	parser.add_argument(
		"--pointers", type=Path, default=Path("audio/music_pointers.asm")
	)
	parser.add_argument("--corpus", type=Path)
	args = parser.parse_args()

	rom = args.rom.read_bytes()
	sections = parse_sections(args.map)
	symbols = parse_symbols(args.sym)
	roots = parse_roots(args.pointers)
	raw_blocks, stream_blocks = get_blocks(rom, sections, symbols, roots)
	add_printer_blocks(rom, symbols, raw_blocks, stream_blocks)
	raw_size = sum(map(len, raw_blocks))
	stream_size = sum(map(len, stream_blocks))
	all_size = raw_size + stream_size
	stream = b"".join(stream_blocks)
	if args.corpus:
		args.corpus.write_text(
			"".join(f"${value:02x}\n" for value in stream), encoding="utf-8"
		)
	lengths = huffman_lengths(stream)
	huffman_stream_size = encoded_huffman_size(stream_blocks, lengths)
	tree_size = 2 * (len(lengths) - 1)
	packbits_stream_size = sum(packbits_size(block) for block in stream_blocks)
	zlib_stream_size = len(zlib.compress(stream, level=9))

	print(f"song sections:        {len(sections) + 1:,}")
	print(f"restart blocks:       {len(stream_blocks):,}")
	print(f"raw headers:          {raw_size:,} bytes")
	print(f"channel streams:      {stream_size:,} bytes")
	print(f"total music:          {all_size:,} bytes")
	print()
	print("candidate                 stream bytes   data saving   incl. table")
	print("------------------------  ------------   -----------   -----------")
	print(
		f"byte Huffman, aligned     {huffman_stream_size:12,}   "
		f"{stream_size - huffman_stream_size:11,}   "
		f"{'n/a':>11}"
	)
	for leaf_count in (32, 64, 96, 128):
		capped_size, capped_table, capped_max = capped_huffman_size(
			stream_blocks, Counter(stream), leaf_count
		)
		print(
			f"Huffman + escape ({leaf_count:3})  {capped_size:12,}   "
			f"{stream_size - capped_size:11,}   "
			f"{stream_size - capped_size - capped_table:11,}"
		)
	print(
		f"PackBits RLE              {packbits_stream_size:12,}   "
		f"{stream_size - packbits_stream_size:11,}   "
		f"{stream_size - packbits_stream_size:11,}"
	)
	print(
		f"zlib ceiling (unaligned)  {zlib_stream_size:12,}   "
		f"{stream_size - zlib_stream_size:11,}   "
		f"{stream_size - zlib_stream_size:11,}"
	)
	print()
	print(
		f"Full Huffman symbols/branches: {len(lengths)} / {tree_size:,} bytes; "
		"a GBC-safe node encoding needs additional leaf/tag storage"
	)
	print(f"Huffman max code:     {max(lengths.values())} bits")
	for leaf_count in (32, 64, 96, 128):
		_, table_size, max_code = capped_huffman_size(
			stream_blocks, Counter(stream), leaf_count
		)
		print(
			f"Capped {leaf_count:3} table/max:  {table_size:,} bytes / {max_code} bits"
		)


if __name__ == "__main__":
	main()
