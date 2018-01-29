Route6UndergroundEntrance_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

Route6UndergroundEntrance_MapEventHeader:
	db 3 ; warps
	warp_def 7, 3, 1, ROUTE_6
	warp_def 7, 4, 1, ROUTE_6
	warp_def 4, 4, 2, UNDERGROUND

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
