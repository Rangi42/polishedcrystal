OlivinePortPassage_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event  3, 22, OLIVINE_CITY, 9
	warp_event  4, 22, OLIVINE_CITY, 10
	warp_event  3, 26, OLIVINE_PORT_PASSAGE, 4
	warp_event  3,  2, OLIVINE_PORT_PASSAGE, 3
	warp_event  3, 14, OLIVINE_PORT, 1

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  5, 23, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x76faf, EVENT_OLIVINE_PORT_PASSAGE_POKEFAN_M

UnknownText_0x76faf:
	text "Fast Ship S.S.Aqua"
	line "sails to Kanto on"

	para "Mondays and Fri-"
	line "days."
	done
