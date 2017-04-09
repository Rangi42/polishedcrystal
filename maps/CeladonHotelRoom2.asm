const_value set 2
	const CELADONHOTELROOM2_LASS

CeladonHotelRoom2_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHotelRoom2LassScript:
	jumptextfaceplayer CeladonHotelRoom2LassText

CeladonHotelRoom2LassText:
	text "The staff here"
	line "fold my towels"
	cont "into flower shapes"
	cont "every day."

	para "I should ask them"
	line "to teach me how."
	done

CeladonHotelRoom2_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $5, $3, 3, CELADON_HOTEL_2F
	warp_def $5, $4, 3, CELADON_HOTEL_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_LASS, 2, 3, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonHotelRoom2LassScript, -1
