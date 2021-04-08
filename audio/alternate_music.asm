alternate_music: MACRO
; pointer, bitmask, unset music id, set music id
	dw \1
	db \2, \3, \4
ENDM

AlternateMusic:
	table_width 5, AlternateMusic
	alternate_music wStatusFlags2, 1 << 0, MUSIC_GOLDENROD_CITY,    MUSIC_ROCKET_OVERTURE ; MUSIC_RADIO_TOWER:   ENGINE_ROCKETS_IN_RADIO_TOWER
	alternate_music wStatusFlags2, 1 << 7, MUSIC_CHERRYGROVE_CITY,  MUSIC_ROCKET_HIDEOUT  ; MUSIC_MAHOGANY_MART: ENGINE_ROCKETS_IN_MAHOGANY
	alternate_music wStatusFlags2, 1 << 6, MUSIC_LAVENDER_TOWN_RBY, MUSIC_LAVENDER_TOWN   ; MUSIC_LAVENDER:      ENGINE_EXORCISED_LAV_RADIO_TOWER
	assert_table_length $100 - FIRST_ALT_MUSIC
