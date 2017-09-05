OlivineTimsHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

OlivineTimsHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 3, OLIVINE_CITY
	warp_def 7, 3, 3, OLIVINE_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_FISHING_GURU, 3, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, trade, TRADE_WITH_TIM_FOR_KANGASKHAN, -1
