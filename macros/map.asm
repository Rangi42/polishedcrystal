map: MACRO
	db GROUP_\1, MAP_\1
ENDM

roam_map: MACRO
; A map and an arbitrary number of some more maps.

	map \1
	db  \2

	rept \2
	map \3
	shift
	endr

	db 0
ENDM

person_event: macro
PERSON_EVENT_NARG = _NARG
	db \1 ; sprite
	db \2 + 4 ; y
	db \3 + 4 ; x
	db \4 ; movement function
	dn \5, \6 ; radius: y, x
	db \7 ; clock_hour
	db \8 ; clock_daytime
	shift
	dn \8, \9 ; color, persontype
	shift
if \8 == PERSONTYPE_COMMAND
	db \9_command ; command id
else
	db \9 ; sight_range || cry id
endc
if PERSON_EVENT_NARG == 14
	shift
	db \9 ; itemball contents
	shift
	db \9 ; itemball quantity
else
	shift
	dw \9 ; pointer || byte, 0
endc
	shift
	dw \9 ; event flag
	endm

itemball_event: macro
	person_event SPRITE_BALL_CUT_FRUIT, \1, \2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEBALL, PLAYEREVENT_ITEMBALL, \3, \4, \5
endm

tmhmball_event: macro
	person_event SPRITE_BALL_CUT_FRUIT, \1, \2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_POKEBALL, PLAYEREVENT_TMHMBALL, \3, \4
endm

cuttree_event: macro
	person_event SPRITE_BALL_CUT_FRUIT, \1, \2, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, cuttree, \3
endm

fruittree_event: macro
if _NARG == 4
	person_event SPRITE_BALL_CUT_FRUIT, \1, \2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, fruittree, \3, \4, -1
else
	person_event SPRITE_BALL_CUT_FRUIT, \1, \2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, fruittree, \3, \4, \5
endc
endm

strengthboulder_event: macro
if _NARG == 2
	person_event SPRITE_BOULDER_ROCK_FOSSIL, \1, \2, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, strengthboulder, -1
else
	person_event SPRITE_BOULDER_ROCK_FOSSIL, \1, \2, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, strengthboulder, \3
endc
endm

smashrock_event: macro
if _NARG == 2
	person_event SPRITE_BOULDER_ROCK_FOSSIL, \1, \2, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, smashrock, 0, -1
else
	person_event SPRITE_BOULDER_ROCK_FOSSIL, \1, \2, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, smashrock, 0, \3
endc
endm

pc_nurse_event: macro
	person_event SPRITE_BOWING_NURSE, \1, \2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, pokecenternurse, -1
endm

mart_clerk_event: macro
	person_event SPRITE_CLERK, \1, \2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, pokemart, \3, \4, -1
endm

signpost: macro
	db \1 ; y
	db \2 ; x
	db \3 ; function
if \3 == SIGNPOST_JUMPSTD
if _NARG == 5
	db \4, \5 ; stdscript
else
	db \4, 0 ; stdscript
endc
else
	dw \4 ; pointer
endc
	endm

xy_trigger: macro
	db \1 ; number
	db \2 ; y
	db \3 ; x
	dw \4 ; script
	endm

warp_def: macro
	db \1 ; y
	db \2 ; x
	db \3 ; warp_to
	map \4 ; map
	endm


map_header: MACRO
	; label, tileset, permission, location, music, phone service flag, time of day, fishing group
\1_MapHeader:
	db BANK(\1_SecondMapHeader), \2, \3
	dw \1_SecondMapHeader
	db \4, \5
	dn \6, \7
	db \8
ENDM


map_header_2: MACRO
; label, map, border block, connections
CURRENT_MAP_WIDTH = \2_WIDTH
CURRENT_MAP_HEIGHT = \2_HEIGHT
\1_SecondMapHeader::
	db \3
	db \2_HEIGHT, \2_WIDTH
	db BANK(\1_BlockData)
	dw \1_BlockData
	db BANK(\1_MapScriptHeader)
	dw \1_MapScriptHeader
	dw \1_MapEventHeader
	db \4
ENDM

connection: MACRO
if "\1" == "north"
;\2: map id
;\3: map label (eventually will be rolled into map id)
;\4: x
;\5: offset?
;\6: strip length
	map \2
	dw \3_BlockData + \2_WIDTH * (\2_HEIGHT - 3) + \5
	dw OverworldMap + \4 + 3
	db \6
	db \2_WIDTH
	db \2_HEIGHT * 2 - 1
	db (\4 - \5) * -2
	dw OverworldMap + \2_HEIGHT * (\2_WIDTH + 6) + 1
endc

if "\1" == "south"
;\2: map id
;\3: map label (eventually will be rolled into map id)
;\4: x
;\5: offset?
;\6: strip length
	map \2
	dw \3_BlockData + \5
	dw OverworldMap + (CURRENT_MAP_HEIGHT + 3) * (CURRENT_MAP_WIDTH + 6) + \4 + 3
	db \6
	db \2_WIDTH
	db 0
	db (\4 - \5) * -2
	dw OverworldMap + \2_WIDTH + 7
endc

if "\1" == "west"
;\2: map id
;\3: map label (eventually will be rolled into map id)
;\4: y
;\5: offset?
;\6: strip length
	map \2
	dw \3_BlockData + (\2_WIDTH * \5) + \2_WIDTH - 3
	dw OverworldMap + (CURRENT_MAP_WIDTH + 6) * (\4 + 3)
	db \6
	db \2_WIDTH
	db (\4 - \5) * -2
	db \2_WIDTH * 2 - 1
	dw OverworldMap + \2_WIDTH * 2 + 6
endc

if "\1" == "east"
;\2: map id
;\3: map label (eventually will be rolled into map id)
;\4: y
;\5: offset?
;\6: strip length
	map \2
	dw \3_BlockData + (\2_WIDTH * \5)
	dw OverworldMap + (CURRENT_MAP_WIDTH + 6) * (\4 + 3 + 1) - 3
	db \6
	db \2_WIDTH
	db (\4 - \5) * -2
	db 0
	dw OverworldMap + \2_WIDTH + 7
endc

ENDM

mapgroup: MACRO
GROUP_\1 EQU const_value
	enum MAP_\1
\1_HEIGHT EQU \2
\1_WIDTH EQU \3
ENDM

newgroup: MACRO
const_value = const_value + 1
	enum_start 1
ENDM

elevfloor: MACRO
	db \1, \2
	map \3
ENDM

itemball: MACRO
if _NARG == 2
	db \1, \2
else
	db \1, 1
endc
endm

tmhmball: MACRO
	db \1
endm

stonetable: MACRO
	db \1, \2
	dw \3
endm
