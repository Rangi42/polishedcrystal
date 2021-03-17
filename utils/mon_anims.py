#!/usr/bin/env python3

from glob import iglob
from os.path import isfile
from copy import deepcopy
from collections import namedtuple

Frame = namedtuple('Frame', ('bitmask', 'offsets'))

def chunk(s, n):
	return [s[i:i+n] for i in range(0, len(s), n)]

# Process each Pokémon's animation data

for front_name in iglob('gfx/pokemon/*/front.2bpp'):
	mon_name = front_name[len('gfx/pokemon/'):-len('/front.2bpp')]

	print(mon_name)

	# Get associated file names

	bitmask_name = 'gfx/pokemon/%s/bitmask.asm' % mon_name
	assert isfile(bitmask_name), 'no bitmask.asm for %s' % mon_name

	frames_name = 'gfx/pokemon/%s/frames.asm' % mon_name
	assert isfile(frames_name), 'no frames.asm for %s' % mon_name

	base_name = 'data/pokemon/base_stats/%s.asm' % mon_name
	if not isfile(base_name):
		base_name = 'data/pokemon/base_stats/%s.asm' % mon_name.split('_', 1)[0]
	assert isfile(base_name), 'no base data for %s' % mon_name

	# Read dimensions from base data

	dimensions = None
	with open(base_name, 'r', encoding='utf8') as file:
		for line in file:
			if line.startswith('\tdn ') and line.endswith(' ; frontpic dimensions\n'):
				dimensions = eval(line[len('\tdn '):-len(' ; frontpic dimensions\n')])
	assert dimensions, 'no dimensions for %s' % mon_name
	assert dimensions in {(5,5),(6,6),(7,7)}, 'invalid dimensions for %s: %s' % (mon_name, dimensions)
	dimension = dimensions[0]

	# Read tiles from front.2bpp

	tiles = []
	with open(front_name, 'rb') as file:
		tile_bytes = file.read()
		assert len(tile_bytes) % 16 == 0, 'odd front.2bpp bytes for %s: %d' % (mon_name, len(tile_bytes))
	tiles = chunk(tile_bytes, 16)
	assert len(tiles) >= dimension**2, 'insufficient tiles for %s: %d < %dx%d' % (mon_name, len(tiles), dimension, dimension)

	# Read bitmask bits from bitmasks.asm

	bitmask_stride = dimension**2 // 8 + bool(dimension**2 % 8)
	bitmasks = []
	with open(bitmask_name, 'r', encoding='utf8') as file:
		bitmask_bytes = []
		for line in file:
			if line.startswith('\tdb %'):
				bitmask_bits = line[len('\tdb %'):].strip()
				assert len(bitmask_bits) == 8, 'odd bitmask for %s: %%%s' % (mon_name, bitmask_bits)
				assert all(c in '01' for c in bitmask_bits), 'nonbinary bitmask for %s: %%%s' % (mon_name, bitmask_bits)
				bitmask_bytes.append(bitmask_bits)
				if len(bitmask_bytes) == bitmask_stride:
					whole_bits = ''.join(reversed(''.join(reversed(bitmask_bytes))))
					used_bits, extra_bits = whole_bits[:dimension**2], whole_bits[dimension**2:]
					assert all(b == '0' for b in extra_bits), 'out-of-range 1 bit for %s bitmask %d' % (mon_name, len(bitmasks))
					bitmask = tuple(tuple(b == '1' for b in row) for row in zip(*chunk(used_bits, dimension)))
					bitmasks.append(bitmask)
					bitmask_bytes = []
		assert not bitmask_bytes, 'leftover bitmask bytes for %s: %d' % (mon_name, len(bitmask_bytes))

	# Read frames' bitmask indexes and tile offsets from frames.asm

	frames = []
	with open(frames_name, 'r', encoding='utf8') as file:
		frame_labels = []
		context_label = None
		bitmask_index = None
		for line in file:
			if line.startswith('\tdw '):
				label = line[len('\tdw '):].strip()
				assert label.startswith('.'), 'nonlocal frame label for %s: %s' % (mon_name, label)
				frame_labels.append(label)
			elif line.startswith('.'):
				label = line.strip()
				assert label in frame_labels, 'nonexistent frame label for %s: %s' % (mon_name, label)
				context_label = frame_labels.index(label)
				bitmask_index = None
			elif line.startswith('\tdb '):
				assert context_label is not None, 'no context for frame db for %s: %s' % (mon_name, line)
				line = line[len('\tdb '):].split(';', 1)[0].strip()
				values = [int(v.strip().lstrip('$'), 16) for v in line.split(',')]
				if bitmask_index is None:
					assert len(values) == 1, 'excess data for frame bitmask for %s' % mon_name
					bitmask_index = values[0]
					assert 0 <= bitmask_index < len(bitmasks), 'invalid bitmask index for %s: $%02x' % (mon_name, bitmask_index)
					bitmask = bitmasks[bitmask_index]
					frames.append(Frame(bitmask, []))
				else:
					frames[-1].offsets.extend(values)

	# Verify frames' bitmasks against their tile offsets

	for frame_index, frame in enumerate(frames):
		on_bits = sum(row.count(True) for row in frame.bitmask)
		assert on_bits <= len(frame.offsets), 'too many bits for frame tiles: %s frame #%d' % (mon_name, frame_index+1)
		if on_bits < len(frame.offsets):
			print('*** %s frame #%d has %d extra tiles' % (mon_name, frame_index+1, len(frame.offsets) - on_bits))
		elif on_bits == 0:
			print('*** %s frame #%d is just the default frame' % (mon_name, frame_index+1))

	# Build offset maps for each frame

	offset_maps = [list(map(list, zip(*chunk(range(dimension**2), dimension))))]
	skip_offset = 0x7f - (7**2 - dimension**2)
	for frame in frames:
		offset_maps.append(deepcopy(offset_maps[0]))
		offset_index = 0
		for col in range(dimension):
			for row in range(dimension):
				if frame.bitmask[row][col]:
					offset = frame.offsets[offset_index]
					offset_index += 1
					offset_maps[-1][row][col] = offset - (offset > skip_offset)

	# Output film strip 2bpp

	filmstrip_name = 'gfx/pokemon/%s/front.w%d.2bpp' % (mon_name, dimension * 8)
	with open(filmstrip_name, 'wb') as file:
		for offset_map in offset_maps:
			for row in offset_map:
				for offset in row:
					file.write(tiles[offset])
