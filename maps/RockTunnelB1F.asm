const_value set 2
	const ROCKTUNNELB1F_POKE_BALL1
	const ROCKTUNNELB1F_POKE_BALL2
	const ROCKTUNNELB1F_POKE_BALL3
	const ROCKTUNNELB1F_BOULDER

RockTunnelB1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

RockTunnelB1FIron:
	itemball IRON

RockTunnelB1FPPUp:
	itemball PP_UP

RockTunnelB1FRevive:
	itemball REVIVE

RockTunnelB1FHiddenMaxPotion:
	dwb EVENT_ROCK_TUNNEL_B1F_HIDDEN_MAX_POTION, MAX_POTION

RockTunnelB1FBoulder:
	jumpstd strengthboulder

RockTunnelB1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $3, $3, 3, ROCK_TUNNEL_1F
	warp_def $9, $11, 4, ROCK_TUNNEL_1F
	warp_def $3, $17, 5, ROCK_TUNNEL_1F
	warp_def $13, $1b, 6, ROCK_TUNNEL_1F
	warp_def $d, $3, 7, ROCK_TUNNEL_1F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 18, 3, SIGNPOST_ITEM, RockTunnelB1FHiddenMaxPotion

.PersonEvents:
	db 4
	person_event SPRITE_POKE_BALL, 24, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, RockTunnelB1FIron, EVENT_ROCK_TUNNEL_B1F_IRON
	person_event SPRITE_POKE_BALL, 4, 8, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, RockTunnelB1FPPUp, EVENT_ROCK_TUNNEL_B1F_PP_UP
	person_event SPRITE_POKE_BALL, 2, 15, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, RockTunnelB1FRevive, EVENT_ROCK_TUNNEL_B1F_REVIVE
	person_event SPRITE_BOULDER, 25, 10, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, RockTunnelB1FBoulder, -1
