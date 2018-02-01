HiddenCaveGrotto_MapScriptHeader:
	db 0 ; map triggers

	db 1 ; map callbacks
	dbw MAPCALLBACK_NEWMAP, HiddenGrottoCallback

	db 1 ; warps
	warp_def 85, 35, -1, HIDDEN_CAVE_GROTTO

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 74, 34, SIGNPOST_GROTTOITEM, HiddenGrottoHiddenItemScript

	db 2 ; person events
	person_event SPRITE_GROTTO_MON, 74, 34, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, HiddenGrottoPokemonScript, EVENT_GAVE_KURT_APRICORNS
	person_event SPRITE_BALL_CUT_FRUIT, 74, 34, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, HiddenGrottoItemScript, EVENT_RECEIVED_BALLS_FROM_KURT
