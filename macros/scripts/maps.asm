map: MACRO
	db GROUP_\1, MAP_\1
ENDM


warp_def: macro
	db \1 ; y
	db \2 ; x
	db \3 ; warp_to
	map \4 ; map
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


trainer: MACRO
	; flag, group, id, seen text, win text, lost text, talk-again text
	dw \1
	db \2, \3
	dw \4, \5, \6, \7
ENDM

generictrainer: MACRO
	; flag, group, id, seen text, win text
	dw \1
	db \2, \3
	dw \4, \5
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

elevfloor: MACRO
	db \1, \2
	map \3
ENDM

stonetable: MACRO
	db \1, \2
	dw \3
endm
