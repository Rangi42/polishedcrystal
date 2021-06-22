PaintingPalettes:
	table_width PALETTE_SIZE, PaintingPalettes

if !DEF(MONOCHROME)
HoOhPaintingPalette:      INCLUDE "gfx/paintings/ho_oh_painting.pal"
LugiaPaintingPalette:     INCLUDE "gfx/paintings/lugia_painting.pal"
BellTowerPaintingPalette: INCLUDE "gfx/paintings/bell_tower_painting.pal"
KabutoPuzzlePalette:      INCLUDE "gfx/paintings/kabuto_puzzle.pal"
OmanytePuzzlePalette:     INCLUDE "gfx/paintings/omanyte_puzzle.pal"
AerodactylPuzzlePalette:  INCLUDE "gfx/paintings/aerodactyl_puzzle.pal"
HoOhPuzzlePalette:        INCLUDE "gfx/paintings/ho_oh_puzzle.pal"
else
rept NUM_PAINTINGS
	MONOCHROME_RGB_FOUR
endr
endc

	assert_table_length NUM_PAINTINGS
