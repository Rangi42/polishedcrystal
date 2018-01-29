Route42EcruteakGate_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

Route42EcruteakGate_MapEventHeader:
	db 4 ; warps
	warp_def 4, 0, 1, ECRUTEAK_CITY
	warp_def 5, 0, 2, ECRUTEAK_CITY
	warp_def 4, 9, 1, ROUTE_42
	warp_def 5, 9, 2, ROUTE_42

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_OFFICER, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x19a4b8, -1

UnknownText_0x19a4b8:
	text "Mt.Mortar is like"
	line "a maze inside."

	para "Be careful. Don't"
	line "get lost in there."
	done
