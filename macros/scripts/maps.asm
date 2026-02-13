MACRO map_id
	db GROUP_\1, MAP_\1
ENDM

DEF object_const_def EQUS "const_def 1"

MACRO def_scene_scripts
	REDEF _NUM_SCENE_SCRIPTS EQUS "_NUM_SCENE_SCRIPTS_\@"
	db {_NUM_SCENE_SCRIPTS}
	const_def
	def {_NUM_SCENE_SCRIPTS} = 0
ENDM

MACRO scene_const
;\1: scene id constant
	const \1
	EXPORT \1
ENDM

MACRO scene_script
;\1: script pointer
;\2: scene id constant
	dw \1
	if _NARG == 2
		scene_const \2
	else
		const_skip
	endc
	redef {_NUM_SCENE_SCRIPTS} += 1
ENDM

MACRO def_callbacks
	REDEF _NUM_CALLBACKS EQUS "_NUM_CALLBACKS_\@"
	db {_NUM_CALLBACKS}
	def {_NUM_CALLBACKS} = 0
ENDM

MACRO callback
	db \1 ; type
	dw \2 ; script
	redef {_NUM_CALLBACKS} += 1
ENDM

MACRO def_warp_events
	REDEF _NUM_WARP_EVENTS EQUS "_NUM_WARP_EVENTS_\@"
	db {_NUM_WARP_EVENTS}
	def {_NUM_WARP_EVENTS} = 0
ENDM

MACRO warp_event
	db \2 ; y
	db \1 ; x
	db \4 ; warp_to
	map_id \3 ; map
	redef {_NUM_WARP_EVENTS} += 1
ENDM

MACRO def_coord_events
	REDEF _NUM_COORD_EVENTS EQUS "_NUM_COORD_EVENTS_\@"
	db {_NUM_COORD_EVENTS}
	def {_NUM_COORD_EVENTS} = 0
ENDM

MACRO coord_event
	db \3 ; scene_id
	db \2 ; y
	db \1 ; x
	dw \4 ; script
	redef {_NUM_COORD_EVENTS} += 1
ENDM

MACRO def_bg_events
	REDEF _NUM_BG_EVENTS EQUS "_NUM_BG_EVENTS_\@"
	db {_NUM_BG_EVENTS}
	def {_NUM_BG_EVENTS} = 0
ENDM

MACRO bg_event
	db \2 ; y
	db \1 ; x
	db \3 ; function
	if \3 == BGEVENT_JUMPSTD
		if _NARG == 5
			db \4, \5 ; stdscript
		else
			db \4, 0 ; stdscript
		endc
	else
		dw \4 ; pointer
	endc
	redef {_NUM_BG_EVENTS} += 1
ENDM

MACRO def_object_events
	REDEF _NUM_OBJECT_EVENTS EQUS "_NUM_OBJECT_EVENTS_\@"
	if !_NARG
		db {_NUM_OBJECT_EVENTS}
	endc
	def {_NUM_OBJECT_EVENTS} = 0
ENDM

MACRO object_event
	db \3 ; sprite
	db \2 + 4 ; y
	db \1 + 4 ; x
	db \4 ; movement function
	if \3 == SPRITE_MON_ICON
		dn \5, LOW(\6) ; mon index
	else
		dn \5, \6 ; radius: y, x
	endc
	db \8 ; palette
	db \7 ; time of day
	db \9 ; type
	if \9 == OBJECTTYPE_COMMAND
		db \<10>_command ; command id
	elif \3 == SPRITE_MON_ICON
		db (HIGH(\6) << MON_EXTSPECIES_F) | \<10> ; extspecies | form
	else
		db \<10> ; sight_range
	endc
	if _NARG == 13
		db \<11> ; itemball contents
		db \<12> ; itemball quantity
		dw \<13> ; event flag
	else
		dw \<11> ; pointer || byte, 0
		dw \<12> ; event flag
	endc
	redef {_NUM_OBJECT_EVENTS} += 1
ENDM

MACRO itemball_event
	object_event \1, \2, SPRITE_BALL_CUT_TREE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_POKE_BALL, OBJECTTYPE_ITEMBALL, PLAYEREVENT_ITEMBALL, \3, \4, \5
ENDM

MACRO keyitemball_event
	assert _NARG == 4, "No quantity needed for keyitemball_event"
	object_event \1, \2, SPRITE_BALL_CUT_TREE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_KEY_ITEM, OBJECTTYPE_ITEMBALL, PLAYEREVENT_KEYITEMBALL, \3, \4
ENDM

MACRO tmhmball_event
	assert _NARG == 4, "No quantity needed for tmhmball_event"
	object_event \1, \2, SPRITE_BALL_CUT_TREE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_YELLOW, OBJECTTYPE_ITEMBALL, PLAYEREVENT_TMHMBALL, \3, \4
ENDM

MACRO cuttree_event
	object_event \1, \2, SPRITE_BALL_CUT_TREE, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumpstd, cuttree, \3
ENDM

MACRO fruittree_event
	if _NARG == 5
		object_event \1, \2, SPRITE_BLANK_FRUIT, SPRITEMOVEDATA_FRUIT, 0, \3 - 1, -1, \5, OBJECTTYPE_COMMAND, fruittree, \3, \4, -1
	else
		object_event \1, \2, SPRITE_BLANK_FRUIT, SPRITEMOVEDATA_FRUIT, 0, \3 - 1, (1 << \6), \5, OBJECTTYPE_COMMAND, fruittree, \3, \4, \7
	endc
ENDM

MACRO strengthboulder_event
	if _NARG == 2
		object_event \1, \2, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumpstd, strengthboulder, -1
	else
		object_event \1, \2, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumpstd, strengthboulder, \3
	endc
ENDM

MACRO smashrock_event
	if _NARG == 2
		object_event \1, \2, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumpstd, smashrock, 0, -1
	else
		object_event \1, \2, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumpstd, smashrock, 0, \3
	endc
ENDM

MACRO pokemon_event
	if _NARG == 8
		object_event \1, \2, SPRITE_MON_ICON, \4, 0, \3, \5, \6, OBJECTTYPE_POKEMON, NO_FORM, \7, \8
	else
		object_event \1, \2, SPRITE_MON_ICON, \5, 0, \3, \6, \7, OBJECTTYPE_POKEMON, \4, \8, \9
	endc
ENDM

MACRO pc_nurse_event
	object_event \1, \2, SPRITE_BOWING_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumpstd, pokecenternurse, -1
ENDM

MACRO mart_clerk_event
	object_event \1, \2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, pokemart, \3, \4, -1
ENDM


MACRO trainer
	; flag, group, id, seen text, win text, lost text, after script
	dw \3
	db \1, \2
	dw \4, \5, \6, \7
	if _NARG == 8
		db \8
	else
		db 0
	endc
ENDM

MACRO generictrainer
	; flag, group, id, seen text, win text
	dw \3
	db \1, \2
	dw \4, \5
ENDM


MACRO elevfloor
	db \1, \2
	map_id \3
ENDM

MACRO stonetable
	db \1, \2
	dw \3
ENDM

; Connections go in order: north, south, west, east
MACRO connection
;\1: direction
;\2: map name
;\3: map id
;\4: offset of the target map relative to the current map
;    (x offset for east/west, y offset for north/south)

; Calculate tile offsets for source (current) and target maps
	DEF _src = 0
	DEF _tgt = (\4) + 3
	if _tgt < 0
		DEF _src = -_tgt
		DEF _tgt = 0
	endc

	if "\1" === "north"
		DEF _blk = \3_WIDTH * (\3_HEIGHT - 3) + _src
		DEF _map = _tgt
		DEF _win = (\3_WIDTH + 6) * \3_HEIGHT + 1
		DEF _y = \3_HEIGHT * 2 - 1
		DEF _x = (\4) * -2
		DEF _len = CURRENT_MAP_WIDTH + 3 - (\4)
		if _len > \3_WIDTH
			DEF _len = \3_WIDTH
		endc

	elif "\1" === "south"
		DEF _blk = _src
		DEF _map = (CURRENT_MAP_WIDTH + 6) * (CURRENT_MAP_HEIGHT + 3) + _tgt
		DEF _win = \3_WIDTH + 7
		DEF _y = 0
		DEF _x = (\4) * -2
		DEF _len = CURRENT_MAP_WIDTH + 3 - (\4)
		if _len > \3_WIDTH
			DEF _len = \3_WIDTH
		endc

	elif "\1" === "west"
		DEF _blk = (\3_WIDTH * _src) + \3_WIDTH - 3
		DEF _map = (CURRENT_MAP_WIDTH + 6) * _tgt
		DEF _win = (\3_WIDTH + 6) * 2 - 6
		DEF _y = (\4) * -2
		DEF _x = \3_WIDTH * 2 - 1
		DEF _len = CURRENT_MAP_HEIGHT + 3 - (\4)
		if _len > \3_HEIGHT
			DEF _len = \3_HEIGHT
		endc

	elif "\1" === "east"
		DEF _blk = (\3_WIDTH * _src)
		DEF _map = (CURRENT_MAP_WIDTH + 6) * _tgt + CURRENT_MAP_WIDTH + 3
		DEF _win = \3_WIDTH + 7
		DEF _y = (\4) * -2
		DEF _x = 0
		DEF _len = CURRENT_MAP_HEIGHT + 3 - (\4)
		if _len > \3_HEIGHT
			DEF _len = \3_HEIGHT
		endc

	else
		fail "Invalid direction for 'connection'."
	endc

	map_id \3
	dw wDecompressScratch + _blk
	dw wOverworldMapBlocks + _map
	db _len - _src
	db \3_WIDTH
	db _y, _x
	dw wOverworldMapBlocks + _win
ENDM
