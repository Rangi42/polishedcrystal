SoulHouseB1F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

SoulHouseB1F_MapEventHeader:
	db 3 ; warps
	warp_def 5, 17, 3, SOUL_HOUSE
	warp_def 15, 17, 1, SOUL_HOUSE_B2F
	warp_def 15, 3, 2, SOUL_HOUSE_B2F

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
