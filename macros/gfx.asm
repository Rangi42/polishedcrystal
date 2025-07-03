MACRO RGB
	rept _NARG / 3
		if DEF(NOIR) && !DEF(LITERAL_NOIR_RGB_COLORS)
			def x = (299 * \1 + 587 * \2 + 114 * \3) / 1000
			dw palred x + palgreen x + palblue x
		else
			dw palred (\1) + palgreen (\2) + palblue (\3)
		endc
		shift 3
	endr
ENDM

DEF palred   EQUS "(1 << B_COLOR_RED) *"
DEF palgreen EQUS "(1 << B_COLOR_GREEN) *"
DEF palblue  EQUS "(1 << B_COLOR_BLUE) *"

DEF palettes EQUS "* 8"
DEF palette  EQUS "+ 8 *"
DEF color    EQUS "+ COLOR_SIZE *"
DEF colors   EQUS "* COLOR_SIZE"

DEF tiles EQUS "* TILE_SIZE"
DEF tile  EQUS "+ TILE_SIZE *"
