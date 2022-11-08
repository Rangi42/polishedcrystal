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

MACRO dbpixel
	if _NARG >= 4
		db \1 * 8 + \3, \2 * 8 + \4
	else
		db \1 * 8, \2 * 8
	endc
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
		endc
		def y <<= 1
	endr
	db x
ENDM

MACRO _try_def_ev
	if !_got_ev && STRRIN(STRUPR("\2"), " \1")
		redef _EV_VALUE EQUS STRSUB("\2", 1, STRRIN(STRUPR("\2"), " \1") - 1)
		def EV_\1 = {_EV_VALUE}
		def _got_ev = 1
	endc
ENDM

MACRO def_evs
; each arg: 0-3 Atk/Def/Spe/SAt/SDf
; based on showdown importable syntax
	def EV_HP  = 0
	def EV_ATK = 0
	def EV_DEF = 0
	def EV_SPE = 0
	def EV_SAT = 0
	def EV_SDF = 0
	rept _NARG
		def _got_ev = 0
		_try_def_ev HP, \1
		_try_def_ev ATK, \1
		_try_def_ev DEF, \1
		_try_def_ev SPE, \1
		_try_def_ev SAT, \1
		_try_def_ev SDF, \1
		if !_got_ev
			fail "invalid EV \1"
		endc
		shift
	endr
ENDM

MACRO ev_spread
	def_evs \#
	if !DEF(EV_SPREAD_AMOUNT)
		def EV_SPREAD_AMOUNT = 0
	endc
	if DEF(EV_SPREAD_{d:EV_HP}_{d:EV_ATK}_{d:EV_DEF}_{d:EV_SPE}_{d:EV_SAT}_{d:EV_SDF})
		db EV_SPREAD_{d:EV_HP}_{d:EV_ATK}_{d:EV_DEF}_{d:EV_SPE}_{d:EV_SAT}_{d:EV_SDF}
	else
		db EV_SPREAD_AMOUNT
		def EV_SPREAD_{d:EV_HP}_{d:EV_ATK}_{d:EV_DEF}_{d:EV_SPE}_{d:EV_SAT}_{d:EV_SDF} = EV_SPREAD_AMOUNT
		def EV_SPREAD_{d:EV_SPREAD_AMOUNT} EQUS "{EV_HP}, {EV_ATK}, {EV_DEF}, {EV_SPE}, {EV_SAT}, {EV_SDF}"
		def EV_SPREAD_AMOUNT = {d:EV_SPREAD_AMOUNT} + 1
	endc
	PRINT EV_SPREAD_AMOUNT
ENDM
