const_value set 2
	const QUIETCAVEB3F_POKE_BALL
	const QUIETCAVEB3F_FOSSIL1
	const QUIETCAVEB3F_FOSSIL2

QuietCaveB3F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

QuietCaveB3FTMFocusBlast:
	tmhmball TM_FOCUS_BLAST

QuietCaveB3FHelixFossil:
	itemball HELIX_FOSSIL

QuietCaveB3FDomeFossil:
	itemball DOME_FOSSIL

QuietCaveB3FHiddenPPUp:
	dwb EVENT_QUIET_CAVE_B3F_HIDDEN_PP_UP, PP_UP

QuietCaveB3FHiddenMaxRevive
	dwb EVENT_QUIET_CAVE_B3F_HIDDEN_MAX_REVIVE, MAX_REVIVE

QuietCaveB3F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $1f, $8, 5, QUIET_CAVE_B2F ; hole
	warp_def $7, $21, 6, QUIET_CAVE_B2F
	warp_def $9, $f, 4, QUIET_CAVE_B3F
	warp_def $b, $5, 3, QUIET_CAVE_B3F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 20, 16, SIGNPOST_ITEM, QuietCaveB3FHiddenPPUp
	signpost 22, 12, SIGNPOST_ITEM, QuietCaveB3FHiddenMaxRevive

.PersonEvents:
	db 3
	person_event SPRITE_POKE_BALL, 22, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TMHMBALL, 0, QuietCaveB3FTMFocusBlast, EVENT_QUIET_CAVE_B3F_TM_FOCUS_BLAST
	person_event SPRITE_FOSSIL, 5, 4, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, QuietCaveB3FHelixFossil, EVENT_QUIET_CAVE_B3F_HELIX_FOSSIL
	person_event SPRITE_FOSSIL, 5, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, QuietCaveB3FDomeFossil, EVENT_QUIET_CAVE_B3F_DOME_FOSSIL
