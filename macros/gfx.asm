RGB: MACRO
rept _NARG / 3
if DEF(NOIR)
x = (299 * \1 + 587 * \2 + 114 * \3) / 1000
	dw palred x + palgreen x + palblue x
else
	dw palred (\1) + palgreen (\2) + palblue (\3)
endc
	shift
	shift
	shift
endr
ENDM

palred   EQUS "(1 << 0) *"
palgreen EQUS "(1 << 5) *"
palblue  EQUS "(1 << 10) *"

palettes EQUS "* 8"
palette  EQUS "+ 8 *"

tiles EQUS "* $10"
tile  EQUS "+ $10 *"
