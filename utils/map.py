#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Generate a .png of a map .ablk file.
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

default_rgb = (0xAB, 0xCD, 0xEF)

class Metatiles(object):
	p_per_mt = 32

	def __init__(self, filename):
		reader = png.Reader(filename=filename)
		w, h, data, metadata = reader.read_flat()
		self.wmt, self.hmt = w // Metatiles.p_per_mt, h // Metatiles.p_per_mt
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

		for i in range(w * h):
			px = data[i*stride:(i+1)*stride]
			if palette:
				px = palette[px]
			px = tuple(px)
			self.data.append(px)

	def size(self):
		return len(self.data) // Metatiles.p_per_mt**2

	def tile(self, i):
		tile = []
		mty, mtx = divmod(i, self.wmt)
		for r in range(Metatiles.p_per_mt):
			start = mty*Metatiles.p_per_mt**2*self.wmt + mtx*Metatiles.p_per_mt + Metatiles.p_per_mt*self.wmt*r
			row = self.data[start:start+Metatiles.p_per_mt]
			tile.extend(row)
		if not tile:
			tile = [default_rgb] * Metatiles.p_per_mt**2
		return tile

class Map(object):
	def __init__(self, blockfile_name, size, metatiles):
		self.data = []
		with open(blockfile_name, 'rb') as blockfile:
			for mti in blockfile.read():
				mti = ord(mti)
				self.data.append(metatiles.tile(mti))
		if size.startswith('h'):
			self.height = int(size[1:])
			self.width = len(self.data) // self.height
		else:
			self.width = int(size.rstrip('w'))
			self.height = len(self.data) // self.width

	def export(self, filename):
		overall_w = self.width * Metatiles.p_per_mt
		overall_h = self.height * Metatiles.p_per_mt
		data = [default_rgb] * (overall_w * overall_h)

		for p_i in range(overall_w * overall_h):
			p_y, p_x = divmod(p_i, overall_w)
			mt_y, mt_dy = divmod(p_y, Metatiles.p_per_mt)
			mt_x, mt_dx = divmod(p_x, Metatiles.p_per_mt)
			mt_i = mt_y * self.width + mt_x
			mt_d = mt_dy * Metatiles.p_per_mt + mt_dx
			data[p_i] = self.data[mt_i][mt_d]

		with open(filename, 'wb') as file:
			writer = png.Writer(overall_w, overall_h)
			writer.write(file, chunk(rgb_bytes(data), overall_w * 3))

def process(blockfile_name, size, metatiles_name):
	metatiles = Metatiles(metatiles_name)
	map = Map(blockfile_name, size, metatiles)
	filename = blockfile_name[:-5] + '.png'
	map.export(filename)
	print('Exported', filename)

def main():
	if len(sys.argv) < 4:
		usage = '''Usage: %s map.ablk (width | 'h'height) tileset
       Generate a .png of a map for viewing'''
		print(usage % sys.argv[0], file=sys.stderr)
		sys.exit(1)

	blockfile = sys.argv[1]
	size = sys.argv[2]
	tileset = sys.argv[3]
	os.system('python utils/metatiles.py %s %s' % (tileset, blockfile))
	metatiles = 'data/tilesets/%s_metatiles.png' % tileset

	process(blockfile, size, metatiles)

if __name__ == '__main__':
	main()
