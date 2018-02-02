VermilionSSAnneSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, VERMILION_CITY, 14
	warp_event  3,  7, VERMILION_CITY, 14

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, VermilionSSAnneSpeechHouseGrampsText, -1
	object_event  5,  4, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 1, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, VermilionSSAnneSpeechHouseBeautyText, -1

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
