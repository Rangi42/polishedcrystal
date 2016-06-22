const_value set 2
	const QUIETCAVEB1F_POKE_BALL1
	const QUIETCAVEB1F_POKE_BALL2

QuietCaveB1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

QuietCaveB1FBigPearl:
	itemball BIG_PEARL

QuietCaveB1FElixir:
	itemball ELIXER

QuietCaveB1FHiddenHyperPotion:
	dwb EVENT_QUIET_CAVE_B1F_HIDDEN_HYPER_POTION, HYPER_POTION

QuietCaveB1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 9
	warp_def $19, $5, 2, QUIET_CAVE_1F
	warp_def $17, $1d, 3, QUIET_CAVE_1F
	warp_def $b, $13, 4, QUIET_CAVE_1F
	warp_def $f, $3, 5, QUIET_CAVE_1F
	warp_def $f, $1f, 6, QUIET_CAVE_1F
	warp_def $3, $15, 1, QUIET_CAVE_B2F
	warp_def $19, $11, 2, QUIET_CAVE_B2F
	warp_def $21, $17, 3, QUIET_CAVE_B2F
	warp_def $2, $20, 4, QUIET_CAVE_B2F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 33, 26, SIGNPOST_ITEM, QuietCaveB1FHiddenHyperPotion

.PersonEvents:
	db 2
	person_event SPRITE_POKE_BALL, 3, 8, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, QuietCaveB1FBigPearl, EVENT_QUIET_CAVE_B1F_BIG_PEARL
	person_event SPRITE_POKE_BALL, 13, 14, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, QuietCaveB1FElixir, EVENT_QUIET_CAVE_B1F_ELIXIR
