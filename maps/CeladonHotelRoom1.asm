const_value set 2
	const CELADONHOTELROOM1_COOLTRAINERM

CeladonHotelRoom1_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHotelRoom1CooltrainerMScript:
	jumptextfaceplayer CeladonHotelRoom1CooltrainerMText

CeladonHotelRoom1CooltrainerMText:
	text "Where I come from,"
	line "there aren't any"
	cont "# Balls."

	para "People use Capture"
	line "Stylers to be-"
	cont "friend #mon."
	done

CeladonHotelRoom1_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $5, $3, 2, CELADON_HOTEL_2F
	warp_def $5, $4, 2, CELADON_HOTEL_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_COOLTRAINER_M, 3, 3, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonHotelRoom1CooltrainerMScript, -1
