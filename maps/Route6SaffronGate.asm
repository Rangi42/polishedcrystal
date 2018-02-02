Route6SaffronGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  4,  0, SAFFRON_CITY, 12
	warp_event  5,  0, SAFFRON_CITY, 13
	warp_event  4,  7, ROUTE_6, 2
	warp_event  5,  7, ROUTE_6, 2

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, OfficerScript_0x1926ea, -1

OfficerScript_0x1926ea:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x1927cb
	thistextfaceplayer

	text "Welcome to Saffron"
	line "City, home of the"
	cont "Magnet Train!"

	para "…That's what I'd"
	line "normally say, but"

	para "the Magnet Train"
	line "isn't running now."

	para "It's not getting"
	line "any electricity"

	para "because there's"
	line "something wrong"

	para "with the Power"
	line "Plant."
	done

UnknownText_0x1927cb:
	text "The Magnet Train"
	line "is the most famous"

	para "thing about Saf-"
	line "fron."
	done
