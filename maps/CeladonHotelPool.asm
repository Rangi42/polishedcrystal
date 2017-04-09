const_value set 2
	const CELADONHOTELPOOL_POKEFAN_M
	const CELADONHOTELPOOL_CHILD
	const CELADONHOTELPOOL_SWIMMER_GUY

CeladonHotelPool_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHotelPoolPokefanMScript:
	jumptextfaceplayer CeladonHotelPoolPokefanMText

CeladonHotelPoolChildScript:
	jumptextfaceplayer CeladonHotelPoolChildText

CeladonHotelPoolSwimmerMScript:
	jumptextfaceplayer CeladonHotelPoolSwimmerMText

CeladonHotelPoolPokefanMText:
	text "Well, color me"
	line "impressed."

	para "This hotel's"
	line "facilities are"
	cont "second-to-none!"
	done

CeladonHotelPoolChildText:
	text "Whee!"
	done

CeladonHotelPoolSwimmerMText:
	text "Ahh, this is quite"
	line "relaxing…"
	done

CeladonHotelPool_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $a, 4, CELADON_HOTEL_1F
	warp_def $7, $b, 4, CELADON_HOTEL_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_POKEFAN_M, 3, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonHotelPoolPokefanMScript, -1
	person_event SPRITE_CHILD, 6, 4, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonHotelPoolChildScript, -1
	person_event SPRITE_SWIMMER_GUY, 3, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, CeladonHotelPoolSwimmerMScript, -1
