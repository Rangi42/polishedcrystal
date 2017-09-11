IcePathB2FMahoganySide_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

IcePathB2FMahoganySide_MapEventHeader:

.Warps: db 6
	warp_def 1, 17, 2, ICE_PATH_B1F
	warp_def 11, 9, 1, ICE_PATH_B3F
	warp_def 4, 11, 3, ICE_PATH_B1F
	warp_def 6, 4, 4, ICE_PATH_B1F
	warp_def 12, 4, 5, ICE_PATH_B1F
	warp_def 12, 12, 6, ICE_PATH_B1F

.XYTriggers: db 0

.Signposts: db 1
	signpost 17, 0, SIGNPOST_ITEM + CARBOS, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_HIDDEN_CARBOS

.PersonEvents: db 6
	person_event SPRITE_BOULDER_ROCK_FOSSIL, 3, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BoulderScript_0x7e5a3, EVENT_BOULDER_IN_ICE_PATH_1A
	person_event SPRITE_BOULDER_ROCK_FOSSIL, 7, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BoulderScript_0x7e5a3, EVENT_BOULDER_IN_ICE_PATH_2A
	person_event SPRITE_BOULDER_ROCK_FOSSIL, 12, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BoulderScript_0x7e5a3, EVENT_BOULDER_IN_ICE_PATH_3A
	person_event SPRITE_BOULDER_ROCK_FOSSIL, 13, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BoulderScript_0x7e5a3, EVENT_BOULDER_IN_ICE_PATH_4A
	itemball_event 9, 8, FULL_HEAL, 1, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_FULL_HEAL
	itemball_event 2, 0, MAX_POTION, 1, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_MAX_POTION

BoulderScript_0x7e5a3:
	jumptext UnknownText_0x7e5ad

UnknownText_0x7e5ad:
	text "It's immovably"
	line "imbedded in ice."
	done
