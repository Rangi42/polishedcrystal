const_value set 2
	const ROUTE5SAFFRONCITYGATE_OFFICER
	const ROUTE5SAFFRONCITYGATE_BLACK_BELT

Route5SaffronCityGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

OfficerScript_0x18b5b9:
	jumptextfaceplayer UnknownText_0x18b5bc

Route5SaffronCityGateBlackBeltScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_PROTEIN_FROM_SAFFRON_GATE
	iftrue .GotItem
	writetext Route5SaffronCityGateBlackBeltText1
	buttonsound
	verbosegiveitem PROTEIN
	iffalse .Done
	setevent EVENT_GOT_PROTEIN_FROM_SAFFRON_GATE
.GotItem:
	writetext Route5SaffronCityGateBlackBeltText2
	waitbutton
.Done:
	closetext
	end

UnknownText_0x18b5bc:
	text "You're from Johto,"
	line "aren't you?"

	para "How do you like"
	line "Kanto? It's nice,"
	cont "don't you agree?"
	done

Route5SaffronCityGateBlackBeltText1:
	text "Get a load of"
	line "these muscles!"

	para "Impressive, I"
	line "know!"

	para "You're pretty puny,"
	line "so if you wanna"
	cont "get big like me"

	para "you'll need some"
	line "of this."
	done

Route5SaffronCityGateBlackBeltText2:
	text "Eat lots of Pro-"
	line "tein and see your"
	cont "strength grow!"
	done

Route5SaffronCityGate_MapEventHeader:
.Warps:
	db 4
	warp_def $0, $4, 2, ROUTE_5
	warp_def $0, $5, 3, ROUTE_5
	warp_def $7, $4, 9, SAFFRON_CITY
	warp_def $7, $5, 9, SAFFRON_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OfficerScript_0x18b5b9, -1
	person_event SPRITE_BLACK_BELT, 4, 6, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, Route5SaffronCityGateBlackBeltScript, -1
