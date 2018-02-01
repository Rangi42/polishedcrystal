SaffronRichSpeechHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 20, SAFFRON_CITY
	warp_def 7, 3, 20, SAFFRON_CITY

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_RICH_BOY, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronRichSpeechHouseRichBoyText, -1

SaffronRichSpeechHouseRichBoyText:
	text "Houses are expen-"
	line "sive in Saffron."

	para "If you want to"
	line "live here, you've"

	para "got to have a lot"
	line "of money, or find"
	cont "a roommate."
	done
