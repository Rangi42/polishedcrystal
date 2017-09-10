define: macro
if !def(\1)
\1 equs \2
endc
endm

ev_yield: MACRO
	db (\1 << 6) | (\2 << 4) | (\3 << 2) | \4
	db (\5 << 6) | (\6 << 4)
ENDM

const_value = 0

add_tm: MACRO
if !def(TM01)
TM01 = const_value
	enum_start 1
endc
	define _\@_1, "TM_\1"
	const _\@_1
	enum \1_TMNUM
ENDM

add_hm: MACRO
if !def(HM01)
HM01 = const_value
endc
	define _\@_1, "HM_\1"
	const _\@_1
	enum \1_TMNUM
ENDM

add_mt: MACRO
	enum \1_TMNUM
ENDM

tmhm: MACRO
tms1_24 = 0
tms25_48 = 0
tms49_72 = 0
tms73_96 = 0
tms97_112 = 0
	rept _NARG
	if def(\1_TMNUM)
	if \1_TMNUM < 25
tms1_24 = tms1_24 | (1 << ((\1_TMNUM) - 1))
	else
	if \1_TMNUM < 49
tms25_48 = tms25_48 | (1 << ((\1_TMNUM) - 1 - 24))
	else
	if \1_TMNUM < 73
tms49_72 = tms49_72 | (1 << ((\1_TMNUM) - 1 - 48))
	else
	if \1_TMNUM < 97
tms73_96 = tms73_96 | (1 << ((\1_TMNUM) - 1 - 72))
	else
	if \1_TMNUM < 113
tms97_112 = tms97_112 | (1 << ((\1_TMNUM) - 1 - 96))
	else
		fail "\1 overflows base data"
	endc
	endc
	endc
	endc
	endc
	else
		fail "\1 is not a TM, HM, or move tutor move"
	endc
	shift
	endr

	rept 3
	db tms1_24 & $ff
tms1_24 = tms1_24 >> 8
	endr
	rept 3
	db tms25_48 & $ff
tms25_48 = tms25_48 >> 8
	endr
	rept 3
	db tms49_72 & $ff
tms49_72 = tms49_72 >> 8
	endr
	rept 3
	db tms73_96 & $ff
tms73_96 = tms73_96 >> 8
	endr
	rept 2
	db tms97_112 & $ff
tms97_112 = tms97_112 >> 8
	endr
ENDM
