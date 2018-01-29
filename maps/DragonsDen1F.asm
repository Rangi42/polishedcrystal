DragonsDen1F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

DragonsDen1F_MapEventHeader:
	db 4 ; warps
	warp_def 55, 15, 8, BLACKTHORN_CITY
	warp_def 53, 15, 4, DRAGONS_DEN_1F
	warp_def 55, 5, 1, DRAGONS_DEN_B1F
	warp_def 53, 5, 2, DRAGONS_DEN_1F

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
