#!/usr/bin/env python3
"""Check linked text against its charmap bytes and minimum encoded size."""

import argparse
from collections import Counter
from pathlib import Path

from huffman import SPACE, optimal_parse, records, token_lengths

COMPRESSED = 0x5d
TERMINALS = (0x52, 0x53, 0x54)


def symbols(path):
	result = {}
	for line in path.read_text().splitlines():
		parts = line.split()
		if len(parts) == 2 and ":" in parts[0]:
			bank, address = (int(x, 16) for x in parts[0].split(":"))
			result[parts[1]] = (bank, address)
	return result


def offset(bank, address):
	return address if bank == 0 else (bank - 1) * 0x4000 + address


def read_pair_model(rom, syms):
	dictionary = offset(*syms["HuffmanPairs"])
	classes = offset(*syms["HuffmanContexts"])
	bank, directory = syms["HuffmanTrees"]
	pairs = list(zip(rom[dictionary:classes:2], rom[dictionary + 1:classes:2]))
	contexts = [b // 2 for b in rom[classes:classes + 256]]
	trees = []
	for context in range(max(contexts) + 1):
		entry = offset(bank, directory) + 2 * context
		group = offset(bank, int.from_bytes(rom[entry:entry + 2], "little"))
		# The symbols immediately follow the last two-byte length group.
		first_symbol = group + 1 + rom[group + 1] - rom[group]
		tree = []
		while group < first_symbol:
			count = rom[group]
			end = group + 1 + rom[group + 1]
			tree.append(rom[end - count:end])
			group += 2
		trees.append(tree)
	return pairs, contexts, trees


def decode_pair(pairs, contexts, trees, bits):
	out = bytearray()
	pos = 0
	last = SPACE
	while last not in TERMINALS:
		code = 0
		for group in trees[contexts[last]]:
			code = 2 * code + int(bits[pos])
			pos += 1
			if code < len(group):
				token = group[code]
				break
			code -= len(group)
		else:
			raise ValueError("invalid canonical code")
		if token == 0xff:
			if pos + 8 > len(bits):
				raise ValueError("truncated escape")
			token = int(bits[pos:pos + 8], 2)
			pos += 8
		if token < SPACE:
			out.extend(pairs[token])
		else:
			out.append(token - (0xec - 0x4d) if token >= 0xec else token)
		last = out[-1]
	return out, pos


def verify(rom_path, sym_path, corpus):
	rom = rom_path.read_bytes()
	syms = symbols(sym_path)
	pairs, contexts, trees = read_pair_model(rom, syms)
	pair_ids = {pair: i for i, pair in enumerate(pairs)}
	lengths = [token_lengths(tree) for tree in trees]
	remaining = {name for name in syms if ".pair_text_" in name and name.endswith("_start")}
	counts = Counter()
	raw_size = encoded_size = 0
	for name, implicit, raw in records(corpus):
		remaining.remove(name + "_start")
		bank, start = syms[name + "_start"]
		end_bank, end = syms[name + "_end"]
		base = 0x4000 if bank else 0
		if bank != end_bank or not base <= start <= end <= base + 0x4000:
			raise ValueError(f"{name} crosses a ROM bank")
		data = rom[offset(bank, start):offset(bank, end)]
		size = len(raw) - implicit
		raw_size += size
		encoded_size += len(data)
		cost, _ = optimal_parse(raw, pair_ids, contexts, lengths)
		if 1 + (cost + 7) // 8 < size:
			if data[:1] != bytes([COMPRESSED]):
				raise ValueError(f"{name} missing compression marker")
			bits = "".join(f"{b:08b}" for b in data[1:])
			out, pos = decode_pair(pairs, contexts, trees, bits)
			if out != raw or pos != cost or bits[pos:] != "0" * (-pos % 8):
				raise ValueError(f"{name} has incorrect compressed data or length")
			counts["paired"] += 1
		else:
			if data != raw[:size]:
				raise ValueError(f"{name} has incorrect raw data")
			counts["raw"] += 1
	if not counts or remaining:
		raise ValueError("corpus and linked record labels disagree")
	print(f"Verified {sum(counts.values()):,} segments "
	      f"({counts['paired']:,} paired, {counts['raw']:,} raw)")
	print(f"Payload {raw_size:,} -> {encoded_size:,} bytes")


if __name__ == "__main__":
	parser = argparse.ArgumentParser(description=__doc__)
	for arg in ("rom", "sym", "corpus"):
		parser.add_argument(arg, type=Path)
	args = parser.parse_args()
	verify(args.rom, args.sym, args.corpus)
