SaffronRichSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, SAFFRON_CITY, 20
	warp_event  3,  7, SAFFRON_CITY, 20

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  5,  3, SPRITE_RICH_BOY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronRichSpeechHouseRichBoyText, -1

SaffronRichSpeechHouseRichBoyText:
	text "Houses are expen-"
	line "sive in Saffron."

	para "If you want to"
	line "live here, you've"

	para "got to have a lot"
	line "of money, or find"
	cont "a roommate."
	done
