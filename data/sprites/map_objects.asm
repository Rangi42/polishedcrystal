SpriteMovementData::
; entries correspond to SPRITEMOVEDATA_* constants
	table_width NUM_SPRITEMOVEDATA_FIELDS

; SPRITEMOVEDATA_00
	db SPRITEMOVEFN_00 ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db WONT_DELETE ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_STILL
	db SPRITEMOVEFN_STANDING ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db FIXED_FACING | SLIDING ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_WANDER
	db SPRITEMOVEFN_RANDOM_WALK_XY ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_SPINRANDOM_SLOW
	db SPRITEMOVEFN_SLOW_RANDOM_SPIN ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_WALK_UP_DOWN
	db SPRITEMOVEFN_RANDOM_WALK_Y ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_WALK_LEFT_RIGHT
	db SPRITEMOVEFN_RANDOM_WALK_X ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_STANDING_DOWN
	db SPRITEMOVEFN_STANDING ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_STANDING_UP
	db SPRITEMOVEFN_STANDING ; movement function
	db UP ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_STANDING_LEFT
	db SPRITEMOVEFN_STANDING ; movement function
	db LEFT ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_STANDING_RIGHT
	db SPRITEMOVEFN_STANDING ; movement function
	db RIGHT ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_SPINRANDOM_FAST
	db SPRITEMOVEFN_FAST_RANDOM_SPIN ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_PLAYER
	db SPRITEMOVEFN_OBEY_DPAD ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db WONT_DELETE ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_CUTTABLE_TREE
	db SPRITEMOVEFN_CUT_TREE ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_CUT_TREE ; action
	db FIXED_FACING | SLIDING ; flags1
	db LOW_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_FOLLOWING
	db SPRITEMOVEFN_FOLLOW ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db WONT_DELETE ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_SCRIPTED
	db SPRITEMOVEFN_SCRIPTED ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db WONT_DELETE ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_SNORLAX
	db SPRITEMOVEFN_BIG_SNORLAX ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_BIG_SNORLAX ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db LOW_PRIORITY ; flags2
	db BIG_OBJECT ; palette flags

; SPRITEMOVEDATA_POKEMON
	db SPRITEMOVEFN_BOUNCE ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_BOUNCE ; action
	db FIXED_FACING | SLIDING ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_SUDOWOODO
	db SPRITEMOVEFN_STANDING ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db FIXED_FACING | SLIDING ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_SMASHABLE_ROCK
	db SPRITEMOVEFN_STANDING ; movement function
	db UP ; facing
	db OBJECT_ACTION_STAND ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db USE_OBP1 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_STRENGTH_BOULDER
	db SPRITEMOVEFN_STRENGTH ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db 0 ; flags2
	db STRENGTH_BOULDER ; palette flags

; SPRITEMOVEDATA_FOLLOWNOTEXACT
	db SPRITEMOVEFN_FOLLOWNOTEXACT ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db WONT_DELETE ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_SHADOW
	db SPRITEMOVEFN_SHADOW ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_00 ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | EMOTE_OBJECT ; flags1
	db LOW_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_EMOTE
	db SPRITEMOVEFN_EMOTE ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_EMOTE ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | EMOTE_OBJECT ; flags1
	db HIGH_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_SCREENSHAKE
	db SPRITEMOVEFN_SCREENSHAKE ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_00 ; action
	db WONT_DELETE | EMOTE_OBJECT ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE
	db SPRITEMOVEFN_SPIN_COUNTERCLOCKWISE ; movement function
	db LEFT ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_SPINCLOCKWISE
	db SPRITEMOVEFN_SPIN_CLOCKWISE ; movement function
	db RIGHT ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_BIGDOLL
	db SPRITEMOVEFN_STRENGTH ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_BIG_DOLL ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db LOW_PRIORITY ; flags2
	db BIG_OBJECT ; palette flags

; SPRITEMOVEDATA_BOULDERDUST
	db SPRITEMOVEFN_BOULDERDUST ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_BOULDER_DUST ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | EMOTE_OBJECT ; flags1
	db LOW_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_GRASS
	db SPRITEMOVEFN_GRASS ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_GRASS_SHAKE ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | EMOTE_OBJECT ; flags1
	db HIGH_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_PUDDLE
	db SPRITEMOVEFN_PUDDLE ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_PUDDLE_SPLASH ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | EMOTE_OBJECT ; flags1
	db HIGH_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_SWIM_AROUND
	db SPRITEMOVEFN_RANDOM_WALK_XY ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db SWIMMING ; palette flags

; SPRITEMOVEDATA_SWIM_UP_DOWN
	db SPRITEMOVEFN_RANDOM_WALK_Y ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db SWIMMING ; palette flags

; SPRITEMOVEDATA_SWIM_LEFT_RIGHT
	db SPRITEMOVEFN_RANDOM_WALK_X ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND ; action
	db 0 ; flags1
	db 0 ; flags2
	db SWIMMING ; palette flags

; SPRITEMOVEDATA_FRUIT
	db SPRITEMOVEFN_FRUIT ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_FRUIT ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_BIG_GYARADOS
	db SPRITEMOVEFN_BIG_GYARADOS ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_BIG_GYARADOS ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db LOW_PRIORITY ; flags2
	db BIG_OBJECT ; palette flags

; SPRITEMOVEDATA_STANDING_DOWN_FLIP
	db SPRITEMOVEFN_STANDING_FLIP ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_STAND_FLIP ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_STANDING_UP_FLIP
	db SPRITEMOVEFN_STANDING_FLIP ; movement function
	db UP ; facing
	db OBJECT_ACTION_STAND_FLIP ; action
	db 0 ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_POKECOM_NEWS
	db SPRITEMOVEFN_POKECOM_NEWS ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_POKECOM_NEWS ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | EMOTE_OBJECT ; flags1
	db HIGH_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_MUSEUM_DRILL_DOWN
	db SPRITEMOVEFN_MUSEUM_DRILL ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_MUSEUM_DRILL ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | EMOTE_OBJECT ; flags1
	db HIGH_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_MUSEUM_DRILL_UP
	db SPRITEMOVEFN_MUSEUM_DRILL ; movement function
	db UP ; facing
	db OBJECT_ACTION_MUSEUM_DRILL ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | EMOTE_OBJECT ; flags1
	db HIGH_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_ARCH_TREE_LEFT
	db SPRITEMOVEFN_MUSEUM_DRILL ; movement function
	db LEFT ; facing
	db OBJECT_ACTION_MUSEUM_DRILL ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db HIGH_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_ARCH_TREE_RIGHT
	db SPRITEMOVEFN_MUSEUM_DRILL ; movement function
	db RIGHT ; facing
	db OBJECT_ACTION_MUSEUM_DRILL ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db HIGH_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_SAILBOAT_TOP
	db SPRITEMOVEFN_SAILBOAT_TOP ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_SAILBOAT_TOP ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db HIGH_PRIORITY ; flags2
	db BIG_OBJECT ; palette flags

; SPRITEMOVEDATA_SAILBOAT_BOTTOM
	db SPRITEMOVEFN_SAILBOAT_BOTTOM ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_SAILBOAT_BOTTOM ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db LOW_PRIORITY ; flags2
	db BIG_OBJECT ; palette flags

; SPRITEMOVEDATA_ALOLAN_EXEGGUTOR
	db SPRITEMOVEFN_ALOLAN_EXEGGUTOR ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_ALOLAN_EXEGGUTOR ; action
	db FIXED_FACING | SLIDING ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_TINY_WINDOWS
	db SPRITEMOVEFN_TINY_WINDOWS ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_TINY_WINDOWS ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | EMOTE_OBJECT ; flags1
	db HIGH_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_PLACEHOLDER_UP
	db SPRITEMOVEFN_STANDING ; movement function
	db UP ; facing
	db OBJECT_ACTION_STAND ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db HIGH_PRIORITY ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_MICROPHONE
	db SPRITEMOVEFN_MICROPHONE ; movement function
	db LEFT ; facing
	db OBJECT_ACTION_MICROPHONE ; action
	db FIXED_FACING | SLIDING ; flags1
	db 0 ; flags2
	db 0 ; palette flags

; SPRITEMOVEDATA_BIG_HO_OH
	db SPRITEMOVEFN_BIG_HO_OH ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_BIG_HO_OH ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db HIGH_PRIORITY ; flags2
	db BIG_OBJECT ; palette flags

; SPRITEMOVEDATA_BIG_LUGIA
	db SPRITEMOVEFN_BIG_LUGIA ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_BIG_LUGIA ; action
	db WONT_DELETE | FIXED_FACING | SLIDING | MOVE_ANYWHERE ; flags1
	db HIGH_PRIORITY ; flags2
	db BIG_OBJECT ; palette flags

; SPRITEMOVEDATA_ADMIN_MEOWTH
	db SPRITEMOVEFN_ADMIN_MEOWTH ; movement function
	db DOWN ; facing
	db OBJECT_ACTION_ADMIN_MEOWTH ; action
	db FIXED_FACING | SLIDING ; flags1
	db 0 ; flags2
	db 0 ; palette flags

	assert_table_length NUM_SPRITEMOVEDATA
