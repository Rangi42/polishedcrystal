#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Generate a .png of a metatileset from its tileset graphics, metatiles.bin, and
attributes.bin files.
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

RGBC = lambda c: c * 8 # c * 33 // 4 for BGB instead of VBA
RGB5 = lambda r, g, b: (RGBC(r), RGBC(g), RGBC(b))

def load_palette(filename):
	try:
		palette = []
		with open(filename, 'r') as f:
			channels = []
			for line in f:
				line = line.split(';')[0].strip()
				if line.startswith('RGB '):
					rgbs = [RGBC(int(b)) for b in line[4:].split(',')]
					assert len(rgbs) % 3 == 0
					channels.extend(rgbs)
			hue = []
			while len(channels) >= 3:
				rgb, channels = channels[:3], channels[3:]
				hue.append(rgb)
				if len(hue) == 4:
					palette.append(hue)
					hue = []
	except:
		palette = [
			[RGB5(30,28,26), RGB5(19,19,19), RGB5(13,13,13), RGB5( 7, 7, 7)],
			[RGB5(30,28,26), RGB5(31,19,24), RGB5(30,10, 6), RGB5( 7, 7, 7)],
			[RGB5(18,24, 9), RGB5(15,20, 1), RGB5( 9,13, 0), RGB5( 7, 7, 7)],
			[RGB5(30,28,26), RGB5(15,16,31), RGB5( 9, 9,31), RGB5( 7, 7, 7)],
			[RGB5(30,28,26), RGB5(31,31, 7), RGB5(31,16, 1), RGB5( 7, 7, 7)],
			[RGB5(26,24,17), RGB5(21,17, 7), RGB5(16,13, 3), RGB5( 7, 7, 7)],
			[RGB5(30,28,26), RGB5(17,19,31), RGB5(14,16,31), RGB5( 7, 7, 7)],
			[RGB5(31,31,16), RGB5(31,31,16), RGB5(14, 9, 0), RGB5( 0, 0, 0)]
		]
	assert len(palette) >= 8
	return palette

class Tileset(object):
	WHITE, LIGHT, DARK, BLACK = range(4)

	p_per_t = 8

	def __init__(self, filename, attributes):
		self.attributes = attributes
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
			shade = 3 - 4 * px // (2 ** bitdepth)
			assert 0 <= shade < 4
			self.data.append(shade)

	def tile(self, i, attr):
		tile = []
		if attr & Attributes.BANK1:
			i |= 0x80
		else:
			i &= 0x7f
		ty, tx = divmod(i, self.wt)
		color = self.attributes.colors[attr & Attributes.COLOR]
		span = range(Tileset.p_per_t)
		if attr & Attributes.YFLIP:
			span = span[::-1]
		for r in span:
			start = ty*Tileset.p_per_t**2*self.wt + tx*Tileset.p_per_t + Tileset.p_per_t*self.wt*r
			row = self.data[start:start+Tileset.p_per_t]
			if attr & Attributes.XFLIP:
				row = row[::-1]
			row = [color[px] for px in row]
			tile.extend(row)
		if not tile:
			tile = [default_rgb] * Tileset.p_per_t**2
		return tile

	def tile_id_of_px(self, i):
		wt = self.wt
		tw = Tileset.p_per_t
		return (i // wt // (tw * tw) * wt) + (i // tw % wt)

class Attributes(object):
	GRAY, RED, GREEN, WATER, YELLOW, BROWN, ROOF, TEXT = range(8)
	COLOR    = 0x07
	BANK1    = 0x08
	XFLIP    = 0x20
	YFLIP    = 0x40
	PRIORITY = 0x80

	day_palette = staticmethod(lambda:
		(lambda x=load_palette('gfx/tilesets/bg_tiles.pal'): x[8:11]+[x[0x29]]+x[12:16])())
	nite_palette = staticmethod(lambda:
		(lambda x=load_palette('gfx/tilesets/bg_tiles.pal'): x[16:19]+[x[0x2a]]+x[20:24])())
	indoor_palette = staticmethod(lambda:
		load_palette('gfx/tilesets/bg_tiles.pal')[32:40])

	map_palettes = {
		'maps/BellchimeTrail.ablk': lambda: load_palette('maps/BellchimeTrail.pal')[8:16],
		'maps/BrunosRoom.ablk': lambda: load_palette('maps/BrunosRoom.pal'),
		'maps/CeladonHomeDecorStore4F.ablk': lambda: load_palette('maps/CeladonHomeDecorStore4F.pal'),
		'maps/CeladonMansionRoof.ablk': lambda: load_palette('maps/CeladonMansionRoof.pal')[8:16],
		'maps/CeruleanCave1F.ablk': lambda: load_palette('gfx/tilesets/cerulean_cave.pal'),
		'maps/CeruleanCave2F.ablk': lambda: load_palette('gfx/tilesets/cerulean_cave.pal'),
		'maps/CeruleanCaveB1F.ablk': lambda: load_palette('gfx/tilesets/cerulean_cave.pal'),
		'maps/CeruleanGym.ablk': lambda: load_palette('maps/CeruleanGym.pal'),
		'maps/CinnabarLab.ablk': lambda: load_palette('maps/CinnabarLab.pal'),
		'maps/CinnabarVolcano1F.ablk': lambda: load_palette('gfx/tilesets/cinnabar_volcano.pal'),
		'maps/CinnabarVolcanoB1F.ablk': lambda: load_palette('gfx/tilesets/cinnabar_volcano.pal'),
		'maps/CinnabarVolcanoB2F.ablk': lambda: load_palette('gfx/tilesets/cinnabar_volcano.pal'),
		'maps/CliffEdgeGate.ablk': lambda: Attributes.day_palette(),
		'maps/DarkCaveBlackthornEntrance.ablk': lambda: load_palette('gfx/tilesets/dark_cave.pal'),
		'maps/DarkCaveVioletEntrance.ablk': lambda: load_palette('gfx/tilesets/dark_cave.pal'),
		'maps/DimCave1F.ablk': lambda: load_palette('gfx/tilesets/dim_cave.pal'),
		'maps/DimCave2F.ablk': lambda: load_palette('gfx/tilesets/dim_cave.pal'),
		'maps/DimCave3F.ablk': lambda: load_palette('gfx/tilesets/dim_cave.pal'),
		'maps/DimCave4F.ablk': lambda: load_palette('gfx/tilesets/dim_cave.pal'),
		'maps/DimCave5F.ablk': lambda: load_palette('gfx/tilesets/dim_cave.pal'),
		'maps/DragonsDenB1F.ablk': lambda: Attributes.nite_palette(),
		'maps/DragonShrine.ablk': lambda: load_palette('maps/DragonShrine.pal'),
		'maps/EcruteakCity.ablk': lambda: load_palette('gfx/tilesets/violet_ecruteak.pal')[8:16],
		'maps/EmbeddedTower.ablk': lambda: load_palette('maps/EmbeddedTower.pal'),
		'maps/FuchsiaGym.ablk': lambda: load_palette('maps/FuchsiaGym.pal'),
		'maps/GoldenrodDeptStoreRoof.ablk': lambda: load_palette('maps/GoldenrodDeptStoreRoof.pal')[8:16],
		'maps/HallOfFame.ablk': lambda: load_palette('maps/HallOfFame.pal'),
		'maps/HauntedRadioTower2F.ablk': lambda: load_palette('gfx/tilesets/haunted_radio_tower.pal'),
		'maps/HauntedRadioTower3F.ablk': lambda: load_palette('gfx/tilesets/haunted_radio_tower.pal'),
		'maps/HauntedRadioTower4F.ablk': lambda: load_palette('gfx/tilesets/haunted_pokemon_tower.pal'),
		'maps/HauntedRadioTower5F.ablk': lambda: load_palette('gfx/tilesets/haunted_pokemon_tower.pal'),
		'maps/HauntedRadioTower6F.ablk': lambda: load_palette('gfx/tilesets/haunted_pokemon_tower.pal'),
		'maps/HiddenCaveGrotto.ablk': lambda: load_palette('maps/HiddenCaveGrotto.pal'),
		'maps/HiddenTreeGrotto.ablk': lambda: load_palette('maps/HiddenTreeGrotto.pal'),
		'maps/IvysLab.ablk': lambda: load_palette('maps/IvysLab.pal'),
		'maps/KarensRoom.ablk': lambda: load_palette('maps/KarensRoom.pal'),
		'maps/KogasRoom.ablk': lambda: load_palette('maps/KogasRoom.pal'),
		'maps/LancesRoom.ablk': lambda: load_palette('maps/LancesRoom.pal'),
		'maps/LightningIsland.ablk': lambda: load_palette('maps/LightningIsland.pal'),
		'maps/MountMortar1FInside.ablk': lambda: load_palette('gfx/tilesets/dark_cave.pal'),
		'maps/MountMortar1FOutside.ablk': lambda: load_palette('gfx/tilesets/dark_cave.pal'),
		'maps/MountMortar2FInside.ablk': lambda: load_palette('gfx/tilesets/dark_cave.pal'),
		'maps/MountMortarB1F.ablk': lambda: load_palette('gfx/tilesets/dark_cave.pal'),
		'maps/MurkySwamp.ablk': lambda: load_palette('maps/MurkySwamp.pal'),
		'maps/MystriStage.ablk': lambda: load_palette('maps/MystriStage.pal'),
		'maps/NavelRockInside.ablk': lambda: load_palette('gfx/tilesets/navel_rock.pal')[8:16],
		'maps/NavelRockRoof.ablk': lambda: load_palette('gfx/tilesets/navel_rock.pal')[8:16],
		'maps/NoisyForest.ablk': lambda: load_palette('gfx/tilesets/shamouti_island.pal')[16:24],
		'maps/OaksLab.ablk': lambda: load_palette('maps/OaksLab.pal'),
		'maps/OlivineLighthouseRoof.ablk': lambda: load_palette('maps/GoldenrodDeptStoreRoof.pal')[8:16],
		'maps/SaffronGym.ablk': lambda: load_palette('maps/SaffronGym.pal'),
		'maps/ScaryCave1F.ablk': lambda: load_palette('gfx/tilesets/scary_cave.pal'),
		'maps/ScaryCaveB1F.ablk': lambda: load_palette('gfx/tilesets/scary_cave.pal'),
		'maps/ScaryCaveShipwreck.ablk': lambda: load_palette('gfx/tilesets/scary_cave.pal'),
		'maps/SeafoamGym.ablk': lambda: Attributes.day_palette(),
		'maps/SilverCaveRoom1.ablk': lambda: load_palette('gfx/tilesets/silver_cave.pal'),
		'maps/SilverCaveRoom2.ablk': lambda: load_palette('gfx/tilesets/silver_cave.pal'),
		'maps/SilverCaveRoom3.ablk': lambda: load_palette('gfx/tilesets/silver_cave.pal'),
		'maps/SinjohRuins.ablk': lambda: load_palette('maps/SinjohRuins.pal')[8:16],
		'maps/TinTowerRoof.ablk': lambda: load_palette('maps/TinTowerRoof.pal')[8:16],
		'maps/VioletCity.ablk': lambda: load_palette('gfx/tilesets/violet_ecruteak.pal')[8:16],
		'maps/ViridianGym.ablk': lambda: load_palette('maps/ViridianGym.pal'),
		'maps/WhirlIslandB1F.ablk': lambda: load_palette('gfx/tilesets/whirl_islands.pal'),
		'maps/WhirlIslandB2F.ablk': lambda: load_palette('gfx/tilesets/whirl_islands.pal'),
		'maps/WhirlIslandLugiaChamber.ablk': lambda: load_palette('gfx/tilesets/whirl_islands.pal'),
		'maps/WhirlIslandNE.ablk': lambda: load_palette('gfx/tilesets/whirl_islands.pal'),
		'maps/WhirlIslandSE.ablk': lambda: load_palette('gfx/tilesets/whirl_islands.pal'),
		'maps/WhirlIslandSW.ablk': lambda: load_palette('gfx/tilesets/whirl_islands.pal'),
		'maps/WillsRoom.ablk': lambda: load_palette('maps/WillsRoom.pal'),
		'maps/YellowForest.ablk': lambda: load_palette('maps/YellowForest.pal')[8:16],
	}

	tileset_palettes = {
		'johto_traditional': lambda: Attributes.day_palette(),
		'johto_modern': lambda: Attributes.day_palette(),
		'battle_tower_outside': lambda: Attributes.day_palette(),
		'johto_overcast': lambda: Attributes.day_palette(),
		'kanto': lambda: Attributes.day_palette(),
		'indigo_plateau': lambda: Attributes.day_palette(),
		'park': lambda: Attributes.day_palette(),
		'forest': lambda: Attributes.nite_palette(),
		'cave': lambda: Attributes.nite_palette(),
		'tunnel': lambda: Attributes.nite_palette(),
		'alph_word_room': lambda: load_palette('gfx/tilesets/palettes/ruins_of_alph.pal'),
		'battle_tower_inside': lambda: load_palette('gfx/tilesets/palettes/battle_tower_inside.pal'),
		'faraway_island': lambda: load_palette('gfx/tilesets/palettes/faraway_island.pal')[8:16],
		'game_corner': lambda: load_palette('gfx/tilesets/palettes/game_corner.pal'),
		'gate': lambda: load_palette('gfx/tilesets/palettes/gate.pal'),
		'hotel': lambda: load_palette('gfx/tilesets/palettes/hotel.pal'),
		'ice_path': lambda: load_palette('gfx/tilesets/palettes/ice_path.pal'),
		'mart': lambda: load_palette('gfx/tilesets/palettes/mart.pal'),
		'pokecenter': lambda: load_palette('gfx/tilesets/palettes/pokecenter.pal'),
		'pokecom_center': lambda: load_palette('gfx/tilesets/palettes/pokecom_center.pal'),
		'quiet_cave': lambda: load_palette('gfx/tilesets/palettes/quiet_cave.pal'),
		'radio_tower': lambda: load_palette('gfx/tilesets/palettes/radio_tower.pal'),
		'ruins_of_alph': lambda: load_palette('gfx/tilesets/palettes/ruins_of_alph.pal'),
		'safari_zone': lambda: load_palette('gfx/tilesets/palettes/safari_zone.pal')[8:16],
		'shamouti_island': lambda: load_palette('gfx/tilesets/palettes/shamouti_island.pal')[8:16],
		'valencia_island': lambda: load_palette('gfx/tilesets/palettes/valencia_island.pal')[8:16],
	}

	def __init__(self, filename, key, map_blk):
		colors_lambda = Attributes.map_palettes.get(map_blk,
			Attributes.tileset_palettes.get(key, Attributes.day_palette))
		self.colors = colors_lambda()
		assert len(self.colors) == 8
		self.data = []
		with open(filename, 'rb') as file:
			while True:
				tile_attrs = [ord(c) for c in file.read(Metatiles.t_per_m**2)]
				if not len(tile_attrs):
					break
				self.data.append(tile_attrs)

	def color4(self, i):
		return self.colors[self.data[i]] if i < len(self.data) else [default_rgb] * 4

class Metatiles(object):
	t_per_m = 4

	def __init__(self, filename, tileset, attributes):
		self.tileset = tileset
		self.attributes = attributes
		self.data = []
		with open(filename, 'rb') as file:
			i = 0
			while True:
				tile_indexes = [ord(c) for c in file.read(Metatiles.t_per_m**2)]
				if not len(tile_indexes):
					break
				attr_indexes = self.attributes.data[i]
				metatile = [tileset.tile(ti, ta) for ti, ta in zip(tile_indexes, attr_indexes)]
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

def process(key, tileset_name, metatiles_name, attributes_name, map_blk):
	attributes = Attributes(attributes_name, key, map_blk)
	tileset = Tileset(tileset_name, attributes)
	metatiles = Metatiles(metatiles_name, tileset, attributes)

	metatiles_colored_name = metatiles_name[:-4] + '.png'
	metatiles.export_colored(metatiles_colored_name)
	print('Exported', metatiles_colored_name)

def main():
	valid = False
	if len(sys.argv) in [2, 3]:
		name = sys.argv[1]
		tileset = 'gfx/tilesets/%s.2bpp.lz' % name
		metatiles = 'data/tilesets/%s_metatiles.bin' % name
		attributes = 'data/tilesets/%s_attributes.bin' % name
		map_blk = sys.argv[2] if len(sys.argv) == 3 else None
	elif len(sys.argv) in [4, 5]:
		name = None
		tileset = sys.argv[1]
		metatiles = sys.argv[2]
		attributes = sys.argv[3]
		map_blk = sys.argv[4] if len(sys.argv) == 5 else None
	else:
		usage = '''Usage: %s tileset [metatiles.bin attributes.bin map.blk]
       Generate a .png of a metatileset for viewing

       If tileset is gfx/tilesets/FOO.{2bpp.lz,2bpp,png},
       the other parameters will be inferred as
       data/tilesets/FOO_metatiles.bin and data/tilesets/FOO_attributes.bin.

       If tileset is FOO, it will first be inferred as
       gfx/tilesets/FOO.2bpp.lz.

       If a map is specified, its unique palette may be used.'''
		print(usage % sys.argv[0], file=sys.stderr)
		sys.exit(1)

	if tileset.endswith('.2bpp.lz') and not os.path.exists(tileset):
		tileset = tileset[:-3]

	if not tileset.endswith('.png'):
		os.system('python gfx.py png %s' % tileset)
	if tileset.endswith('.2bpp'):
		tileset = tileset[:-5] + '.png'
	elif tileset.endswith('.2bpp.lz'):
		tileset = tileset[:-8] + '.png'

	process(name, tileset, metatiles, attributes, map_blk)

if __name__ == '__main__':
	main()
