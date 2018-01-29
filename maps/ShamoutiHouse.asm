ShamoutiHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

ShamoutiHouse_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 5, SHAMOUTI_ISLAND
	warp_def 7, 3, 5, SHAMOUTI_ISLAND

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
