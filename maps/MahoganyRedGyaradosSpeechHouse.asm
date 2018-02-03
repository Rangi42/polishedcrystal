MahoganyRedGyaradosSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, MAHOGANY_TOWN, 2
	warp_event  3,  7, MAHOGANY_TOWN, 2

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  2,  3, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x19999c, -1
	object_event  6,  5, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, TeacherScript_0x199982, -1

TeacherScript_0x199982:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue_jumptextfaceplayer UnknownText_0x199a3d
	thistextfaceplayer

	text "My favorite radio"
	line "program? I'd say"
	cont "#mon Music."
	done

UnknownText_0x19999c:
	text "I heard that a red"
	line "Gyarados appeared"
	cont "at the lake."

	para "That's odd, since"
	line "even ordinary"

	para "Gyarados are rare"
	line "in that lake…"
	done

UnknownText_0x199a3d:
	text "I've been hearing"
	line "laughter on the"

	para "radio…"
	line "It's creepy."
	done
