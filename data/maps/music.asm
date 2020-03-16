special_map_music: MACRO
; special music, pointer, bitmask, unset music, set music
	db \1
	dw \2
	db \3, \4, \5
ENDM

SpecialMapMusic:
	special_map_music MUSIC_RADIO_TOWER, wStatusFlags2, 1 << 0, MUSIC_GOLDENROD_CITY, MUSIC_ROCKET_OVERTURE ; ENGINE_ROCKETS_IN_RADIO_TOWER
	special_map_music MUSIC_MAHOGANY_MART, wStatusFlags2, 1 << 7, MUSIC_CHERRYGROVE_CITY, MUSIC_ROCKET_HIDEOUT ; ENGINE_ROCKETS_IN_MAHOGANY
	special_map_music MUSIC_LAVENDER, wStatusFlags2, 1 << 6, MUSIC_LAVENDER_TOWN_RBY, MUSIC_LAVENDER_TOWN ; ENGINE_EXORCISED_LAV_RADIO_TOWER
	db 0 ; end
