const_value set 2
	const VALERIESHOUSE_VALERIE
	const VALERIESHOUSE_POKEDEX

ValeriesHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ValeriesHouseValerieScript:
	jumptextfaceplayer ValeriesHouseValerieText

ValeriesHouseBookScript:
	jumptext ValeriesHouseBookText

ValeriesHouseRadio:
	jumpstd radio2

ValeriesHouseValerieText:
	text "Valerie: My"
	line "fashion designs"

	para "are said to be"
	line "rather mystifying."

	para "Do you agree with"
	line "that?"

	para "I've always wanted"
	line "to be a #mon,"
	cont "you see."

	para "That desire is my"
	line "inspiration and"

	para "what I try to"
	line "achieve by"
	cont "designing."

	para "And yet… the only"
	line "time I feel truly"

	para "one with #mon"
	line "is when we are"

	para "embroiled in"
	line "desperate battle."

	para "I wonder why that"
	line "is…"
	done

ValeriesHouseBookText:
	text "It's a book of"
	line "fairy tales."

	para "This story is"
	line "about a girl with"
	cont "very long hair…"
	done

ValeriesHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $3, 12, ECRUTEAK_CITY
	warp_def $7, $4, 12, ECRUTEAK_CITY

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 2, SIGNPOST_READ, ValeriesHouseRadio

.PersonEvents:
	db 2
	person_event SPRITE_VALERIE, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ValeriesHouseValerieScript, EVENT_VALERIE_ECRUTEAK_CITY
	person_event SPRITE_POKEDEX, 3, 3, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ValeriesHouseBookScript, -1
