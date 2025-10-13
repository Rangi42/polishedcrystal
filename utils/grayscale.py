#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Usage: python grayscale.py image.png

Fix the input image to be 2-bit grayscale.
"""

import sys

import png

def rgb8_to_rgb5(c):
	r, g, b = c
	return (r // 8, g // 8, b // 8)

def invert(c):
	r, g, b = c
	return (31 - r, 31 - g, 31 - b)

def luminance(c):
	r, g, b = c
	return 0.299 * r**2 + 0.587 * g**2 + 0.114 * b**2

def rgb5_pixels(row):
	yield from (rgb8_to_rgb5(row[x:x+3]) for x in range(0, len(row), 4))

def grayscale(filename):
	with open(filename, 'rb') as file:
		width, height, rows = png.Reader(file).asRGBA8()[:3]
		rows = list(rows)
	b_and_w = {(0, 0, 0), (31, 31, 31)}
	colors = {c for row in rows for c in rgb5_pixels(row)} - b_and_w
	if not colors:
		colors = {(21, 21, 21), (10, 10, 10)}
	elif len(colors) == 1:
		c = colors.pop()
		colors = {c, invert(c)}
	elif len(colors) != 2:
		return False
	palette = tuple(sorted(colors | b_and_w, key=luminance, reverse=True))
	assert len(palette) == 4
	rows = [list(map(palette.index, rgb5_pixels(row))) for row in rows]
	rows = [[3 - c for c in row] for row in rows]
	writer = png.Writer(width, height, greyscale=True, bitdepth=2, compression=9)
	with open(filename, 'wb') as file:
		writer.write(file, rows)
	return True

def main():
	if len(sys.argv) < 2:
		print(f'Usage: {sys.argv[0]} pic.png', file=sys.stderr)
		sys.exit(1)
	for filename in sys.argv[1:]:
		if not filename.lower().endswith('.png'):
			print(f'{filename} is not a .png file!', file=sys.stderr)
		elif not grayscale(filename):
			print(f'{filename} has too many colors!', file=sys.stderr)

if __name__ == '__main__':
	main()
