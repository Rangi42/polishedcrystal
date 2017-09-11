Route5SaffronCityGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route5SaffronCityGate_MapEventHeader:

.Warps: db 4
	warp_def 0, 4, 2, ROUTE_5
	warp_def 0, 5, 3, ROUTE_5
	warp_def 7, 4, 9, SAFFRON_CITY
	warp_def 7, 5, 9, SAFFRON_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route5SaffronCityGateOfficerText, -1
	person_event SPRITE_BLACK_BELT, 4, 6, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, Route5SaffronCityGateBlackBeltScript, -1

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
