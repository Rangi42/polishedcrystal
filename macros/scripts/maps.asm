map_id: MACRO
	db GROUP_\1, MAP_\1
ENDM

object_const_def EQUS "const_def 1"

def_scene_scripts: MACRO
	REDEF _NUM_SCENE_SCRIPTS EQUS "_NUM_SCENE_SCRIPTS_\@"
	db {_NUM_SCENE_SCRIPTS}
	def {_NUM_SCENE_SCRIPTS} = 0
ENDM

scene_script: MACRO
	dw \1 ; script
	redef {_NUM_SCENE_SCRIPTS} = {_NUM_SCENE_SCRIPTS} + 1
ENDM

def_callbacks: MACRO
	REDEF _NUM_CALLBACKS EQUS "_NUM_CALLBACKS_\@"
	db {_NUM_CALLBACKS}
	def {_NUM_CALLBACKS} = 0
ENDM

callback: MACRO
	db \1 ; type
	dw \2 ; script
	def {_NUM_CALLBACKS} = {_NUM_CALLBACKS} + 1
ENDM

def_warp_events: MACRO
	REDEF _NUM_WARP_EVENTS EQUS "_NUM_WARP_EVENTS_\@"
	db {_NUM_WARP_EVENTS}
	def {_NUM_WARP_EVENTS} = 0
ENDM

warp_event: MACRO
	db \2 ; y
	db \1 ; x
	db \4 ; warp_to
	map_id \3 ; map
	redef {_NUM_WARP_EVENTS} = {_NUM_WARP_EVENTS} + 1
ENDM

def_coord_events: MACRO
	REDEF _NUM_COORD_EVENTS EQUS "_NUM_COORD_EVENTS_\@"
	db {_NUM_COORD_EVENTS}
	def {_NUM_COORD_EVENTS} = 0
ENDM

coord_event: MACRO
	db \3 ; scene_id
	db \2 ; y
	db \1 ; x
	dw \4 ; script
	redef {_NUM_COORD_EVENTS} = {_NUM_COORD_EVENTS} + 1
ENDM

def_bg_events: MACRO
	REDEF _NUM_BG_EVENTS EQUS "_NUM_BG_EVENTS_\@"
	db {_NUM_BG_EVENTS}
	def {_NUM_BG_EVENTS} = 0
ENDM

bg_event: MACRO
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
	redef {_NUM_BG_EVENTS} = {_NUM_BG_EVENTS} + 1
ENDM

def_object_events: MACRO
	REDEF _NUM_OBJECT_EVENTS EQUS "_NUM_OBJECT_EVENTS_\@"
	if !_NARG
		db {_NUM_OBJECT_EVENTS}
	endc
	def {_NUM_OBJECT_EVENTS} = 0
ENDM

object_event: MACRO
	db \3 ; sprite
	db \2 + 4 ; y
	db \1 + 4 ; x
	db \4 ; movement function
	dn \5, \6 ; radius: y, x
	db \7 ; clock_hour
	db \8 ; clock_daytime
	dn \9, \<10> ; color, persontype
	if \<10> == OBJECTTYPE_COMMAND
		db \<11>_command ; command id
	else
		db \<11> ; sight_range || cry id
	endc
	if _NARG == 14
		db \<12> ; itemball contents
		db \<13> ; itemball quantity
		dw \<14> ; event flag
	else
		dw \<12> ; pointer || byte, 0
		dw \<13> ; event flag
	endc
	redef {_NUM_OBJECT_EVENTS} = {_NUM_OBJECT_EVENTS} + 1
ENDM

itemball_event: MACRO
	object_event \1, \2, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_ITEMBALL, PLAYEREVENT_ITEMBALL, \3, \4, \5
ENDM

keyitemball_event: MACRO
	object_event \1, \2, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_ITEMBALL, PLAYEREVENT_KEYITEMBALL, \3, \4
ENDM

tmhmball_event: MACRO
	object_event \1, \2, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_ITEMBALL, PLAYEREVENT_TMHMBALL, \3, \4
ENDM

cuttree_event: MACRO
	object_event \1, \2, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumpstd, cuttree, \3
ENDM

fruittree_event: MACRO
	if _NARG == 5
		object_event \1, \2, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_FRUIT, 0, \3 - 1, -1, -1, \5, OBJECTTYPE_COMMAND, fruittree, \3, \4, -1
	else
		object_event \1, \2, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_FRUIT, 0, \3 - 1, -1, -1, \5, OBJECTTYPE_COMMAND, fruittree, \3, \4, \6
	endc
ENDM

strengthboulder_event: MACRO
	if _NARG == 2
		object_event \1, \2, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumpstd, strengthboulder, -1
	else
		object_event \1, \2, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumpstd, strengthboulder, \3
	endc
ENDM

smashrock_event: MACRO
	if _NARG == 2
		object_event \1, \2, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumpstd, smashrock, 0, -1
	else
		object_event \1, \2, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumpstd, smashrock, 0, \3
	endc
ENDM

pokemon_event: MACRO
	object_event \1, \2, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, \3, \4, \5, \6, OBJECTTYPE_POKEMON, \3, \7, \8
ENDM

pc_nurse_event: MACRO
	object_event \1, \2, SPRITE_BOWING_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumpstd, pokecenternurse, -1
ENDM

mart_clerk_event: MACRO
	object_event \1, \2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, pokemart, \3, \4, -1
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
