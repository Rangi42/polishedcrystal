ShamoutiMerchant_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

ShamoutiMerchant_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 6, SHAMOUTI_ISLAND
	warp_def 7, 3, 6, SHAMOUTI_ISLAND

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
