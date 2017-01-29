#!/usr/bin/env python

"""
Generate a .png of a 32x32 metatileset from its corresponding 8x8 tileset,
palette_map.asm file, and metatiles.bin file.
"""

from __future__ import print_function

import sys
import os
import os.path
import re
import array

from itertools import izip_longest

import png

def chunk(L, n, fillvalue=None):
	return izip_longest(*[iter(L)] * n, fillvalue=fillvalue)

def rgb_bytes(rgbs):
	for px in rgbs:
		yield px[0]
		yield px[1]
		yield px[2]

num_shades = 4
default_rgb = (255, 255, 255)

class Tileset(object):
	p_per_t = 8

	def __init__(self, filename, palette_map):
		reader = png.Reader(filename=filename)
		self.w, self.h, data, metadata = reader.read_flat()
		self.wt, self.ht = self.w // Tileset.p_per_t, self.h // Tileset.p_per_t
		self.nt = self.wt * self.ht
		self.data = []

		if 'palette' in metadata:
			palette = metadata['palette']
			stride = 1
		else:
			palette = None
			stride = metadata['planes']
			if metadata['alpha']:
				stride += 1
		bitdepth = metadata['bitdepth']
		planes = metadata['planes']

		for i in range(self.w * self.h):
			px = data[i*stride:(i+1)*stride][0]
			if palette:
				px = palette[px][0]
			shade = px * num_shades // (2 ** bitdepth)

			color4 = palette_map.color4(self.tile_id_of_px(i))
			self.data.append(color4[shade])

	def tile(self, i):
		tile = []
		ty, tx = divmod(i, self.wt)
		for r in range(Tileset.p_per_t):
			start = ty*Tileset.p_per_t**2*self.wt + tx*Tileset.p_per_t + Tileset.p_per_t*self.wt*r
			row = self.data[start:start+Tileset.p_per_t]
			tile.extend(row)
		if not tile:
			tile = [default_rgb] * Tileset.p_per_t**2
		return tile

	def tile_id_of_px(self, i):
		wt = self.wt
		tw = Tileset.p_per_t
		return (i // wt // (tw * tw) * wt) + (i // tw % wt)

	def export_colored(self, filename):
		with open(filename, 'wb') as file:
			writer = png.Writer(self.w, self.h)
			writer.write(file, chunk(rgb_bytes(self.data), self.w * 3))

class PaletteMap(object):
	colors = {
		'GRAY': [(56,56,56), (104,104,104), (168,168,168), (216,248,216)],
		'RED': [(56,56,56), (240,80,48), (248,152,192), (216,248,216)],
		'GREEN': [(56,56,56), (40,112,0), (96,200,8), (176,248,80)],
		'WATER': [(56,56,56), (104,96,248), (144,152,248), (184,184,248)],
		'YELLOW': [(56,56,56), (248,128,8), (248,248,56), (216,248,216)],
		'BROWN': [(56,56,56), (160,120,24), (192,144,56), (216,248,216)],
		'ROOF': [(56,56,56), (120,40,168), (120,112,224), (216,248,216)],
	}

	def __init__(self, filename):
		self.data = []
		with open(filename, 'r') as file:
			for line in file:
				line = line.strip()
				if line.startswith('tilepal'):
					eight = line[7:].split(',')[-8:]
					assert len(eight) == 8
					self.data.extend([PaletteMap.colors[c.strip()] for c in eight])

	def color4(self, i):
		return self.data[i]

class Metatiles(object):
	t_per_m = 4

	def __init__(self, filename, tileset):
		self.tileset = tileset
		self.data = []
		with open(filename, 'rb') as file:
			i = 0
			while True:
				tile_indexes = [ord(c) for c in file.read(Metatiles.t_per_m**2)]
				if not len(tile_indexes):
					break
				metatile = [tileset.tile(ti if ti < 0x60 else ti - 0x20) for ti in tile_indexes]
				self.data.append(metatile)
				i += 1

	def size(self):
		return len(self.data)

	def export_colored(self, filename):
		wm = 4
		hm = self.size() // wm
		if wm * hm < self.size():
			hm += 1
		overall_w = wm * Metatiles.t_per_m * Tileset.p_per_t
		overall_h = hm * Metatiles.t_per_m * Tileset.p_per_t
		data = [default_rgb] * (overall_w * overall_h)

		for d_i in range(overall_w * overall_h):
			d_y, d_x = divmod(d_i, wm * Metatiles.t_per_m * Tileset.p_per_t)
			m_x, r_x = divmod(d_x, Metatiles.t_per_m * Tileset.p_per_t)
			t_x, p_x = divmod(r_x, Tileset.p_per_t)
			m_y, r_y = divmod(d_y, Metatiles.t_per_m * Tileset.p_per_t)
			t_y, p_y = divmod(r_y, Tileset.p_per_t)
			m_i = m_y * wm + m_x
			t_i = t_y * Metatiles.t_per_m + t_x
			p_i = p_y * Tileset.p_per_t + p_x
			if m_i >= self.size():
				continue
			metatile = self.data[m_i]
			tile = metatile[t_i]
			pixel = tile[p_i]
			data[d_i] = pixel

		with open(filename, 'wb') as file:
			writer = png.Writer(overall_w, overall_h)
			writer.write(file, chunk(rgb_bytes(data), overall_w * 3))

def process(tileset_name, palette_map_name, metatiles_name):
	palette_map = PaletteMap(palette_map_name)
	tileset = Tileset(tileset_name, palette_map)
	metatiles = Metatiles(metatiles_name, tileset)

	tileset_colored_name = tileset_name[:-4] + '_colored.png'
	tileset.export_colored(tileset_colored_name)
	print('Exported', tileset_colored_name)

	metatiles_colored_name = metatiles_name[:-4] + '_colored.png'
	metatiles.export_colored(metatiles_colored_name)
	print('Exported', metatiles_colored_name)

def main():
	valid = False
	if len(sys.argv) == 2:
		name = sys.argv[1]
		tileset = 'gfx/tilesets/%s.2bpp.lz' % name
		palette_map = 'tilesets/%s_palette_map.asm' % name
		metatiles = 'tilesets/%s_metatiles.bin' % name
	elif len(sys.argv) == 4:
		tileset = sys.argv[1]
		palette_map = sys.argv[2]
		metatiles = sys.argv[3]
	else:
		usage = '''Usage: %s tileset [palette_map.asm metatiles.bin]
       Generate a .png of a metatileset for viewing

       If tileset is gfx/tilesets/##.{2bpp.lz,2bpp,png},
       the other parameters will be inferred as
       tilesets/##_palette_map.asm and tilesets/##_metatiles.bin.

       If tileset is ##, it will first be inferred as
       gfx/tilesets/##.2bpp.lz.'''
		print(usage % sys.argv[0], file=sys.stderr)
		sys.exit(1)

	if not tileset.endswith('.png'):
		os.system('python gfx.py png %s' % tileset)
	if tileset.endswith('.2bpp'):
		tileset = tileset[:-5] + '.png'
	elif tileset.endswith('.2bpp.lz'):
		tileset = tileset[:-8] + '.png'

	process(tileset, palette_map, metatiles)

if __name__ == '__main__':
	main()
