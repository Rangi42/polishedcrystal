OlivineTimsHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 2, 7, 3, OLIVINE_CITY
	warp_event 3, 7, 3, OLIVINE_CITY

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event 2, 3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, trade, TRADE_WITH_TIM_FOR_KANGASKHAN, -1
