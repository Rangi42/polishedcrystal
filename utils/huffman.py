#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate Huffman codes for compressible characters.

1. Run `make huffman > chars.txt`
2. Run `./utils/huffman.py chars.txt`
3. Update constants/charmap.asm based on the output
"""

import heapq
import sys
from collections import Counter

if len(sys.argv) != 2:
	print(f'Usage: {sys.argv[0]} chars.txt', file=sys.stderr)
	sys.exit(1)

with open(sys.argv[1], 'r', encoding='utf-8') as file:
	chars = [line.strip() for line in file if line.strip()]

order = []
with open('constants/charmap.asm', 'r', encoding='utf-8') as file:
	for line in file:
		line = line.strip()
		if line.startswith('ctxtmap '):
			char = line.removeprefix('ctxtmap ').split('", ', 1)[0] + '"'
			order.append(char)
chars.extend(order)
order.extend(set(chars) - set(order))

freqs = Counter(chars)

class Node:
	def __init__(self, freq, *args):
		self.freq = freq
		if len(args) == 1:
			(self.char,) = args
			self.left = self.right = None
		else:
			self.char = None
			(self.left, self.right) = args

	def __lt__(self, other):
		return self.freq < other.freq

	def generate_codes(self, prefix='', codes=None):
		if codes is None:
			codes = {}
		if self.char:
			codes[self.char] = prefix
		else:
			self.left.generate_codes(prefix + '0', codes)
			self.right.generate_codes(prefix + '1', codes)
		return codes

heap = [Node(freq, char) for char, freq in freqs.items()]
heapq.heapify(heap)

while len(heap) > 1:
	left = heapq.heappop(heap)
	right = heapq.heappop(heap)
	parent = Node(left.freq + right.freq, left, right)
	heapq.heappush(heap, parent)

codes = heap[0].generate_codes()

for char in order:
	print(f'{char}: {codes[char]}')
