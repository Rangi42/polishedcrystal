RuinsofAlphOmanyteWordRoom_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

RuinsofAlphOmanyteWordRoom_MapEventHeader:
	db 3 ; warps
	warp_def 7, 9, 3, RUINS_OF_ALPH_OMANYTE_ITEM_ROOM
	warp_def 7, 10, 4, RUINS_OF_ALPH_OMANYTE_ITEM_ROOM
	warp_def 13, 17, 6, RUINS_OF_ALPH_INNER_CHAMBER

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
