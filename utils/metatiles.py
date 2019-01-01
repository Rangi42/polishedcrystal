#!/usr/bin/env python
# -*- coding: utf-8 -*-

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
	color_constants = {
		'GRAY': 0, 'RED': 1, 'GREEN': 2, 'WATER': 3,
		'YELLOW': 4, 'BROWN': 5, 'ROOF': 6, 'TEXT': 7,
		'PRIORITY_GRAY': 0, 'PRIORITY_RED': 1,
		'PRIORITY_GREEN': 2, 'PRIORITY_WATER': 3,
		'PRIORITY_YELLOW': 4, 'PRIORITY_BROWN': 5,
		'PRIORITY_ROOF': 6, 'PRIORITY_TEXT': 7
	}

	day_palette = staticmethod(lambda:
		(lambda x=load_palette('gfx/tilesets/palettes/bg.pal'): x[8:11]+[x[0x29]]+x[12:16])())
	nite_palette = staticmethod(lambda:
		(lambda x=load_palette('gfx/tilesets/palettes/bg.pal'): x[16:19]+[x[0x2a]]+x[20:24])())
	indoor_palette = staticmethod(lambda:
		load_palette('gfx/tilesets/palettes/bg.pal')[32:40])

	map_palettes = {
		'maps/BellchimeTrail.blk': lambda: load_palette('gfx/tilesets/palettes/bellchime_trail.pal')[8:16],
		'maps/BrunosRoom.blk': lambda: load_palette('gfx/tilesets/palettes/brunos_room.pal'),
		'maps/CeladonHomeDecorStore4F.blk': lambda: load_palette('gfx/tilesets/palettes/celadon_home_decor_store_4f.pal'),
		'maps/CeladonMansionRoof.blk': lambda: load_palette('gfx/tilesets/palettes/celadon_mansion_roof.pal')[8:16],
		'maps/CeruleanCave1F.blk': lambda: load_palette('gfx/tilesets/palettes/cerulean_cave.pal'),
		'maps/CeruleanCave2F.blk': lambda: load_palette('gfx/tilesets/palettes/cerulean_cave.pal'),
		'maps/CeruleanCaveB1F.blk': lambda: load_palette('gfx/tilesets/palettes/cerulean_cave.pal'),
		'maps/CeruleanGym.blk': lambda: load_palette('gfx/tilesets/palettes/cerulean_gym.pal'),
		'maps/CharcoalKiln.blk': lambda: load_palette('gfx/tilesets/palettes/charcoal_kiln.pal'),
		'maps/CinnabarLab.blk': lambda: load_palette('gfx/tilesets/palettes/cinnabar_lab.pal'),
		'maps/CinnabarVolcano1F.blk': lambda: load_palette('gfx/tilesets/palettes/cinnabar_volcano.pal'),
		'maps/CinnabarVolcanoB1F.blk': lambda: load_palette('gfx/tilesets/palettes/cinnabar_volcano.pal'),
		'maps/CinnabarVolcanoB2F.blk': lambda: load_palette('gfx/tilesets/palettes/cinnabar_volcano.pal'),
		'maps/CliffEdgeGate.blk': lambda: PaletteMap.day_palette(),
		'maps/DarkCaveBlackthornEntrance.blk': lambda: load_palette('gfx/tilesets/palettes/dark_cave.pal'),
		'maps/DarkCaveVioletEntrance.blk': lambda: load_palette('gfx/tilesets/palettes/dark_cave.pal'),
		'maps/DimCave1F.blk': lambda: load_palette('gfx/tilesets/palettes/dim_cave.pal'),
		'maps/DimCave2F.blk': lambda: load_palette('gfx/tilesets/palettes/dim_cave.pal'),
		'maps/DimCave3F.blk': lambda: load_palette('gfx/tilesets/palettes/dim_cave.pal'),
		'maps/DimCave4F.blk': lambda: load_palette('gfx/tilesets/palettes/dim_cave.pal'),
		'maps/DimCave5F.blk': lambda: load_palette('gfx/tilesets/palettes/dim_cave.pal'),
		'maps/DragonsDenB1F.blk': lambda: PaletteMap.nite_palette(),
		'maps/DragonShrine.blk': lambda: load_palette('gfx/tilesets/palettes/dragon_shrine.pal'),
		'maps/EcruteakCity.blk': lambda: load_palette('gfx/tilesets/palettes/violet_ecruteak.pal')[8:16],
		'maps/EmbeddedTower.blk': lambda: load_palette('gfx/tilesets/palettes/embedded_tower.pal'),
		'maps/FuchsiaGym.blk': lambda: load_palette('gfx/tilesets/palettes/fuchsia_gym.pal'),
		'maps/GoldenrodDeptStoreRoof.blk': lambda: load_palette('gfx/tilesets/palettes/goldenrod_dept_store_roof.pal')[8:16],
		'maps/HallOfFame.blk': lambda: load_palette('gfx/tilesets/palettes/lances_room.pal'),
		'maps/HauntedRadioTower2F.blk': lambda: load_palette('gfx/tilesets/palettes/haunted_radio_tower.pal'),
		'maps/HauntedRadioTower3F.blk': lambda: load_palette('gfx/tilesets/palettes/haunted_radio_tower.pal'),
		'maps/HauntedRadioTower4F.blk': lambda: load_palette('gfx/tilesets/palettes/haunted_pokemon_tower.pal'),
		'maps/HauntedRadioTower5F.blk': lambda: load_palette('gfx/tilesets/palettes/haunted_pokemon_tower.pal'),
		'maps/HauntedRadioTower6F.blk': lambda: load_palette('gfx/tilesets/palettes/haunted_pokemon_tower.pal'),
		'maps/HiddenCaveGrotto.blk': lambda: load_palette('gfx/tilesets/palettes/hidden_cave_grotto.pal'),
		'maps/HiddenTreeGrotto.blk': lambda: load_palette('gfx/tilesets/palettes/hidden_tree_grotto.pal'),
		'maps/IvysLab.blk': lambda: load_palette('gfx/tilesets/palettes/ivys_lab.pal'),
		'maps/KarensRoom.blk': lambda: load_palette('gfx/tilesets/palettes/karens_room.pal'),
		'maps/KogasRoom.blk': lambda: load_palette('gfx/tilesets/palettes/kogas_room.pal'),
		'maps/LancesRoom.blk': lambda: load_palette('gfx/tilesets/palettes/lances_room.pal'),
		'maps/LightningIsland.blk': lambda: load_palette('gfx/tilesets/palettes/lightning_island.pal'),
		'maps/MountMortar1FInside.blk': lambda: load_palette('gfx/tilesets/palettes/dark_cave.pal'),
		'maps/MountMortar1FOutside.blk': lambda: load_palette('gfx/tilesets/palettes/dark_cave.pal'),
		'maps/MountMortar2FInside.blk': lambda: load_palette('gfx/tilesets/palettes/dark_cave.pal'),
		'maps/MountMortarB1F.blk': lambda: load_palette('gfx/tilesets/palettes/dark_cave.pal'),
		'maps/MurkySwamp.blk': lambda: load_palette('gfx/tilesets/palettes/murky_swamp.pal'),
		'maps/MystriStage.blk': lambda: load_palette('gfx/tilesets/palettes/mystri_stage.pal'),
		'maps/NavelRockInside.blk': lambda: load_palette('gfx/tilesets/palettes/navel_rock.pal')[8:16],
		'maps/NavelRockRoof.blk': lambda: load_palette('gfx/tilesets/palettes/navel_rock.pal')[8:16],
		'maps/NoisyForest.blk': lambda: load_palette('gfx/tilesets/palettes/shamouti_island.pal')[16:24],
		'maps/OaksLab.blk': lambda: load_palette('gfx/tilesets/palettes/oaks_lab.pal'),
		'maps/OlivineLighthouseRoof.blk': lambda: load_palette('gfx/tilesets/palettes/goldenrod_dept_store_roof.pal')[8:16],
		'maps/SaffronGym.blk': lambda: load_palette('gfx/tilesets/palettes/saffron_gym.pal'),
		'maps/ScaryCave1F.blk': lambda: load_palette('gfx/tilesets/palettes/scary_cave.pal'),
		'maps/ScaryCaveB1F.blk': lambda: load_palette('gfx/tilesets/palettes/scary_cave.pal'),
		'maps/ScaryCaveShipwreck.blk': lambda: load_palette('gfx/tilesets/palettes/scary_cave.pal'),
		'maps/SeafoamGym.blk': lambda: PaletteMap.day_palette(),
		'maps/SilverCaveRoom1.blk': lambda: load_palette('gfx/tilesets/palettes/silver_cave.pal'),
		'maps/SilverCaveRoom2.blk': lambda: load_palette('gfx/tilesets/palettes/silver_cave.pal'),
		'maps/SilverCaveRoom3.blk': lambda: load_palette('gfx/tilesets/palettes/silver_cave.pal'),
		'maps/SinjohRuins.blk': lambda: load_palette('gfx/tilesets/palettes/sinjoh_ruins.pal')[8:16],
		'maps/TinTowerRoof.blk': lambda: load_palette('gfx/tilesets/palettes/tin_tower_roof.pal')[8:16],
		'maps/VioletCity.blk': lambda: load_palette('gfx/tilesets/palettes/violet_ecruteak.pal')[8:16],
		'maps/ViridianGym.blk': lambda: load_palette('gfx/tilesets/palettes/viridian_gym.pal'),
		'maps/WhirlIslandB1F.blk': lambda: load_palette('gfx/tilesets/palettes/whirl_islands.pal'),
		'maps/WhirlIslandB2F.blk': lambda: load_palette('gfx/tilesets/palettes/whirl_islands.pal'),
		'maps/WhirlIslandLugiaChamber.blk': lambda: load_palette('gfx/tilesets/palettes/whirl_islands.pal'),
		'maps/WhirlIslandNE.blk': lambda: load_palette('gfx/tilesets/palettes/whirl_islands.pal'),
		'maps/WhirlIslandSE.blk': lambda: load_palette('gfx/tilesets/palettes/whirl_islands.pal'),
		'maps/WhirlIslandSW.blk': lambda: load_palette('gfx/tilesets/palettes/whirl_islands.pal'),
		'maps/WillsRoom.blk': lambda: load_palette('gfx/tilesets/palettes/wills_room.pal'),
		'maps/YellowForest.blk': lambda: load_palette('gfx/tilesets/palettes/yellow_forest.pal')[8:16],
	}

	tileset_palettes = {
		'johto1': lambda: PaletteMap.day_palette(),
		'johto2': lambda: PaletteMap.day_palette(),
		'johto3': lambda: PaletteMap.day_palette(),
		'johto4': lambda: PaletteMap.day_palette(),
		'kanto1': lambda: PaletteMap.day_palette(),
		'kanto2': lambda: PaletteMap.day_palette(),
		'park': lambda: PaletteMap.day_palette(),
		'forest': lambda: PaletteMap.nite_palette(),
		'cave': lambda: PaletteMap.nite_palette(),
		'tunnel': lambda: PaletteMap.nite_palette(),
		'alph': lambda: load_palette('gfx/tilesets/palettes/ruins.pal'),
		'battle_tower': lambda: load_palette('gfx/tilesets/palettes/battle_tower.pal'),
		'faraway': lambda: load_palette('gfx/tilesets/palettes/faraway_island.pal')[8:16],
		'game_corner': lambda: load_palette('gfx/tilesets/palettes/game_corner.pal'),
		'gate': lambda: load_palette('gfx/tilesets/palettes/gate.pal'),
		'hotel': lambda: load_palette('gfx/tilesets/palettes/hotel.pal'),
		'ice_path': lambda: load_palette('gfx/tilesets/palettes/ice_path.pal'),
		'mart': lambda: load_palette('gfx/tilesets/palettes/mart.pal'),
		'pokecenter': lambda: load_palette('gfx/tilesets/palettes/pokecenter.pal'),
		'pokecom': lambda: load_palette('gfx/tilesets/palettes/pokecom.pal'),
		'quiet_cave': lambda: load_palette('gfx/tilesets/palettes/quiet_cave.pal'),
		'radio_tower': lambda: load_palette('gfx/tilesets/palettes/radio_tower.pal'),
		'ruins': lambda: load_palette('gfx/tilesets/palettes/ruins.pal'),
		'safari': lambda: load_palette('gfx/tilesets/palettes/safari_zone.pal')[8:16],
		'shamouti': lambda: load_palette('gfx/tilesets/palettes/shamouti_island.pal')[8:16],
		'valencia': lambda: load_palette('gfx/tilesets/palettes/valencia_island.pal')[8:16],
	}

	def __init__(self, filename, key, map_blk):
		colors_lambda = PaletteMap.map_palettes.get(map_blk,
			PaletteMap.tileset_palettes.get(key, PaletteMap.indoor_palette))
		colors = colors_lambda()
		assert len(colors) == 8
		colors = {k: colors[v] for k, v in PaletteMap.color_constants.items()}
		self.data = []
		with open(filename, 'r') as file:
			for line in file:
				line = line.strip()
				if line.startswith('tilepal '):
					indexes = line[len('tilepal '):].split(',')[1:]
					more_data = [colors[c.strip()][::-1] for c in indexes]
					self.data.extend(more_data)

	def color4(self, i):
		return self.data[i] if i < len(self.data) else [default_rgb] * 4

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
				metatile = [tileset.tile(ti) for ti in tile_indexes]
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

def process(key, tileset_name, palette_map_name, metatiles_name, map_blk):
	palette_map = PaletteMap(palette_map_name, key, map_blk)
	tileset = Tileset(tileset_name, palette_map)
	metatiles = Metatiles(metatiles_name, tileset)

	tileset_colored_name = tileset_name[:-4] + '.colored.png'
	tileset.export_colored(tileset_colored_name)
	print('Exported', tileset_colored_name)

	metatiles_colored_name = metatiles_name[:-4] + '.png'
	metatiles.export_colored(metatiles_colored_name)
	print('Exported', metatiles_colored_name)

def main():
	valid = False
	if len(sys.argv) in [2, 3]:
		name = sys.argv[1]
		tileset = 'gfx/tilesets/%s.2bpp.lz' % name
		palette_map = 'gfx/tilesets/%s_palette_map.asm' % name
		metatiles = 'data/tilesets/%s_metatiles.bin' % name
		map_blk = sys.argv[2] if len(sys.argv) == 3 else None
	elif len(sys.argv) in [4, 5]:
		name = None
		tileset = sys.argv[1]
		palette_map = sys.argv[2]
		metatiles = sys.argv[3]
		map_blk = sys.argv[4] if len(sys.argv) == 5 else None
	else:
		usage = '''Usage: %s tileset [palette_map.asm metatiles.bin map.blk]
       Generate a .png of a metatileset for viewing

       If tileset is gfx/tilesets/##.{2bpp.lz,2bpp,png},
       the other parameters will be inferred as
       gfx/tilesets/##_palette_map.asm and data/tilesets/##_metatiles.bin.

       If tileset is ##, it will first be inferred as
       gfx/tilesets/##.2bpp.lz.

       If a map is specified, its unique palette may be used.'''
		print(usage % sys.argv[0], file=sys.stderr)
		sys.exit(1)

	if not tileset.endswith('.png'):
		os.system('python gfx.py png %s' % tileset)
	if tileset.endswith('.2bpp'):
		tileset = tileset[:-5] + '.png'
	elif tileset.endswith('.2bpp.lz'):
		tileset = tileset[:-8] + '.png'

	process(name, tileset, palette_map, metatiles, map_blk)

if __name__ == '__main__':
	main()
