RuinsofAlphKabutoWordRoom_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

RuinsofAlphKabutoWordRoom_MapEventHeader:
	db 3 ; warps
	warp_def 5, 9, 3, RUINS_OF_ALPH_KABUTO_ITEM_ROOM
	warp_def 5, 10, 4, RUINS_OF_ALPH_KABUTO_ITEM_ROOM
	warp_def 11, 17, 4, RUINS_OF_ALPH_INNER_CHAMBER

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
