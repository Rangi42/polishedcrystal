#!/usr/bin/env python3
"""Train the text codec from make huffman output."""

import argparse
import ast
import heapq
import re
from collections import Counter
from pathlib import Path


SPACE = 0x7f
BOUNDARIES = {SPACE, *range(0x55, 0x5a)}
VOWELS = {0x80, 0x84, 0x88, 0x8e, 0x94, 0xa0, 0xa4, 0xa8, 0xae, 0xb4}
ESCAPE = 0xff


def read_charmap(charmap_path):
	pattern = re.compile(
		r'^\s*charmap\s+("(?:[^"\\]|\\.)*")\s*,\s*\$([0-9a-fA-F]+)'
	)
	values: dict[str, int] = {}
	for line in charmap_path.read_text(encoding="utf-8").splitlines():
		match = pattern.match(line)
		if match:
			token = ast.literal_eval(match.group(1))
			value = int(match.group(2), 16)
			if not (0x4D <= value <= 0x5C or 0x7F <= value <= 0xEB):
				continue
			values[token] = value
	return values


def records(path):
	for line in path.read_text().splitlines():
		if line.startswith("PAIR "):
			_, label, implicit, data = line.split()
			yield label, bool(int(implicit)), bytes.fromhex(data)


def ranked(counts):
	return sorted(counts, key=lambda token: (-counts[token], token))


def pairable(byte):
	return byte == SPACE or 0x80 <= byte <= 0x99 or 0xa0 <= byte <= 0xb9


def literal(byte):
	if 0x4d <= byte <= 0x5c:
		return byte + 0xec - 0x4d
	if SPACE <= byte <= 0xeb:
		return byte
	raise ValueError(f"unencodable byte ${byte:02x}")


def token_lengths(groups):
	"""Bit cost of every token, including the payload of an escape."""
	direct = {t: n for n, group in enumerate(groups, 1) for t in group}
	escaped = direct[ESCAPE] + 8
	return [min(direct.get(t, escaped), escaped) for t in range(256)]


def optimal_parse(data, pairs, contexts, lengths):
	"""Return the shortest bit length and the first token of each optimal suffix."""
	cost = [0] * (len(data) + 1)
	choice = bytearray(len(data))
	for i in range(len(data) - 1, -1, -1):
		context = contexts[data[i - 1] if i else SPACE]
		bits = lengths[context]
		token = literal(data[i])
		best = bits[token] + cost[i + 1]
		if i + 1 < len(data):
			pair = pairs.get((data[i], data[i + 1]))
			if pair is not None and bits[pair] + cost[i + 2] <= best:
				token = pair
				best = bits[pair] + cost[i + 2]
		cost[i] = best
		choice[i] = token
	return cost[0], choice


def canonical_groups(frequencies):
	# Rare tokens share an escape. Bound the direct alphabet so all symbols
	# and group displacements fit in the reader's eight-bit arithmetic.
	selected = [t for t in ranked(frequencies) if frequencies[t] >= 8][:160]
	weights = {token: frequencies[token] for token in selected}
	weights[ESCAPE] = 1 + sum(frequencies.values()) - sum(weights.values())
	# Also give an unseen fallback context a complete binary tree.
	if len(weights) == 1:
		weights[SPACE] = 1
	heap = [(weight, token, [token]) for token, weight in weights.items()]
	heapq.heapify(heap)
	lengths = Counter()
	serial = 256
	while len(heap) > 1:
		a, _, left = heapq.heappop(heap)
		b, _, right = heapq.heappop(heap)
		leaves = left + right
		lengths.update(leaves)
		heapq.heappush(heap, (a + b, serial, leaves))
		serial += 1
	# RGBDS accumulates at most 7 pending bits, a code, and 8 escaped bits.
	if max(lengths.values()) > 17:
		raise ValueError("Huffman code exceeds the encoder's bit accumulator")
	return [sorted(t for t in lengths if lengths[t] == n)
	        for n in range(1, max(lengths.values()) + 1)]


def parse_corpus(streams, pairs, contexts, lengths):
	counts = [Counter() for _ in lengths]
	payload = 0
	for data in streams:
		bits, choice = optimal_parse(data, pairs, contexts, lengths)
		payload += (bits + 7) // 8
		i = 0
		while i < len(data):
			token = choice[i]
			context = contexts[data[i - 1] if i else SPACE]
			counts[context][token] += 1
			i += 2 if token < SPACE else 1
	return counts, payload


def train(streams):
	previous = Counter()
	adjacent = Counter()
	for data in streams:
		previous.update(b for b in data[:-1] if b not in BOUNDARIES)
		adjacent.update((a, b) for a, b in zip(data, data[1:]) if pairable(a) and pairable(b))
	# IDs below the literal space byte are available for exactly 127 flat pairs.
	pairs = {pair: i for i, pair in enumerate(ranked(adjacent)[:SPACE])}
	contexts = [0 if b in BOUNDARIES else 1 if b in VOWELS else 2 for b in range(256)]
	frequent = ranked(previous)[:32]
	for i, b in enumerate(frequent, 3):
		contexts[b] = i
	# Equal token costs seed the first histogram. Refit the code lengths to
	# the paths actually chosen under the preceding model. Retain the best
	# measured tables, charging both padded payloads and ROM table bytes.
	counts, _ = parse_corpus(streams, pairs, contexts, [[1] * 256] * (3 + len(frequent)))
	best_size = None
	for _ in range(10):
		trees = [canonical_groups(count) for count in counts]
		lengths = [token_lengths(tree) for tree in trees]
		new_counts, payload = parse_corpus(streams, pairs, contexts, lengths)
		size = payload + sum(2 + len(group) for tree in trees for group in tree)
		if best_size is None or size < best_size:
			best_trees, best_size = trees, size
		if new_counts == counts:
			break
		counts = new_counts
	return pairs, contexts, best_trees


def render(pairs, contexts, trees):
	charmap = read_charmap(Path(__file__).resolve().parents[1] / "constants/charmap.asm")
	symbols = {}
	for char, byte in charmap.items():
		quoted = "'" + char.replace("'", "\\'") + "'"
		symbols[literal(byte)] = quoted if byte >= SPACE else quoted + " + HUFFMAN_TOKEN_SHIFT"

	lines = [
		"; Generated by utils/huffman.py from the full text corpus.",
		"",
		"; Define x_pair_rule, x_pair_contexts, and x_pair_codes before invoking these",
		"; X macros. The encoder builds lookups and the decoder emits ROM tables.",
		"; https://en.wikipedia.org/wiki/X_macro",
		"MACRO huffman_pair_rules",
	]
	lines.extend(f"\tx_pair_rule {symbols[left]}, {symbols[right]}" for left, right in pairs)
	lines += ["ENDM", "", "MACRO huffman_pair_contexts"]
	for i in range(0, len(contexts), 16):
		lines.append("\tx_pair_contexts " + ", ".join(str(c) for c in contexts[i:i + 16]))
	lines += ["ENDM", "", f"DEF NUM_HUFFMAN_TREES EQU {len(trees)}"]
	for index, groups in enumerate(trees):
		lines.append(f"MACRO huffman_tree_{index}")
		for group in groups:
			tokens = ", ".join(symbols.get(t, f"${t:02x}") for t in group)
			lines.append(("\tx_pair_codes " + tokens).rstrip())
		lines.append("ENDM")
	return "\n".join(lines + [""])


def main():
	parser = argparse.ArgumentParser(description=__doc__)
	parser.add_argument("corpus", type=Path)
	parser.add_argument("output", type=Path)
	args = parser.parse_args()
	streams = [data for _, _, data in records(args.corpus)]
	if not streams:
		parser.error("no PAIR records in corpus")
	args.output.write_text(render(*train(streams)))


if __name__ == "__main__":
	main()
