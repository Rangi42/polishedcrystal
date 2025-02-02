#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Usage: python gbc_colors.py image.png...

Adjust the input images' colors to resemble a true GBC display.
"""

import sys

import png

def rgb8_to_rgb5(c):
	r, g, b = c
	return (r // 8, g // 8, b // 8)

def rgb5_pixels(row):
	yield from (rgb8_to_rgb5(row[x:x+3]) for x in range(0, len(row), 4))

def gbc_color(c):
	# Formula based on SameBoy's "Modern - Reduce Contrast" option
	r, g, b = c
	# Apply color curve...
	curve = [
		  0,   6,  12,  20,  28,  36,  45,  56,  66,  76,  88, 100, 113, 125, 137, 149,
		161, 172, 182, 192, 202, 210, 218, 225, 232, 238, 243, 247, 250, 252, 254, 255,
	]
	r, g, b = curve[r], curve[g], curve[b]
	g = int((((g / 255)**2.2 * 3 + (b / 255)**2.2) / 4)**(1 / 2.2) * 255)
	# ...and reduce contrast
	new_r = (r * 15 // 16 + (g + b) // 32) * (220 - 40) // 255 + 40
	new_g = (g * 15 // 16 + (r + b) // 32) * (224 - 36) // 255 + 36
	new_b = (b * 15 // 16 + (r + g) // 32) * (216 - 32) // 255 + 32
	return (new_r, new_g, new_b)

def gbc_colors(filename):
	with open(filename, 'rb') as file:
		width, height, rows = png.Reader(file).asRGBA8()[:3]
		rows = list(rows)
	rows = [sum([list(gbc_color(c)) for c in rgb5_pixels(row)], []) for row in rows]
	writer = png.Writer(width, height, greyscale=False, bitdepth=8, compression=9)
	with open(filename, 'wb') as file:
		writer.write(file, rows)

def main():
	if len(sys.argv) < 2:
		print(f'Usage: {sys.argv[0]} image.png...', file=sys.stderr)
		sys.exit(1)
	for filename in sys.argv[1:]:
		if not filename.lower().endswith('.png'):
			print(f'{filename} is not a .png file!', file=sys.stderr)
		gbc_colors(filename)
		print(f'{filename} was GBC-colored')

if __name__ == '__main__':
	main()
