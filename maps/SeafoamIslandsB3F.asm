SeafoamIslandsB3F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SeafoamIslandsB3F_MapEventHeader:

.Warps: db 10
	warp_def $7, $25, 5, SEAFOAM_ISLANDS_B2F
	warp_def $9, $19, 6, SEAFOAM_ISLANDS_B2F
	warp_def $d, $23, 7, SEAFOAM_ISLANDS_B2F
	warp_def $d, $3, 8, SEAFOAM_ISLANDS_B2F
	warp_def $3, $3, 1, SEAFOAM_ISLANDS_B4F
	warp_def $d, $7, 2, SEAFOAM_ISLANDS_B4F
	warp_def $9, $15, 3, SEAFOAM_ISLANDS_B4F
	warp_def $3, $1d, 4, SEAFOAM_ISLANDS_B4F
	warp_def $f, $1f, 5, SEAFOAM_ISLANDS_B4F
	warp_def $f, $25, 6, SEAFOAM_ISLANDS_B4F

.XYTriggers: db 0

.Signposts: db 2
	signpost 17, 27, SIGNPOST_ITEM, SeafoamIslandsB3FHiddenMaxRevive
	signpost 5, 7, SIGNPOST_ITEM, SeafoamIslandsB3FHiddenRareCandy

.PersonEvents: db 3
	person_event SPRITE_BALL_CUT_FRUIT, 15, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SeafoamIslandsB3FRevive, EVENT_SEAFOAM_ISLANDS_B3F_REVIVE
	person_event SPRITE_BALL_CUT_FRUIT, 6, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SeafoamIslandsB3FBigPearl, EVENT_SEAFOAM_ISLANDS_B3F_BIG_PEARL
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 7, 28, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeafoamIslandsB3FBoulder, -1

SeafoamIslandsB3FRevive:
	itemball REVIVE

SeafoamIslandsB3FBigPearl:
	itemball BIG_PEARL

SeafoamIslandsB3FHiddenMaxRevive:
	dwb EVENT_SEAFOAM_ISLANDS_B3F_HIDDEN_MAX_REVIVE, MAX_REVIVE

SeafoamIslandsB3FHiddenRareCandy:
	dwb EVENT_SEAFOAM_ISLANDS_B3F_HIDDEN_RARE_CANDY, RARE_CANDY

SeafoamIslandsB3FBoulder:
	jumpstd strengthboulder
