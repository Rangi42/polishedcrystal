; Macros to verify assumptions about the data or code

MACRO dbas
	db BANK(\1)
	dw \#
	for x, 1, _NARG
		for y, x + 1, _NARG + 1
			assert BANK(\<x>) == BANK(\<y>) || !BANK(\<x>) || !BANK(\<y>), \
				"\<x> and \<y> must be in the same bank"
		endr
	endr
ENDM

MACRO farbank
	REDEF CURRENT_FAR_BANK EQUS "\1"
ENDM

MACRO fardw
	rept _NARG
		dw \1
		assert BANK(\1) == BANK({CURRENT_FAR_BANK}) || !BANK(\1), \
			"\1 must be in the bank of {CURRENT_FAR_BANK}"
		shift
	endr
ENDM

MACRO _redef_current_label
	if DEF(\1)
		PURGE \1
	endc
	if _NARG == 3 + (\3)
		DEF \1 EQUS "\<_NARG>"
	elif DEF(..)
		if .. - @ == 0
			DEF \1 EQUS "{..}"
		endc
	elif DEF(.)
		if . - @ == 0
			DEF \1 EQUS "{.}"
		endc
	endc
	if !DEF(\1)
		DEF \1 EQUS \2
		{\1}:
	endc
ENDM

MACRO table_width
	def CURRENT_TABLE_WIDTH = \1
	_redef_current_label CURRENT_TABLE_START, "._table_width\@", 2, \#
ENDM

MACRO assert_table_length
	def x = \1
	assert x * CURRENT_TABLE_WIDTH == @ - {CURRENT_TABLE_START}, \
		"{CURRENT_TABLE_START}: expected {d:x} entries, each {d:CURRENT_TABLE_WIDTH} bytes"
ENDM

MACRO list_start
	def list_index = 0
	_redef_current_label CURRENT_LIST_START, "._list_start\@", 1, \#
ENDM

MACRO li
	assert STRFIND(\1, "@") == -1, "String terminator \"@\" in list entry: \1"
	db \1, "@"
	redef list_index += 1
ENDM

MACRO assert_list_length
	def x = \1
	assert x == list_index, \
		"{CURRENT_LIST_START}: expected {d:x} entries, got {d:list_index}"
ENDM

MACRO def_grass_wildmons
;\1: map id
	REDEF CURRENT_GRASS_WILDMONS_MAP EQUS "\1"
	REDEF CURRENT_GRASS_WILDMONS_LABEL EQUS "._def_grass_wildmons_\1"
{CURRENT_GRASS_WILDMONS_LABEL}:
	map_id \1
ENDM

MACRO end_grass_wildmons
	assert GRASS_WILDDATA_LENGTH == @ - {CURRENT_GRASS_WILDMONS_LABEL}, \
		"def_grass_wildmons {CURRENT_GRASS_WILDMONS_MAP}: expected {d:GRASS_WILDDATA_LENGTH} bytes"
ENDM

MACRO def_water_wildmons
;\1: map id
	REDEF CURRENT_WATER_WILDMONS_MAP EQUS "\1"
	REDEF CURRENT_WATER_WILDMONS_LABEL EQUS "._def_water_wildmons_\1"
{CURRENT_WATER_WILDMONS_LABEL}:
	map_id \1
ENDM

MACRO end_water_wildmons
	assert WATER_WILDDATA_LENGTH == @ - CURRENT_WATER_WILDMONS_LABEL, \
		"def_water_wildmons {CURRENT_WATER_WILDMONS_MAP}: expected {d:WATER_WILDDATA_LENGTH} bytes"
ENDM

MACRO wildmon
	db (\1)
	shift
	dp \#
ENDM

MACRO jmp
	jp \#
	if DEF(DEBUG)
		assert warn, (\<_NARG>) - @ > 127 || (\<_NARG>) - @ < -129, "jp can be jr"
	endc
ENDM
