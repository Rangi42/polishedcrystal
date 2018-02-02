Route5SaffronCityGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  4,  0, ROUTE_5, 2
	warp_event  5,  0, ROUTE_5, 3
	warp_event  4,  7, SAFFRON_CITY, 9
	warp_event  5,  7, SAFFRON_CITY, 9

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route5SaffronCityGateOfficerText, -1
	object_event  6,  4, SPRITE_BLACK_BELT, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, Route5SaffronCityGateBlackBeltScript, -1

Route5SaffronCityGateOfficerText:
	text "You're from Johto,"
	line "aren't you?"

	para "How do you like"
	line "Kanto? It's nice,"
	cont "don't you agree?"
	done

Route5SaffronCityGateBlackBeltScript:
	checkevent EVENT_GOT_PROTEIN_FROM_SAFFRON_GATE
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	buttonsound
	verbosegiveitem PROTEIN
	iffalse_endtext
	setevent EVENT_GOT_PROTEIN_FROM_SAFFRON_GATE
	thisopenedtext

.Text2:
	text "Eat lots of Pro-"
	line "tein and see your"
	cont "strength grow!"
	done

.Text1:
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
