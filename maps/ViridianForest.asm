const_value set 2
	const VIRIDIAN_FOREST_POKE_BALL1
	const VIRIDIAN_FOREST_POKE_BALL2

ViridianForest_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

MapViridianForestSignpost1Script:
	jumptext ViridianForestSignText1

MapViridianForestSignpost2Script:
	jumptext ViridianForestSignText2

MapViridianForestSignpost3Script:
	jumptext ViridianForestSignText3

MapViridianForestSignpost4Script:
	jumptext ViridianForestSignText4

MapViridianForestSignpost5Script:
	jumptext ViridianForestSignText5

MapViridianForestSignpost6Script:
	jumptext ViridianForestSignText6

ViridianForestDireHit:
	itemball DIRE_HIT

ViridianForestMaxPotion:
	itemball MAX_POTION

ViridianForestHiddenMaxEther:
	dwb EVENT_ROUTE_2_HIDDEN_MAX_ETHER, MAX_ETHER

ViridianForestHiddenFullHeal:
	dwb EVENT_ROUTE_2_HIDDEN_FULL_HEAL, FULL_HEAL

ViridianForestHiddenFullRestore:
	dwb EVENT_ROUTE_2_HIDDEN_FULL_RESTORE, FULL_RESTORE

ViridianForestHiddenRevive:
	dwb EVENT_ROUTE_2_HIDDEN_REVIVE, REVIVE

ViridianForestSignText1:
	text "Leaving"
	line "Viridian Forest"
	cont "Pewter City Ahead"
	done

ViridianForestSignText2:
	text "Trainer Tips"

	para "No stealing of"
	line "#mon from"
	cont "other trainers!"
	cont "Catch only wild"
	cont "#mon!"
	done

ViridianForestSignText3:
	text "Trainer Tips"

	para "Contact Prof.Oak"
	line "via PC to get"
	cont "your #dex"
	cont "evaluated!"
	done

ViridianForestSignText4:
	text "For poison, use"
	line "Antidote! Get it"
	cont "at #mon Marts!"
	done

ViridianForestSignText5:
	text "Trainer Tips"

	para "If you want to"
	line "avoid battles,"
	cont "stay away from"
	cont "grassy areas!"
	done

ViridianForestSignText6:
	text "Trainer Tips"

	para "Weaken #mon"
	line "before attempting"
	cont "capture!"

	para "When healthy,"
	line "they may escape!"
	done

ViridianForest_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $3, $1, 1, VIRIDIAN_FOREST_PEWTER_GATE
	warp_def $2D, $11, 1, VIRIDIAN_FOREST_VIRIDIAN_GATE
	warp_def $2D, $12, 2, VIRIDIAN_FOREST_VIRIDIAN_GATE

.XYTriggers:
	db 0

.Signposts:
	db 10
	signpost 5, 2, SIGNPOST_READ, MapViridianForestSignpost1Script
	signpost 24, 4, SIGNPOST_READ, MapViridianForestSignpost2Script
	signpost 17, 26, SIGNPOST_READ, MapViridianForestSignpost3Script
	signpost 32, 16, SIGNPOST_READ, MapViridianForestSignpost4Script
	signpost 40, 24, SIGNPOST_READ, MapViridianForestSignpost5Script
	signpost 42, 18, SIGNPOST_READ, MapViridianForestSignpost6Script
	signpost 42, 30, SIGNPOST_ITEM, ViridianForestHiddenMaxEther
	signpost 40, 16, SIGNPOST_ITEM, ViridianForestHiddenFullHeal
	signpost 41, 2, SIGNPOST_ITEM, ViridianForestHiddenFullRestore
	signpost 7, 28, SIGNPOST_ITEM, ViridianForestHiddenRevive

.PersonEvents:
	db 2
	person_event SPRITE_POKE_BALL, 29, 12, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, ViridianForestDireHit, EVENT_ROUTE_2_DIRE_HIT
	person_event SPRITE_POKE_BALL, 31, 1, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, ViridianForestMaxPotion, EVENT_ROUTE_2_MAX_POTION
