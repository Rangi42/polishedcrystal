const_value set 2
	const CELADONHOTELROOM1_COOLTRAINERM
	const CELADONHOTELROOM1_LASS
	const CELADONHOTELROOM1_POKE_BALL

CeladonHotelRoom1_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHotelRoom1CooltrainerMScript:
	jumptextfaceplayer CeladonHotelRoom1CooltrainerMText

CeladonHotelRoom1LassScript:
	jumptextfaceplayer CeladonHotelRoom1LassText

CeladonHotelRoom1PokeDoll:
	itemball POKE_DOLL

CeladonHotelRoom1CooltrainerMText:
	text "Where I come from,"
	line "there aren't any"
	cont "# Balls."

	para "People use Capture"
	line "Stylers to be-"
	cont "friend #mon."
	done

CeladonHotelRoom1LassText:
	text "The staff here"
	line "fold our towels"
	cont "into flower shapes"
	cont "every day."

	para "I should ask them"
	line "to teach me how."
	done

CeladonHotelRoom1_MapEventHeader:
.Warps:
	db 2
	warp_def $5, $3, 2, CELADON_HOTEL_2F
	warp_def $5, $4, 2, CELADON_HOTEL_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_COOLTRAINER_M, 3, 3, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonHotelRoom1CooltrainerMScript, -1
	person_event SPRITE_LASS, 3, 1, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonHotelRoom1LassScript, -1
	person_event SPRITE_BALL_CUT_FRUIT, 1, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, CeladonHotelRoom1PokeDoll, EVENT_CELADON_HOTEL_ROOM_1_POKE_DOLL
