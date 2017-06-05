const_value set 2
	const ROUTE7SAFFRONGATE_OFFICER
	const ROUTE7SAFFRONGATE_SILPH_EMPLOYEE

Route7SaffronGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

OfficerScript_0x73518:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue UnknownScript_0x73526
	writetext UnknownText_0x7352c
	waitbutton
	closetext
	end

UnknownScript_0x73526:
	writetext UnknownText_0x73592
	waitbutton
	closetext
	end

Route7SaffronGateSilphEmployeeScript:
	jumptextfaceplayer Route7SaffronGateSilphEmployeeText

UnknownText_0x7352c:
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

Route7SaffronGate_MapEventHeader:
.Warps:
	db 4
	warp_def $4, $0, 1, ROUTE_7
	warp_def $5, $0, 2, ROUTE_7
	warp_def $4, $9, 10, SAFFRON_CITY
	warp_def $5, $9, 11, SAFFRON_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_OFFICER, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OfficerScript_0x73518, -1
	person_event SPRITE_SILPH_EMPLOYEE, 3, 3, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, Route7SaffronGateSilphEmployeeScript, -1
