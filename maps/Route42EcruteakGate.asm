Route42EcruteakGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 0, 4, 1, ECRUTEAK_CITY
	warp_event 0, 5, 2, ECRUTEAK_CITY
	warp_event 9, 4, 1, ROUTE_42
	warp_event 9, 5, 2, ROUTE_42

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event 5, 2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x19a4b8, -1

UnknownText_0x19a4b8:
	text "Mt.Mortar is like"
	line "a maze inside."

	para "Be careful. Don't"
	line "get lost in there."
	done
