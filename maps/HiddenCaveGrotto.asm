HiddenCaveGrotto_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, HiddenGrottoCallback

HiddenCaveGrotto_MapEventHeader:

.Warps: db 1
	warp_def 85, 35, -1, HIDDEN_CAVE_GROTTO

.XYTriggers: db 0

.Signposts: db 1
	signpost 74, 34, SIGNPOST_GROTTOITEM, HiddenGrottoHiddenItemScript

.PersonEvents: db 2
	person_event SPRITE_GROTTO_MON, 74, 34, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, HiddenGrottoPokemonScript, EVENT_GAVE_KURT_APRICORNS
	person_event SPRITE_BALL_CUT_FRUIT, 74, 34, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, HiddenGrottoItemScript, EVENT_RECEIVED_BALLS_FROM_KURT
