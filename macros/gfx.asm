RGB: MACRO
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

palred   EQUS "(1 << 0) *"
palgreen EQUS "(1 << 5) *"
palblue  EQUS "(1 << 10) *"

palettes EQUS "* 8"
palette  EQUS "+ 8 *"

tiles EQUS "* LEN_2BPP_TILE"
tile  EQUS "+ LEN_2BPP_TILE *"
