map_id: MACRO
	db GROUP_\1, MAP_\1
ENDM


scene_script: MACRO
	dw \1 ; script
ENDM

callback: MACRO
	db \1 ; type
	dw \2 ; script
ENDM

warp_event: MACRO
	db \2 ; y
	db \1 ; x
	db \4 ; warp_to
	map_id \3 ; map
ENDM

coord_event: MACRO
	db \3 ; scene_id
	db \2 ; y
	db \1 ; x
	dw \4 ; script
ENDM

bg_event: MACRO
	db \2 ; y
	db \1 ; x
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
ENDM

object_event: MACRO
PERSON_EVENT_NARG = _NARG
	db \3 ; sprite
	db \2 + 4 ; y
	db \1 + 4 ; x
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
ENDM

itemball_event: MACRO
	object_event \1, \2, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEBALL, PLAYEREVENT_ITEMBALL, \3, \4, \5
ENDM

tmhmball_event: MACRO
	object_event \1, \2, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_POKEBALL, PLAYEREVENT_TMHMBALL, \3, \4
ENDM

cuttree_event: MACRO
	object_event \1, \2, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, cuttree, \3
ENDM

fruittree_event: MACRO
if _NARG == 4
	object_event \1, \2, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, fruittree, \3, \4, -1
else
	object_event \1, \2, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, fruittree, \3, \4, \5
endc
ENDM

strengthboulder_event: MACRO
if _NARG == 2
	object_event \1, \2, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, strengthboulder, -1
else
	object_event \1, \2, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, strengthboulder, \3
endc
ENDM

smashrock_event: MACRO
if _NARG == 2
	object_event \1, \2, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, smashrock, 0, -1
else
	object_event \1, \2, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, smashrock, 0, \3
endc
ENDM

pc_nurse_event: MACRO
	object_event \1, \2, SPRITE_BOWING_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, pokecenternurse, -1
ENDM

mart_clerk_event: MACRO
	object_event \1, \2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, pokemart, \3, \4, -1
ENDM


trainer: MACRO
	; flag, group, id, seen text, win text, lost text, talk-again text
	dw \3
	db \1, \2
	dw \4, \5, \6, \7
ENDM

generictrainer: MACRO
	; flag, group, id, seen text, win text
	dw \3
	db \1, \2
	dw \4, \5
ENDM


elevfloor: MACRO
	db \1, \2
	map_id \3
ENDM

stonetable: MACRO
	db \1, \2
	dw \3
ENDM
