OlivinePortPassage_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event 3, 22, 9, OLIVINE_CITY
	warp_event 4, 22, 10, OLIVINE_CITY
	warp_event 3, 26, 4, OLIVINE_PORT_PASSAGE
	warp_event 3, 2, 3, OLIVINE_PORT_PASSAGE
	warp_event 3, 14, 1, OLIVINE_PORT

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event 5, 23, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x76faf, EVENT_OLIVINE_PORT_PASSAGE_POKEFAN_M

UnknownText_0x76faf:
	text "Fast Ship S.S.Aqua"
	line "sails to Kanto on"

	para "Mondays and Fri-"
	line "days."
	done
