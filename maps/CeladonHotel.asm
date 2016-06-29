const_value set 2
	const CELADONHOTEL_GRAMPS
	const CELADONHOTEL_COOLTRAINERF

CeladonHotel_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHotelGrampsScript:
	jumptextfaceplayer CeladonHotelGrampsText

CeladonHotelCooltrainerFScript:
	jumptextfaceplayer CeladonHotelCooltrainerFText

CeladonHotelGrampsText:
	text "#mon? No, this"
	line "is a hotel for"
	cont "people."

	para "We're full up."
	done

CeladonHotelCooltrainerFText:
	text "Ahh, I really"
	line "needed this"
	cont "vacation!"
	done

CeladonHotel_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $4, 11, CELADON_CITY
	warp_def $7, $5, 11, CELADON_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_GRAMPS, 1, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonHotelGrampsScript, -1
	person_event SPRITE_COOLTRAINER_F, 4, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonHotelCooltrainerFScript, -1
