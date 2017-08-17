VermilionSSAnneSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VermilionSSAnneSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 14, VERMILION_CITY
	warp_def 7, 3, 14, VERMILION_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_GRAMPS, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 1, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, VermilionSSAnneSpeechHouseGrampsText, -1
	person_event SPRITE_BEAUTY, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 1, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, VermilionSSAnneSpeechHouseBeautyText, -1

VermilionSSAnneSpeechHouseGrampsText:
	text "Once a year, a"
	line "cruise ship named"

	para "the S.S.Anne used"
	line "to dock here in"
	cont "Vermilion."

	para "That is, until one"
	line "year, when tragedy"
	cont "struck."

	para "Something went"
	line "wrong and the ship"

	para "sank deep into the"
	line "ocean, never to be"
	cont "seen again."
	done

VermilionSSAnneSpeechHouseBeautyText:
	text "I've seen a model"
	line "of the S.S.Anne"

	para "in an Oceanic"
	line "Museum far away."
	done
