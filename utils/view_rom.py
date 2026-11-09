#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
View a Game Boy ROM as a PNG image.

Usage: view_rom.py -o|--out <out.png> [-r|--rom <in.gbc>] [-m|--map <in.map>]
                   [-c|--color <colormap>] [-e|--entropy [<win_len>]]
                   [-s|--sort <order>] [-b|--banked]
                   [-v|--vertical] [-n|--narrow]
"""

import argparse
import math
import re

from collections.abc import Callable
from functools import cache
from typing import TypeAlias

import png

BANK_SIZE = 0x4000

DEFAULT_ENTROPY_WIN_LEN = 256

DEFAULT_BANK_WIDTH = 1024
NARROW_BANK_WIDTH = 512
assert BANK_SIZE % DEFAULT_BANK_WIDTH == 0
assert BANK_SIZE % NARROW_BANK_WIDTH == 0


############################## Top-level functions #############################

def main() -> None:
	"""
	Parse the command line arguments, read the input file(s), and write the output PNG.
	"""
	args = parse_args()
	contents = read_rom(args.rom) if args.rom else None
	used_space = read_map(args.map) if args.map else None
	used_space = pad_space(used_space, contents)
	colors = calculate_colors(args.color, args.entropy, used_space, contents)
	pixels = sort_pixels(colors, args.sort, args.banked, args.vertical, args.narrow)
	write_png(args.out, pixels)

def parse_args() -> argparse.Namespace:
	"""
	Parse the command line arguments.
	"""
	# Set up the argument parser
	parser = argparse.ArgumentParser(
		description="View a Game Boy ROM as a PNG image."
	)
	parser.add_argument(
		"-o", "--out", metavar="out.png",
		required=True,
		help="the output .png file"
	)
	parser.add_argument(
		"-r", "--rom", metavar="in.gbc",
		help="the input .gbc ROM file"
	)
	parser.add_argument(
		"-m", "--map", metavar="in.map",
		help="the input .map file"
	)
	parser.add_argument(
		"-c", "--color",
		choices=list(colormaps.keys()),
		default=list(colormaps.keys())[0],
		help="the color scheme"
	)
	parser.add_argument(
		"-e", "--entropy",
		metavar="win_len",
		nargs="?",
		type=int,
		const=DEFAULT_ENTROPY_WIN_LEN,
		default=None,
		help="color pixels by Shannon entropy instead of byte value"
	)
	parser.add_argument(
		"-s", "--sort",
		choices=list(sorters.keys()),
		default=list(sorters.keys())[0],
		help="how to order the pixels in the image"
	)
	parser.add_argument(
		"-b", "--banked",
		action="store_true",
		help="order the pixels independently within each ROM bank"
	)
	parser.add_argument(
		"-v", "--vertical",
		action="store_true",
		help="stack banks downwards instead of rightwards"
	)
	parser.add_argument(
		"-n", "--narrow",
		action="store_true",
		help=f"render banks as {NARROW_BANK_WIDTH}x{BANK_SIZE // NARROW_BANK_WIDTH} " +
			f"instead of {DEFAULT_BANK_WIDTH}x{BANK_SIZE // DEFAULT_BANK_WIDTH}"
	)
	# Parse, check, and return the arguments
	args = parser.parse_args()
	if args.rom is None:
		if args.map is None:
			parser.error("at least one input file is required: -r/--rom or -m/--map")
		elif args.entropy is not None:
			parser.error("a -r/--rom input file is required with -e/--entropy")
	if args.entropy is not None and args.entropy < 1:
		parser.error(f"argument -e/--entropy: invalid value: {args.entropy}")
	if args.sort in ["hilbert", "zcurve"] and not args.banked:
		parser.error(f"-s/--sort {args.sort} requires -b/--banked ordering")
	return args

def read_rom(filename: str) -> bytes:
	"""
	Read the input .gbc ROM file and return its byte contents.
	"""
	with open(filename, "rb") as file:
		return file.read()

def read_map(filename: str) -> list[bool]:
	"""
	Read the input .map file and return whether each byte in the ROM has been used.
	"""
	# Gather a list of (start, end) offsets covering all used ROM space
	used_spans = []
	with open(filename, "r", encoding="utf-8") as file:
		bank_rx = re.compile(r"(\w+) bank #(\d+)", re.IGNORECASE)
		section_rx = re.compile(r"[ \t]+SECTION: \$([0-9a-f]{4})-\$([0-9a-f]{4})\b", re.IGNORECASE)
		cur_bank = None
		for line in file:
			if (m := re.match(bank_rx, line)):
				cur_bank = int(m.group(2)) if re.match(r"ROM[0X]?", m.group(1)) else None
			elif (m := re.match(section_rx, line)) and cur_bank is not None:
				start_addr = int(m.group(1), 16)
				end_addr = int(m.group(2), 16)
				if cur_bank > 0:
					start_offset = cur_bank * BANK_SIZE + (start_addr & (BANK_SIZE - 1))
				else:
					start_offset = start_addr
				end_offset = start_offset + end_addr - start_addr + 1
				used_spans.append((start_offset, end_offset))
	# Round the number of used banks up to the nearest power of 2, like rgbfix does
	max_offset = max(span[1] for span in used_spans)
	num_banks = (max_offset + BANK_SIZE - 1) // BANK_SIZE
	num_banks = 1 << (num_banks - 1).bit_length()
	# Return a list of Booleans for whether each byte in the ROM has been used
	used_space = [False] * (num_banks * BANK_SIZE)
	for (start, end) in used_spans:
		used_space[start:end] = [True] * (end - start)
	return used_space

def pad_space(
	used_space: list[bool] | None,
	contents: bytes | None
) -> list[bool]:
	"""
	Pad the list of used space to match the length of the ROM contents.
	"""
	if contents is not None:
		if used_space is None:
			used_space = [True] * len(contents)
		elif len(contents) > len(used_space):
			used_space.extend([False] * (len(contents) - len(used_space)))
	# We previously exited if both `used_space` and `contents` were None, so here if
	# `used_space` was None, `contents` was not, and `used_space` has been initialized
	assert used_space is not None
	return used_space

Color: TypeAlias = tuple[int, int, int]

def calculate_colors(
	colormap_name: str,
	entropy_win_len: int | None,
	used_space: list[bool],
	contents: bytes | None
) -> list[Color]:
	"""
	Calculate the RGB color for each byte of the ROM.
	"""
	colormapper, free_color = colormaps[colormap_name]
	# If there are no ROM contents, just color pixels binarily as free or used
	if contents is None:
		return [colormapper(float(flag)) for flag in used_space]
	# Derive values from the ROM contents for each pixel to be mapped to colors
	if entropy_win_len is not None:
		values = calculate_entropy(contents, entropy_win_len)
	else:
		values = [byte / 255 for byte in contents]
	# Return a list of colors for every byte in the ROM
	colors = [free_color] * len(used_space)
	for (i, value) in enumerate(values):
		if used_space[i]:
			colors[i] = colormapper(value)
	return colors

def sort_pixels(
	colors: list[Color],
	sorter_name: str,
	banked: bool,
	vertical: bool,
	narrow: bool
) -> list[list[Color]]:
	"""
	Sort the image pixels into rows.
	"""
	width = NARROW_BANK_WIDTH if narrow else DEFAULT_BANK_WIDTH
	# Sort from a 1D list of colors to a 2D list of rows of colors
	pixels = [[colors[0]] * width for _ in range(len(colors) // width)]
	sorter = sorters[sorter_name]
	for (i, color) in enumerate(colors):
		y, x = sorter(i, width, banked)
		pixels[y][x] = color
	# Transpose the pixels from vertical to horizontal
	if not vertical:
		pixels = [[row[i] for row in pixels] for i in range(width)]
	return pixels

def write_png(filename: str, pixels: list[list[Color]]) -> None:
	"""
	Write the output PNG image.
	"""
	# Flatten the rows of (R, G, B) channels for PyPNG compatibility
	width = len(pixels[0])
	height = len(pixels)
	grayscale = all(px[0] == px[1] == px[2] for row in pixels for px in row)
	if grayscale:
		channels = [[px[0] for px in row] for row in pixels]
	else:
		channels = [[c for px in row for c in px] for row in pixels]
	# Write the PNG file
	writer = png.Writer(width, height, greyscale=grayscale, bitdepth=8, compression=9)
	with open(filename, "wb") as file:
		writer.write(file, channels)


############################## Colormap functions ##############################

ColorStops: TypeAlias = tuple[tuple[float, Color], ...]

ColorMapper: TypeAlias = Callable[[float], Color]

colormaps: dict[str, tuple[ColorMapper, Color]] = {}

def register_colormap(
	name: str,
	free_color: Color,
) -> Callable[[ColorMapper], ColorMapper]:
	"""
	Register a colormap function along with its associated free space color.
	"""
	def decorator(colormapper: ColorMapper) -> ColorMapper:
		colormaps[name] = (colormapper, free_color)
		return colormapper
	return decorator

@register_colormap("grayscale", (0x12, 0x34, 0x56))
def grayscale_colormap(x: float) -> Color:
	"""
	Grayscale colormap.
	"""
	return rgb(x, x, x)

@register_colormap("binvis", (0x00, 0x40, 0x00))
def binvis_colormap(x: float) -> Color:
	"""
	Binvis colormap. Adapted from binvis.io <https://binvis.io/>.
	"""
	return rgb((2 * x - 1)**4 * (2 * x - 3)**4 if x > 0.5 else 0, 0, x**2)

@register_colormap("viridis", (0x00, 0x00, 0x00))
def viridis_colormap(x: float) -> Color:
	"""
	Viridis colormap. Adapted from Matplotlib.
	"""
	return interpolate_color(x, VIRIDIS_STOPS)

VIRIDIS_STOPS: ColorStops = (
	(  0 / 255, (0x44, 0x01, 0x54)),
	( 29 / 255, (0x48, 0x29, 0x79)),
	( 57 / 255, (0x3e, 0x4a, 0x89)),
	( 91 / 255, (0x2e, 0x6e, 0x8e)),
	(129 / 255, (0x20, 0x92, 0x8c)),
	(143 / 255, (0x1f, 0x9f, 0x88)),
	(154 / 255, (0x23, 0xa9, 0x83)),
	(170 / 255, (0x35, 0xb7, 0x79)),
	(188 / 255, (0x56, 0xc6, 0x67)),
	(208 / 255, (0x84, 0xd4, 0x4b)),
	(238 / 255, (0xd2, 0xe2, 0x1b)),
	(246 / 255, (0xe7, 0xe4, 0x19)),
	(255 / 255, (0xfd, 0xe7, 0x25)),
)

@register_colormap("plasma", (0x00, 0x00, 0x00))
def plasma_colormap(x: float) -> Color:
	"""
	Plasma colormap. Adapted from Matplotlib.
	"""
	return interpolate_color(x, PLASMA_STOPS)

PLASMA_STOPS: ColorStops = (
	(  0 / 255, (0x0d, 0x08, 0x87)),
	( 11 / 255, (0x28, 0x05, 0x92)),
	( 32 / 255, (0x4c, 0x02, 0xa1)),
	( 63 / 255, (0x7d, 0x03, 0xa8)),
	( 88 / 255, (0xa0, 0x1a, 0x9c)),
	(134 / 255, (0xd1, 0x4e, 0x72)),
	(171 / 255, (0xed, 0x7a, 0x52)),
	(202 / 255, (0xfc, 0xa3, 0x38)),
	(227 / 255, (0xfd, 0xca, 0x26)),
	(250 / 255, (0xf3, 0xf0, 0x27)),
	(255 / 255, (0xf0, 0xf9, 0x21)),
)

@register_colormap("coolwarm", (0x00, 0x00, 0x00))
def coolwarm_colormap(x: float) -> Color:
	"""
	Coolwarm colormap. Adapted from Matplotlib.
	"""
	return interpolate_color(x, COOLWARM_STOPS)

COOLWARM_STOPS: ColorStops = (
	(  0 / 255, (0x3b, 0x4c, 0xc0)),
	( 32 / 255, (0x62, 0x82, 0xea)),
	( 48 / 255, (0x77, 0x9a, 0xf7)),
	( 64 / 255, (0x8d, 0xb0, 0xfe)),
	( 80 / 255, (0xa3, 0xc2, 0xfe)),
	( 96 / 255, (0xb9, 0xd0, 0xf9)),
	(128 / 255, (0xdd, 0xdc, 0xdc)),
	(159 / 255, (0xf4, 0xc5, 0xad)),
	(191 / 255, (0xf4, 0x9a, 0x7b)),
	(215 / 255, (0xe5, 0x70, 0x58)),
	(239 / 255, (0xcb, 0x3e, 0x38)),
	(247 / 255, (0xc0, 0x28, 0x2f)),
	(255 / 255, (0xb4, 0x04, 0x26)),
)

@register_colormap("spectral", (0x00, 0x00, 0x00))
def spectral_colormap(x: float) -> Color:
	"""
	Spectral colormap. Adapted from Matplotlib.
	"""
	return interpolate_color(x, SPECTRAL_STOPS)

SPECTRAL_STOPS: ColorStops = (
	(0.0, (0x9e, 0x01, 0x42)),
	(0.1, (0xd5, 0x3e, 0x4f)),
	(0.2, (0xf4, 0x6d, 0x43)),
	(0.3, (0xfd, 0xae, 0x61)),
	(0.4, (0xfe, 0xe0, 0x8b)),
	(0.5, (0xff, 0xff, 0xbf)),
	(0.6, (0xe6, 0xf5, 0x98)),
	(0.7, (0xab, 0xdd, 0xa4)),
	(0.8, (0x66, 0xc2, 0xa5)),
	(0.9, (0x32, 0x88, 0xbd)),
	(1.0, (0x5e, 0x4f, 0xa2)),
)

@register_colormap("managua", (0x00, 0x00, 0x00))
def managua_colormap(x: float) -> Color:
	"""
	Managua colormap. Adapted from "Scientific colour maps" (Fabio Crameri, 2023).
	"""
	return interpolate_color(x, MANAGUA_STOPS)

MANAGUA_STOPS: ColorStops = (
	(  0 / 255, (0xff, 0xcf, 0x67)),
	( 16 / 255, (0xeb, 0xb0, 0x5d)),
	( 32 / 255, (0xd8, 0x93, 0x53)),
	( 48 / 255, (0xc5, 0x79, 0x4a)),
	( 64 / 255, (0xb1, 0x62, 0x43)),
	( 80 / 255, (0x9a, 0x4c, 0x3d)),
	( 96 / 255, (0x81, 0x39, 0x39)),
	(112 / 255, (0x69, 0x2b, 0x3c)),
	(128 / 255, (0x58, 0x29, 0x49)),
	(143 / 255, (0x4e, 0x32, 0x60)),
	(159 / 255, (0x4c, 0x45, 0x7f)),
	(175 / 255, (0x50, 0x5d, 0x9c)),
	(191 / 255, (0x57, 0x75, 0xb3)),
	(207 / 255, (0x60, 0x8e, 0xc7)),
	(223 / 255, (0x6b, 0xaa, 0xda)),
	(239 / 255, (0x76, 0xc7, 0xec)),
	(255 / 255, (0x81, 0xe7, 0xff)),
)

@register_colormap("cubehelix", (0x10, 0x10, 0x18))
def cubehelix_colormap(x: float) -> Color:
	"""
	Cubehelix colormap. Adapted from
	"A colour scheme for the display of astronomical intensity images" (Dave Green, 2011).
	"""
	x = clamp(x)
	angle = math.tau * (0.5 / 3 - 1.5 * x)
	amp = x * (1 - x) / 2
	c = math.cos(angle)
	s = math.sin(angle)
	r = x + amp * (-0.14861 * c + 1.78277 * s)
	g = x + amp * (-0.29227 * c - 0.90649 * s)
	b = x + amp * ( 1.97294 * c)
	return rgb(r, g, b)

@register_colormap("turbo", (0x00, 0x00, 0x00))
def turbo_colormap(x: float) -> Color:
	"""
	Turbo colormap. Adapted from Anton Mikhailov
	<https://research.google/blog/turbo-an-improved-rainbow-colormap-for-visualization/>.
	"""
	r = 0.13572138 + x * (4.615392600 + x * (-42.66032258 +
		x * (132.13108234 + x * (-152.94239396 + x * 59.28637943))))
	g = 0.09140261 + x * (2.194188390 + x * (  4.84296658 +
		x * (-14.18503333 + x * (   4.27729857 + x *  2.82956604))))
	b = 0.10667330 + x * (12.64194608 + x * (-60.58204836 +
		x * (110.36276771 + x * ( -89.90310912 + x * 27.34824973))))
	return rgb(r, g, b)


############################### Sorter functions ###############################

Coord: TypeAlias = tuple[int, int] # (Y, X)
Sorter: TypeAlias = Callable[[int, int, bool], Coord]

sorters: dict[str, Sorter] = {}

def register_sorter(name: str) -> Callable[[Sorter], Sorter]:
	"""
	Register a sorter function.
	"""
	def decorator(sorter: Sorter) -> Sorter:
		sorters[name] = sorter
		return sorter
	return decorator

@register_sorter("linear")
def linear_sort(i: int, width: int, banked: bool) -> Coord:
	"""
	Sort pixels linearly, top to bottom, left to right.
	"""
	if banked:
		bank, j = divmod(i, BANK_SIZE)
		bank_height = BANK_SIZE // width
		bx, by = divmod(j, bank_height)
		return (bank * bank_height + by, bx)
	else:
		return divmod(i, width)

@register_sorter("zigzag")
def zigzag_sort(i: int, width: int, banked: bool) -> Coord:
	"""
	Sort pixels in a back-and-forth zigzag (boustrophedon order).
	"""
	if banked:
		bank, j = divmod(i, BANK_SIZE)
		bank_height = BANK_SIZE // width
		bx, by = divmod(j, bank_height)
		y = bank * bank_height + (by if bx % 2 == 0 else bank_height - by - 1)
		return (y, bx)
	else:
		y, x = divmod(i, width)
		return (y, x if y % 2 == 0 else width - x - 1)

@register_sorter("hilbert")
def hilbert_sort(i: int, width: int, banked: bool) -> Coord:
	"""
	Sort pixels in a space-filling Hilbert curve within each bank.
	"""
	if banked:
		bank, j = divmod(i, BANK_SIZE)
		bank_height = BANK_SIZE // width
		square, h = divmod(j, bank_height**2)
		hy, hx = hilbert_index2coord(bank_height, h)
		return (bank * bank_height + hy, square * bank_height + hx)
	else:
		raise NotImplementedError

@register_sorter("zcurve")
def zcurve_sort(i: int, width: int, banked: bool) -> Coord:
	"""
	Sort pixels in a space-filling Z-order (aka Lebesgue or Morton) curve within each bank.
	"""
	if banked:
		bank, j = divmod(i, BANK_SIZE)
		bank_height = BANK_SIZE // width
		square, z = divmod(j, bank_height**2)
		zy, zx = zcurve_index2coord(z)
		y = bank * bank_height + (zy if square % 2 == 0 else bank_height - zy - 1) 
		return (y, square * bank_height + zx)
	else:
		raise NotImplementedError


############################### Utility functions ##############################

def interpolate_color(x: float, stops: ColorStops) -> Color:
	"""
	Piecewise interpolate a value into a color between a sequence of control points.
	"""
	if x <= stops[0][0]:
		return stops[0][1]
	if x >= stops[-1][0]:
		return stops[-1][1]
	lo = 0
	hi = len(stops) - 1
	while lo + 1 < hi:
		mid = (lo + hi) // 2
		if x < stops[mid][0]:
			hi = mid
		else:
			lo = mid
	x0, c0 = stops[lo]
	x1, c1 = stops[hi]
	t = (x - x0) / (x1 - x0)
	r = round(c0[0] + (c1[0] - c0[0]) * t)
	g = round(c0[1] + (c1[1] - c0[1]) * t)
	b = round(c0[2] + (c1[2] - c0[2]) * t)
	return (r, g, b)

def clamp(x: float) -> float:
	"""
	Clamp x between 0 and 1.
	"""
	return max(0, min(1, x))

def channel(c: float) -> int:
	"""
	Map [0, 1] to [0, 255] for color channels.
	"""
	return round(clamp(c) * 255)

def rgb(r: float, g: float, b: float) -> Color:
	"""
	Map three RGB color channels to a Color tuple.
	"""
	return (channel(r), channel(g), channel(b))

def calculate_entropy(contents: bytes, win_len: int) -> list[float]:
	"""
	Estimate the Shannon entropy around each ROM byte.
	"""
	length = len(contents)
	# Use the entire input if it is shorter than the requested window
	win_len = min(win_len, length)
	# Build the initial histogram
	histogram = [0] * 256
	for byte in contents[:win_len]:
		histogram[byte] += 1
	n_log_n = [0.0] + [n * math.log2(n) for n in range(1, win_len + 1)]
	total = sum(n_log_n[n] for n in histogram)
	# Calculate entropy around each byte over a sliding window
	entropy = [0.0] * length
	left = win_len // 2
	log_win = math.log2(win_len)
	for start in range(length - win_len + 1):
		center = start + left
		value = (log_win - total / win_len) / 8
		entropy[center] = clamp(value)
		if start + win_len < length:
			outgoing = contents[start]
			count = histogram[outgoing]
			histogram[outgoing] -= 1
			total += n_log_n[count - 1] - n_log_n[count]
			incoming = contents[start + win_len]
			count = histogram[incoming]
			histogram[incoming] += 1
			total += n_log_n[count + 1] - n_log_n[count]
	# Patch up the corners
	entropy[:left] = [entropy[left]] * left
	right = win_len - left - 1
	last = length - right - 1
	entropy[last + 1:] = [entropy[last]] * right
	return entropy

@cache
def hilbert_index2coord(n: int, d: int) -> Coord:
	"""
	Map a 1D index onto a 2D coordinate along a Hilbert curve.
	Adapted from "Programming the Hilbert curve" (John Skilling, 2004).
	"""
	y = x = 0
	t = d
	s = 1
	while s < n:
		rx = (t // 2) % 2
		ry = (t ^ rx) % 2
		if ry == 0:
			if rx == 1:
				x = s - 1 - x
				y = s - 1 - y
			x, y = y, x
		x += s * rx
		y += s * ry
		t //= 4
		s *= 2
	return (y, x)

@cache
def zcurve_index2coord(z: int) -> Coord:
	"""
	Map a 1D index onto a 2D coordinate along a Z-order curve.
	"""
	y = x = 0
	bit = 0
	while z > 0:
		x |= (z & 1) << bit
		z >>= 1
		y |= (z & 1) << bit
		z >>= 1
		bit += 1
	return (y, x)


###################################### Main ####################################

if __name__ == "__main__":
	main()
