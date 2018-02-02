CeruleanBerryPowderHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CERULEAN_CITY, 9
	warp_event  3,  7, CERULEAN_CITY, 9

	db 0 ; coord events

	db 1 ; bg events
	bg_event  7,  1, SIGNPOST_JUMPSTD, difficultbookshelf

	db 1 ; object events
	object_event  5,  4, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, CeruleanBerryPowderHouseGrampsScript, -1

CeruleanBerryPowderHouseGrampsScript:
	checkevent EVENT_GOT_HP_UP_FROM_CERULEAN
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	buttonsound
	verbosegiveitem HP_UP
	iffalse_endtext
	setevent EVENT_GOT_HP_UP_FROM_CERULEAN
	thisopenedtext

.Text2:
	text "Concocting med-"
	line "icines was a"
	cont "rewarding job,"

	para "but I deserve a"
	line "break."
	done

.Text1:
	text "Berry Powder?"
	line "Sorry, kid, I'm"
	cont "retired now."

	para "I do have this"
	line "left over…"
	done
