LavenderTownSpeechHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

LavenderTownSpeechHouse_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 3, LAVENDER_TOWN
	warp_def 7, 3, 3, LAVENDER_TOWN

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_POKEFAN_F, 3, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7ea4d, -1

UnknownText_0x7ea4d:
	text "Lavender is a"
	line "tiny, quiet town"

	para "at the foot of the"
	line "mountains."

	para "It's gotten a bit"
	line "busier since the"

	para "Radio Tower was"
	line "built."
	done
