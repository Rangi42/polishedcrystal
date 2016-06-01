const_value set 2
	const ROUTE47_POKE_BALL1
	const ROUTE47_POKE_BALL2
	const ROUTE47_POKE_BALL3
	const ROUTE47_POKE_BALL4

Route47_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route47QuietCaveSign:
	jumptext Route47QuietCaveSignText

Route47Revive:
	itemball REVIVE

Route47MysticWater:
	itemball MYSTIC_WATER

Route47QuickClaw:
	itemball QUICK_CLAW

Route47MaxRepel:
	itemball MAX_REPEL

Route47HiddenPearl:
	dwb EVENT_ROUTE_47_HIDDEN_PEARL, PEARL

Route47HiddenStardust:
	dwb EVENT_ROUTE_47_HIDDEN_STARDUST, STARDUST

Route47QuietCaveSignText:
	text "West to"
	line "Quiet Cave"
	done

Route47_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $15, $43, 2, CLIFF_EDGE_GATE
	warp_def $15, $35, 1, CLIFF_CAVE
	warp_def $11, $33, 2, CLIFF_CAVE
	warp_def $1d, $35, 3, CLIFF_CAVE

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 32, 36, SIGNPOST_READ, Route47QuietCaveSign
	signpost 33, 34, SIGNPOST_ITEM, Route47HiddenPearl
	signpost 28, 12, SIGNPOST_ITEM, Route47HiddenStardust

.PersonEvents:
	db 4
	person_event SPRITE_POKE_BALL, 28, 39, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route47Revive, EVENT_ROUTE_47_REVIVE
	person_event SPRITE_POKE_BALL, 32, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route47MysticWater, EVENT_ROUTE_47_MYSTIC_WATER
	person_event SPRITE_POKE_BALL, 20, 31, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route47QuickClaw, EVENT_ROUTE_47_QUICK_CLAW
	person_event SPRITE_POKE_BALL, 6, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route47MaxRepel, EVENT_ROUTE_47_MAX_REPEL
