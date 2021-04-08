alternate_music: MACRO
; music id, pointer, bitmask, unset music id, set music id
	db \1
	dw \2
	db \3, \4, \5
ENDM

AlternateMusic:
	alternate_music MUSIC_RADIO_TOWER,   wStatusFlags2, 1 << 0, MUSIC_GOLDENROD_CITY,    MUSIC_ROCKET_OVERTURE ; ENGINE_ROCKETS_IN_RADIO_TOWER
	alternate_music MUSIC_MAHOGANY_MART, wStatusFlags2, 1 << 7, MUSIC_CHERRYGROVE_CITY,  MUSIC_ROCKET_HIDEOUT  ; ENGINE_ROCKETS_IN_MAHOGANY
	alternate_music MUSIC_LAVENDER,      wStatusFlags2, 1 << 6, MUSIC_LAVENDER_TOWN_RBY, MUSIC_LAVENDER_TOWN   ; ENGINE_EXORCISED_LAV_RADIO_TOWER
	db 0 ; end
