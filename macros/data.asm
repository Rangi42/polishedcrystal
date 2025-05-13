; Value macros

DEF percent EQUS "* $ff / 100"


; Constant data (db, dw, dl) macros

MACRO dwb
	dw \1
	db \2
ENDM

MACRO dbw
	db \1
	dw \2
ENDM

MACRO dn ; "nybbles"
	rept _NARG / 2
		db (\1) << 4 + (\2)
		shift 2
	endr
ENDM

MACRO dc ; "crumbs"
	rept _NARG / 4
		db ((\1) << 6) | ((\2) << 4) | ((\3) << 2) | (\4)
		shift 4
	endr
ENDM

MACRO dx ; x-byte (big-endian)
	for x, 8 * ((\1) - 1), -1, -8
		db LOW((\2) >> x)
	endr
ENDM

MACRO dt ; three-byte (big-endian)
	dx 3, \1
ENDM

MACRO dd ; four-byte (big-endian)
	dx 4, \1
ENDM

MACRO bigdw ; big-endian word
	dx 2, \1
ENDM

MACRO dba ; dbw bank, address
	for i, 1, _NARG + 1
		dbw BANK(\<i>), \<i>
	endr
ENDM

MACRO dab ; dwb address, bank
	for i, 1, _NARG + 1
		dwb \<i>, BANK(\<i>)
	endr
ENDM

MACRO dr ; relative offset
	db \1 - @
ENDM

MACRO dbpixel
	if _NARG >= 4
		db \1 * 8 + \3, \2 * 8 + \4
	else
		db \1 * 8, \2 * 8
	endc
ENDM

MACRO dbsprite
; x tile, y tile, x pixel, y pixel, vtile offset, attributes
	db (\2 * TILE_WIDTH) % $100 + \4, (\1 * TILE_WIDTH) % $100 + \3, \5, \6
ENDM

MACRO dsprite
	db LOW(\1 * 8) + \2, LOW(\3 * 8) + \4, \5, \6
ENDM

MACRO bcd
	for i, 1, _NARG + 1
		dn ((\<i>) % 100) / 10, (\<i>) % 10
	endr
ENDM

MACRO dp ; db species, extspecies | form
	if _NARG == 2
		db LOW(\1), HIGH(\1) << MON_EXTSPECIES_F | \2
	else
		db LOW(\1), HIGH(\1) << MON_EXTSPECIES_F
	endc
ENDM

MACRO genders
; eight arguments, all MALE or FEMALE
	def x = 0
	def y = 1
	for i, 1, _NARG + 1
		if !STRCMP("\<i>", "FEMALE")
			def x |= y
		else
			static_assert !STRCMP("\<i>", "MALE")
		endc
		def y <<= 1
	endr
	db x
ENDM

MACRO with_each
	for _with_each_i, 1, _NARG
		redef _with_each_str EQUS STRRPL(\<_NARG>, "?", "\<_with_each_i>")
		{_with_each_str}
	endr
ENDM

; _all is used in macros when we want to allow "All" to cover all 6 stats.
DEF with_each_stat EQUS "with_each HP, ATK, DEF, SPE, SAT, SDF,"
DEF with_each_stat_all EQUS "with_each ALL, HP, ATK, DEF, SPE, SAT, SDF,"

MACRO def_dvs
; each arg: 0-15 All/HP/Atk/Def/Spe/SAt/SDf (All sets all 6 stats).
; based on showdown importable syntax
	with_each_stat "def EV_? = 15"
	def EV_ALL = 0
	def_dvs_or_evs \#
ENDM

MACRO def_evs
; each arg: 0-252 All/HP/Atk/Def/Spe/SAt/SDf (All sets all 6 stats).
; based on showdown importable syntax
	with_each_stat_all "def EV_? = 0"
	def_dvs_or_evs \#
ENDM

MACRO def_dvs_or_evs
	def EV_TOTAL = 0
	rept _NARG
		def _got_ev = 0
		with_each_stat_all """
			def x = STRRFIND(STRUPR("\1"), " ?")
			if !_got_ev && x != -1
				redef _EV_VALUE EQUS STRSLICE("\1", 0, x)
				def EV_? = \{_EV_VALUE}
				def EV_TOTAL += EV_?
				def _got_ev = 1
			endc
			"""
		if !_got_ev
			fail "invalid EV \1"
		endc
		if EV_ALL != 0
			def EV_TOTAL = EV_ALL
			with_each_stat "def EV_? = {EV_TOTAL}"
			def EV_TOTAL *= 6
		endc
		shift
	endr
	if EV_TOTAL > MODERN_EV_LIMIT
		warn "too many EVs: {d:EV_TOTAL} > {d:MODERN_EV_LIMIT}"
	endc
ENDM
