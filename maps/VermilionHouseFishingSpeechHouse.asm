VermilionHouseFishingSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, VERMILION_CITY, 1
	warp_event  3,  7, VERMILION_CITY, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event  3,  0, SIGNPOST_JUMPTEXT, FishingDudesHousePhotoText

	db 1 ; object events
	object_event  2,  4, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, FishingDudeText, -1

FishingDudeText:
	text "I am the Fishing"
	line "Dude, the elder of"
	cont "the Fishing Bros."

	para "Have you met the"
	line "Fishing Guru at"
	cont "Lake of Rage?"

	para "He dreams about"
	line "seeing the world's"
	cont "greatest Magikarp."

	para "If you don't mind,"
	line "could you show him"

	para "any Magikarp you"
	line "catch?"

	para "Who knows, you may"
	line "catch the Magikarp"
	cont "of his dreams."
	done

FishingDudesHousePhotoText:
	text "It's a photo of"
	line "people fishing…"

	para "They're having a"
	line "great time…"
	done
