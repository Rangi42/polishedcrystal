MACRO alternate_music
; pointer, bitmask, unset music id, set music id
	dw \1
	db 1 << (\2), \3, \4
ENDM

AlternateMusic:
; entries correspond to alternate MUSIC_* constants (see constants/music_constants.asm)
	table_width 5
	alternate_music wStatusFlags2, 0, MUSIC_GOLDENROD_CITY,    MUSIC_ROCKET_OVERTURE ; MUSIC_RADIO_TOWER:   ENGINE_ROCKETS_IN_RADIO_TOWER
	alternate_music wStatusFlags2, 7, MUSIC_CHERRYGROVE_CITY,  MUSIC_ROCKET_HIDEOUT  ; MUSIC_MAHOGANY_MART: ENGINE_ROCKETS_IN_MAHOGANY
	alternate_music wStatusFlags2, 6, MUSIC_LAVENDER_TOWN_RBY, MUSIC_LAVENDER_TOWN   ; MUSIC_LAVENDER:      ENGINE_EXORCISED_LAV_RADIO_TOWER
	assert_table_length $100 - FIRST_ALT_MUSIC
