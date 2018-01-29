ValenciaHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

ValenciaHouse_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 3, VALENCIA_ISLAND
	warp_def 7, 3, 3, VALENCIA_ISLAND

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_LASS, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, ValenciaHouseLassText, -1

ValenciaHouseLassText:
	text "Prof.Ivy is really"
	line "cool!"

	para "She helped my"
	line "#mon when they"
	cont "were sick!"
	done
