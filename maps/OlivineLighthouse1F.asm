OlivineLighthouse1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event 10, 17, OLIVINE_CITY, 8
	warp_event 11, 17, OLIVINE_CITY, 8
	warp_event  3, 11, OLIVINE_LIGHTHOUSE_2F, 1
	warp_event 16, 13, OLIVINE_LIGHTHOUSE_2F, 3
	warp_event 17, 13, OLIVINE_LIGHTHOUSE_2F, 4

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  8,  2, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x5ae67, -1
	object_event 16,  9, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5aec2, -1

SailorScript_0x5ae67:
	checkevent EVENT_GOT_FULL_RESTORE_FROM_LIGHTHOUSE
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	buttonsound
	verbosegiveitem FULL_RESTORE
	iffalse_endtext
	setevent EVENT_GOT_FULL_RESTORE_FROM_LIGHTHOUSE
	thisopenedtext

.Text2:
	text "The trainers here"
	line "are all keen to"
	cont "battle."

	para "Be prepared!"
	done

.Text1:
	text "People are train-"
	line "ing hard at this"
	cont "Lighthouse."

	para "You should take"
	line "this."
	done

UnknownText_0x5aec2:
	text "In the past, #-"
	line "mon used to light"

	para "the sea around"
	line "Olivine at night."

	para "The Lighthouse was"
	line "made in honor of"
	cont "those #mon."
	done
