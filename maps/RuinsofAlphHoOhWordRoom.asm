RuinsofAlphHoOhWordRoom_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

RuinsofAlphHoOhWordRoom_MapEventHeader:
	db 3 ; warps
	warp_def 9, 9, 3, RUINS_OF_ALPH_HO_OH_ITEM_ROOM
	warp_def 9, 10, 4, RUINS_OF_ALPH_HO_OH_ITEM_ROOM
	warp_def 21, 17, 2, RUINS_OF_ALPH_INNER_CHAMBER

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
