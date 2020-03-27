VariantPalettesTable:
	dbbw GYARADOS, GYARADOS_RED_FORM, RedGyaradosPalette
	db -1

RedGyaradosPalette:
if DEF(MONOCHROME)
	MONOCHROME_RGB_TWO
	MONOCHROME_RGB_TWO
elif DEF(HGSS)
INCLUDE "gfx/pokemon/gyarados_red/hgss/normal.pal"
INCLUDE "gfx/pokemon/gyarados_red/hgss/shiny.pal"
else
INCLUDE "gfx/pokemon/gyarados_red/normal.pal"
INCLUDE "gfx/pokemon/gyarados_red/shiny.pal"
endc

MewtwoArmoredPalette:
if DEF(MONOCHROME)
	MONOCHROME_RGB_TWO
elif DEF(HGSS)
INCLUDE "gfx/pokemon/mewtwo_armored/hgss/normal.pal"
else
INCLUDE "gfx/pokemon/mewtwo_armored/normal.pal"
endc
