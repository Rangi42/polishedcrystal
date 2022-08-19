#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import png

def rgb8_to_rgb5(c):
	r, g, b = c
	return (r // 8, g // 8, b // 8)

def rgb5_to_rgb8(c):
	r, g, b = c
	return (r * 8 + r // 4, g * 8 + g // 4, b * 8 + b // 4)

def invert(c):
	r, g, b = c
	return (31 - r, 31 - g, 31 - b)

def luminance(c):
	r, g, b = c
	return 0.299 * r**2 + 0.587 * g**2 + 0.114 * b**2

def rgb5_pixels(row):
	for x in range(0, len(row), 4):
		yield rgb8_to_rgb5(row[x:x+3])

def fix_pal(filename):
	with open(filename, 'rb') as file:
		width, height, data = png.Reader(file).asRGBA8()[:3]
		data = list(data)
	b_and_w = {(0, 0, 0), (31, 31, 31)}
	colors = set(c for row in data for c in rgb5_pixels(row)) - b_and_w
	if not colors:
		colors = {(21, 21, 21), (10, 10, 10)}
	elif len(colors) == 1:
		c = colors.pop()
		colors = {c, invert(c)}
	elif len(colors) != 2:
		return False
	palette = tuple(sorted(colors | b_and_w, key=luminance, reverse=True))
	assert len(palette) == 4
	data = [list(map(palette.index, rgb5_pixels(row))) for row in data]
	if palette == ((31, 31, 31), (21, 21, 21), (10, 10, 10), (0, 0, 0)):
		data = [[3 - c for c in row] for row in data]
		writer = png.Writer(width, height, greyscale=True, bitdepth=2, compression=9)
	else:
		palette = tuple(map(rgb5_to_rgb8, palette))
		writer = png.Writer(width, height, palette=palette, bitdepth=8, compression=9)
	with open(filename, 'wb') as file:
		writer.write(file, data)
	return True

def main():
	if len(sys.argv) < 2:
		print('Usage:', sys.argv[0], 'pic.png', file=sys.stderr)
		sys.exit(1)
	for filename in sys.argv[1:]:
		if not filename.lower().endswith('.png'):
			print(filename, 'is not a .png file!', file=sys.stderr)
		elif not fix_pal(filename):
			print(filename, 'has too many colors!', file=sys.stderr)

if __name__ == '__main__':
	main()
