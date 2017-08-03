SilverCaveRoom1_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SilverCaveRoom1_MapEventHeader:

.Warps: db 2
	warp_def $21, $9, 2, SILVER_CAVE_OUTSIDE
	warp_def $1, $f, 1, SILVER_CAVE_ROOM_2

.XYTriggers: db 0

.Signposts: db 2
	signpost 23, 16, SIGNPOST_ITEM, SilverCaveRoom1HiddenDireHit
	signpost 12, 17, SIGNPOST_ITEM, SilverCaveRoom1HiddenUltraBall

.PersonEvents: db 4
	person_event SPRITE_BALL_CUT_FRUIT, 9, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SilverCaveRoom1MaxElixer, EVENT_SILVER_CAVE_ROOM_1_MAX_ELIXER
	person_event SPRITE_BALL_CUT_FRUIT, 29, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SilverCaveRoom1Protein, EVENT_SILVER_CAVE_ROOM_1_PROTEIN
	person_event SPRITE_BALL_CUT_FRUIT, 30, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SilverCaveRoom1EscapeRope, EVENT_SILVER_CAVE_ROOM_1_ESCAPE_ROPE
	person_event SPRITE_BALL_CUT_FRUIT, 18, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SilverCaveRoom1UltraBall, EVENT_SILVER_CAVE_ROOM_1_ULTRA_BALL

SilverCaveRoom1MaxElixer:
	itemball MAX_ELIXER

SilverCaveRoom1Protein:
	itemball PROTEIN

SilverCaveRoom1EscapeRope:
	itemball ESCAPE_ROPE

SilverCaveRoom1UltraBall:
	itemball ULTRA_BALL

SilverCaveRoom1HiddenDireHit:
	dwb EVENT_SILVER_CAVE_ROOM_1_HIDDEN_DIRE_HIT, DIRE_HIT


SilverCaveRoom1HiddenUltraBall:
	dwb EVENT_SILVER_CAVE_ROOM_1_HIDDEN_ULTRA_BALL, ULTRA_BALL
