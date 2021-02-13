; Value macros

percent EQUS "* $ff / 100"


; Constant data (db, dw, dl) macros

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

dbbbw: MACRO
	db \1, \2, \3
	dw \4
ENDM

dbww: MACRO
	db \1
	dw \2, \3
ENDM

dbbww: MACRO
	db \1, \2
	dw \3, \4
ENDM

dbbwww: MACRO
	db \1, \2
	dw \3, \4, \5
ENDM

dn: MACRO
rept _NARG / 2
	db (\1) << 4 + (\2)
	shift 2
endr
ENDM

dx: MACRO
x = 8 * ((\1) - 1)
	rept \1
	db LOW((\2) >> x)
x = x - 8
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

dbba: MACRO
	db \1
	dba \2
ENDM

dbbba: MACRO
	db \1, \2
	dba \3
ENDM

dbpixel: MACRO
if _NARG >= 4
	db \1 * 8 + \3, \2 * 8 + \4
else
	db \1 * 8, \2 * 8
endc
ENDM

dsprite: MACRO
	db LOW(\1 * 8) + \2, LOW(\3 * 8) + \4, \5, \6
ENDM

bcd: MACRO
rept _NARG
	dn ((\1) % 100) / 10, (\1) % 10
	shift
endr
ENDM

dp: MACRO ; db species, extspecies | form
if _NARG == 2
	db LOW(\1), HIGH(\1) << MON_EXTSPECIES_F | \2
else
	db LOW(\1), HIGH(\1) << MON_EXTSPECIES_F
endc
ENDM

dbp: MACRO
	db \1
if _NARG == 3
	dp \2, \3
else
	dp \2
endc
ENDM

dpb: MACRO
if _NARG == 3
	dp \1, \2
	shift
else
	dp \1
endc
	db \2
ENDM

dpw: MACRO
if _NARG == 3
	dp \1, \2
	shift
else
	dp \1
endc
	dw \2
ENDM


genders: MACRO
; eight arguments, all MALE or FEMALE
x = 0
y = 1
rept _NARG
	if !STRCMP("\1", "FEMALE")
x = x | y
	endc
y = y * 2
	shift
endr
	db x
ENDM
