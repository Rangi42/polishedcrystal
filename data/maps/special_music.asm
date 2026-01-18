; Functions are defined in home/audio.asm.
; Specifying GetMapMusic makes the Bicycle and Surf music not play.

MACRO music_map
	map_id \1
	dw \2
ENDM

SpecialMusicMaps:
	music_map ROUTE_23_NORTH,              GetMapMusic
	music_map ROUTE_23_SOUTH,              GetMapMusic
	music_map INDIGO_PLATEAU,              GetMapMusic
	music_map QUIET_CAVE_1F,               GetMapMusic
	music_map QUIET_CAVE_B1F,              GetMapMusic
	music_map QUIET_CAVE_B2F,              GetMapMusic
	music_map QUIET_CAVE_B3F,              GetMapMusic
	music_map SCARY_CAVE_SHIPWRECK,        GetMapMusic
	music_map WHIRL_ISLAND_LUGIA_CHAMBER,  GetMapMusic
	music_map TIN_TOWER_ROOF,              GetMapMusic
	music_map ROUTE_16_SOUTH,              GetCyclingRoadMusic
	music_map ROUTE_17,                    GetCyclingRoadMusic
	music_map ROUTE_18_WEST,               GetCyclingRoadMusic
	music_map ROUTE_35_NATIONAL_PARK_GATE, GetBugCatchingContestMusic
	music_map ROUTE_36_NATIONAL_PARK_GATE, GetBugCatchingContestMusic
	db 0 ; end
