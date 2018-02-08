PaintingPalettes:

if !DEF(MONOCHROME)
HoOhPaintingPalette:      INCLUDE "gfx/paintings/ho_oh_painting.pal"
LugiaPaintingPalette:     INCLUDE "gfx/paintings/lugia_painting.pal"
BellTowerPaintingPalette: INCLUDE "gfx/paintings/bell_tower_painting.pal"
else
rept NUM_PAINTINGS
	MONOCHROME_RGB_FOUR
endr
endc
