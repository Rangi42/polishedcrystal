OlivineLighthouse1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

OlivineLighthouse1F_MapEventHeader:

.Warps: db 5
	warp_def 17, 10, 8, OLIVINE_CITY
	warp_def 17, 11, 8, OLIVINE_CITY
	warp_def 11, 3, 1, OLIVINE_LIGHTHOUSE_2F
	warp_def 13, 16, 3, OLIVINE_LIGHTHOUSE_2F
	warp_def 13, 17, 4, OLIVINE_LIGHTHOUSE_2F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_SAILOR, 2, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x5ae67, -1
	person_event SPRITE_POKEFAN_F, 9, 16, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5aec2, -1

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
