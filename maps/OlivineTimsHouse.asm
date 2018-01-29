OlivineTimsHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

OlivineTimsHouse_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 3, OLIVINE_CITY
	warp_def 7, 3, 3, OLIVINE_CITY

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_FISHING_GURU, 3, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, trade, TRADE_WITH_TIM_FOR_KANGASKHAN, -1
