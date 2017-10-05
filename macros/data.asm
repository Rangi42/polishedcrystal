dwb: MACRO
	dw \1
	db \2
	ENDM

dbw: MACRO
	db \1
	dw \2
	ENDM

dbbw: MACRO
	db \1, \2
	dw \3
	ENDM

dbww: MACRO
	db \1
	dw \2, \3
	ENDM

dbbwww: MACRO
	db \1, \2
	dw \3, \4, \5
	ENDM

dn: MACRO
	rept _NARG / 2
	db (\1) << 4 + (\2)
	shift
	shift
	endr
	ENDM

dx: MACRO
x = 8 * ((\1) - 1)
	rept \1
	db ((\2) >> x) & $ff
x = x + -8
	endr
	ENDM

dt: MACRO ; three-byte (big-endian)
	dx 3, \1
	ENDM

dd: MACRO ; four-byte (big-endian)
	dx 4, \1
	ENDM

bigdw: MACRO ; big-endian word
	dx 2, \1
	ENDM

dba: MACRO ; dbw bank, address
	rept _NARG
	dbw BANK(\1), \1
	shift
	endr
	ENDM

dab: MACRO ; dwb address, bank
	rept _NARG
	dwb \1, BANK(\1)
	shift
	endr
	ENDM


percent EQUS "* $ff / 100"

tiles EQUS "* $10"
tile EQUS "+ $10 *"

palettes EQUS "* 8"
palette EQUS "+ $8 *"


RGB: MACRO
	dw ((\3) << 10) + ((\2) << 5) + (\1)
	ENDM

palred EQUS "$0001 *"
palgreen EQUS "$0020 *"
palblue EQUS "$0400 *"


; pic animations
frame: MACRO
	db \1
x = \2
IF _NARG > 2
rept _NARG +- 2
x = x | (1 << (\3 + 1))
	shift
endr
endc
	db x
	ENDM
setrepeat: MACRO
	db $fe
	db \1
	ENDM
dorepeat: MACRO
	db $fd
	db \1
	ENDM
endanim: MACRO
	db $ff
	ENDM

delanim: MACRO
	db $fc
	ENDM
dorestart: MACRO
	db $fe
	ENDM


sine_wave: MACRO
; \1: amplitude

x = 0
	rept $20
	; Round up.
	dw (sin(x) + (sin(x) & $ff)) >> 8
x = x + (\1) * $40000
	endr
ENDM


bcd: MACRO
	rept _NARG
	dn ((\1) % 100) / 10, (\1) % 10
	shift
	endr
ENDM


dbpixel: MACRO
if _NARG >= 4
	db \1 * 8 + \3, \2 * 8 + \4
else
	db \1 * 8, \2 * 8
endc
endm


dsprite: MACRO
	db (\1 * 8) % $100 + \2, (\3 * 8) % $100 + \4, \5, \6
endm


genders: MACRO
; eight arguments, all MALE ($00) or FEMALE ($80)
; TODO: get bitfield genders to work
;x = 0
;rept 8
;x = x << 1
;x = x + (\1 >> 7)
;	shift
;endr
;	db x
rept 8
	db \1
	shift
endr
ENDM
