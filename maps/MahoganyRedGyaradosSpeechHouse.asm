MahoganyRedGyaradosSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MahoganyRedGyaradosSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 2, MAHOGANY_TOWN
	warp_def 7, 3, 2, MAHOGANY_TOWN

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_BLACK_BELT, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x19999c, -1
	person_event SPRITE_TEACHER, 5, 6, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, TeacherScript_0x199982, -1

TeacherScript_0x199982:
	faceplayer
	opentext
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue UnknownScript_0x199990
	jumpopenedtext UnknownText_0x199a0e

UnknownScript_0x199990:
	jumpopenedtext UnknownText_0x199a3d

UnknownText_0x19999c:
	text "I heard that a red"
	line "Gyarados appeared"
	cont "at the lake."

	para "That's odd, since"
	line "even ordinary"

	para "Gyarados are rare"
	line "in that lake…"
	done

UnknownText_0x199a0e:
	text "My favorite radio"
	line "program? I'd say"
	cont "#mon Music."
	done

UnknownText_0x199a3d:
	text "I've been hearing"
	line "laughter on the"

	para "radio…"
	line "It's creepy."
	done
