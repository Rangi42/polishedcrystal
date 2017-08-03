IcePathB2FMahoganySide_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

IcePathB2FMahoganySide_MapEventHeader:

.Warps: db 6
	warp_def $1, $11, 2, ICE_PATH_B1F
	warp_def $b, $9, 1, ICE_PATH_B3F
	warp_def $4, $b, 3, ICE_PATH_B1F
	warp_def $6, $4, 4, ICE_PATH_B1F
	warp_def $c, $4, 5, ICE_PATH_B1F
	warp_def $c, $c, 6, ICE_PATH_B1F

.XYTriggers: db 0

.Signposts: db 1
	signpost 17, 0, SIGNPOST_ITEM, IcePathB2FMahoganySideHiddenCarbos

.PersonEvents: db 6
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 3, 11, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BoulderScript_0x7e5a3, EVENT_BOULDER_IN_ICE_PATH_1A
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 7, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BoulderScript_0x7e5a3, EVENT_BOULDER_IN_ICE_PATH_2A
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 12, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BoulderScript_0x7e5a3, EVENT_BOULDER_IN_ICE_PATH_3A
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 13, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BoulderScript_0x7e5a3, EVENT_BOULDER_IN_ICE_PATH_4A
	person_event SPRITE_BALL_CUT_FRUIT, 9, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, IcePathB2FMahoganySideFullHeal, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_FULL_HEAL
	person_event SPRITE_BALL_CUT_FRUIT, 2, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, IcePathB2FMahoganySideMaxPotion, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_MAX_POTION

BoulderScript_0x7e5a3:
	jumptext UnknownText_0x7e5ad

IcePathB2FMahoganySideFullHeal:
	itemball FULL_HEAL

IcePathB2FMahoganySideMaxPotion:
	itemball MAX_POTION

IcePathB2FMahoganySideHiddenCarbos:
	dwb EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_HIDDEN_CARBOS, CARBOS


UnknownText_0x7e5ad:
	text "It's immovably"
	line "imbedded in ice."
	done
