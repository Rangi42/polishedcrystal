const_value set 2
	const SEAFOAMISLANDSB1F_POKE_BALL1
	const SEAFOAMISLANDSB1F_POKE_BALL2
	const SEAFOAMISLANDSB1F_BOULDER1
	const SEAFOAMISLANDSB1F_BOULDER2
	const SEAFOAMISLANDSB1F_BOULDER3
	const SEAFOAMISLANDSB1F_BOULDER4
	const SEAFOAMISLANDSB1F_BOULDER5
	const SEAFOAMISLANDSB1F_BOULDER6

SeafoamIslandsB1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SeafoamIslandsB1FKingsRock:
	itemball KINGS_ROCK

SeafoamIslandsB1FIceHeal:
	itemball ICE_HEAL

SeafoamIslandsB1FHiddenIceHeal:
	dwb EVENT_SEAFOAM_ISLANDS_B1F_HIDDEN_ICE_HEAL, ICE_HEAL

SeafoamIslandsB1FBoulder:
	jumpstd strengthboulder

SeafoamIslandsB1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $f, $23, 3, SEAFOAM_ISLANDS_1F
	warp_def $3, $3, 5, SEAFOAM_ISLANDS_1F
	warp_def $f, $1b, 1, SEAFOAM_ISLANDS_B2F
	warp_def $5, $12, 2, SEAFOAM_ISLANDS_B2F
	warp_def $b, $f, 3, SEAFOAM_ISLANDS_B2F
	warp_def $f, $7, 4, SEAFOAM_ISLANDS_B2F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 11, 20, SIGNPOST_ITEM, SeafoamIslandsB1FHiddenIceHeal

.PersonEvents:
	db 8
	person_event SPRITE_POKE_BALL, 3, 20, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, SeafoamIslandsB1FKingsRock, EVENT_SEAFOAM_ISLANDS_B1F_KINGS_ROCK
	person_event SPRITE_POKE_BALL, 5, 24, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, SeafoamIslandsB1FIceHeal, EVENT_SEAFOAM_ISLANDS_B1F_ICE_HEAL
	person_event SPRITE_BOULDER, 9, 30, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeafoamIslandsB1FBoulder, -1
	person_event SPRITE_BOULDER, 9, 31, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeafoamIslandsB1FBoulder, -1
	person_event SPRITE_BOULDER, 10, 32, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeafoamIslandsB1FBoulder, -1
	person_event SPRITE_BOULDER, 8, 12, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeafoamIslandsB1FBoulder, -1
	person_event SPRITE_BOULDER, 11, 7, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeafoamIslandsB1FBoulder, -1
	person_event SPRITE_BOULDER, 15, 13, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeafoamIslandsB1FBoulder, -1
