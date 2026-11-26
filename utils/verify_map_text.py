#!/usr/bin/env python3
"""Check actual linked map dialogue, including command boundaries and fallback sizes."""

import argparse
from collections import Counter
from pathlib import Path

from huffman import BOUNDARY_TOKENS, VOWELS
from pair_text import optimal_parse, records, token_lengths
from verify_huffman import decode_symbol, read_charmap, read_codes, read_tree_addresses

PAIR, LEGACY = 0x4c, 0x5d
SPACE = 0x7f
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
	dictionary = offset(*syms["MapPairDictionary"])
	classes = offset(*syms["MapPairContexts"])
	bank, directory = syms["MapPairTrees"]
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
	values = read_charmap(Path("constants/charmap.asm"))
	boundaries = {values[t] for t in BOUNDARY_TOKENS}
	vowels = {values[t] for t in VOWELS}

	def context(last):
		return "b" if last in boundaries else "v" if last in vowels else "o"

	codes = {ctx: {values[t]: bits for t, bits in code.items()}
	         for ctx, code in read_codes(Path("constants/huffman_text.inc")).items()}
	trees = read_tree_addresses(sym_path)
	rom = rom_path.read_bytes()
	syms = symbols(sym_path)
	labels = {name.rsplit(".", 1)[-1]: loc for name, loc in syms.items() if ".pair_text_" in name}
	if "MapPairTrees" in syms:
		pairs, contexts, pair_trees = read_pair_model(rom, syms)
		pair_ids = {pair: i for i, pair in enumerate(pairs)}
		lengths = [token_lengths(tree) for tree in pair_trees]
	counts = Counter()
	old_size = new_size = 0
	for number, implicit, raw in records(corpus):
		bank, start = labels[f"pair_text_start{number}"]
		end_bank, end = labels[f"pair_text_end{number}"]
		if bank != end_bank or not 0x4000 <= start < end <= 0x8000:
			raise ValueError(f"record {number} crosses a ROM bank")
		data = rom[offset(bank, start):offset(bank, end)]
		last = SPACE
		length = 0
		for token in raw:
			length += len(codes[context(last)][token])
			last = token
		old = min(len(raw) - implicit, 1 + (length + 7) // 8)
		old_size += old
		new_size += len(data)
		expected_size = old
		expected_mode = "legacy" if old < len(raw) - implicit else "raw"
		if expected_mode == "legacy" and "MapPairTrees" in syms:
			optimal_bits, _ = optimal_parse(raw, pair_ids, contexts, lengths)
			pair_size = 1 + (optimal_bits + 7) // 8
			if pair_size < old:
				expected_mode, expected_size = "pair", pair_size
		if data[0] in (PAIR, LEGACY):
			bits = "".join(f"{b:08b}" for b in data[1:])
			if data[0] == PAIR:
				out, pos = decode_pair(pairs, contexts, pair_trees, bits)
				mode = "pair"
			else:
				out = bytearray()
				pos = 0
				last = SPACE
				while last not in TERMINALS:
					last, pos = decode_symbol(rom, trees[context(last)], bits, pos)
					out.append(last)
				mode = "legacy"
			ok = out == raw and bits[pos:] == "0" * (-pos % 8)
		else:
			mode = "raw"
			ok = data == (raw[:-1] if implicit else raw)
		if mode != expected_mode or len(data) != expected_size or not ok:
			raise ValueError(f"record {number} ({bank:02x}:{start:04x}, {mode}) failed verification")
		if mode == "pair" and pos != optimal_bits:
			raise ValueError(f"record {number} used {pos} bits, minimum is {optimal_bits}")
		counts[mode] += 1
	if not counts or len(labels) != 2 * sum(counts.values()):
		raise ValueError("corpus and linked record labels disagree")
	print(f"Verified {sum(counts.values()):,} segments "
	      f"({counts['pair']:,} paired, {counts['legacy']:,} legacy, {counts['raw']:,} raw)")
	print(f"Payload {old_size:,} -> {new_size:,} bytes ({old_size - new_size:,} saved)")


if __name__ == "__main__":
	parser = argparse.ArgumentParser(description=__doc__)
	for arg in ("rom", "sym", "corpus"):
		parser.add_argument(arg, type=Path)
	args = parser.parse_args()
	verify(args.rom, args.sym, args.corpus)
