VermilionHouseDiglettsCaveSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, VERMILION_CITY, 6
	warp_event  3,  7, VERMILION_CITY, 6

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  1,  3, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x192034, -1

UnknownText_0x192034:
	text "Over many years,"
	line "Diglett dug a"
	cont "large tunnel."

	para "That tunnel goes"
	line "to a distant town."
	done
