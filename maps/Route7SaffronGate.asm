Route7SaffronGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  0,  4, ROUTE_7, 1
	warp_event  0,  5, ROUTE_7, 2
	warp_event  9,  4, SAFFRON_CITY, 10
	warp_event  9,  5, SAFFRON_CITY, 11

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  5,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, OfficerScript_0x73518, -1
	object_event  3,  3, SPRITE_SILPH_EMPLOYEE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, Route7SaffronGateSilphEmployeeText, -1

OfficerScript_0x73518:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x73592
	thistextfaceplayer

	text "Did you hear about"
	line "the accident at"
	cont "the Power Plant?"

	para "It's located in"
	line "the East, close to"
	cont "Lavender Town."
	done

UnknownText_0x73592:
	text "I take my guard"
	line "job seriously."

	para "Hey! You have a"
	line "#dex."

	para "OK. You can go"
	line "through."
	done

Route7SaffronGateSilphEmployeeText:
	text "The Elite Four's"
	line "Bruno used to hone"

	para "his skills in"
	line "Saffron."

	para "He trained with a"
	line "guy named Brawly"

	para "back in the early"
	line "days."
	done
