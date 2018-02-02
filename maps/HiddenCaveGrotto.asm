HiddenCaveGrotto_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, HiddenGrottoCallback

	db 1 ; warp events
	warp_event 35, 85, HIDDEN_CAVE_GROTTO, -1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 34, 74, SIGNPOST_GROTTOITEM, HiddenGrottoHiddenItemScript

	db 2 ; object events
	object_event 34, 74, SPRITE_GROTTO_MON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, HiddenGrottoPokemonScript, EVENT_GAVE_KURT_APRICORNS
	object_event 34, 74, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, HiddenGrottoItemScript, EVENT_RECEIVED_BALLS_FROM_KURT
