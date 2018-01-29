VermilionHouseFishingSpeechHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

VermilionHouseFishingSpeechHouse_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 1, VERMILION_CITY
	warp_def 7, 3, 1, VERMILION_CITY

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 0, 3, SIGNPOST_JUMPTEXT, FishingDudesHousePhotoText

	db 1 ; person events
	person_event SPRITE_FISHING_GURU, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, FishingDudeText, -1

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
