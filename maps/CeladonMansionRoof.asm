CeladonMansionRoof_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

CeladonMansionRoof_MapEventHeader:
	db 3 ; warps
	warp_def 1, 1, 1, CELADON_MANSION_3F
	warp_def 1, 6, 4, CELADON_MANSION_3F
	warp_def 5, 2, 1, CELADON_MANSION_ROOF_HOUSE

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 1, 6, SIGNPOST_LEFT, MapCeladonMansionRoofSignpost0Script

	db 1 ; person events
	person_event SPRITE_FISHER, 5, 7, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x71a3f, -1

MapCeladonMansionRoofSignpost0Script:
	jumptext UnknownText_0x71aa1

UnknownText_0x71a3f:
	text "High places--I do"
	line "love them so!"

	para "I'd say the only"
	line "thing that loves"

	para "heights as much as"
	line "me is smoke!"
	done

UnknownText_0x71aa1:
	text "There's graffiti"
	line "on the wall…"

	para "<PLAYER> added a"
	line "moustache!"
	done
