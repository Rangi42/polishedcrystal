const_value set 2

SafariZoneEast_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SafariZoneEastAreaSign:
	jumptext SafariZoneEastAreaSignText

SafariZoneEastRestHouseSign:
	jumptext SafariZoneEastRestHouseSignText

SafariZoneEastTrainerTipsSign:
	jumptext SafariZoneEastTrainerTipsSignText

SafariZoneEastCarbos:
	itemball CARBOS

SafariZoneEastSilverPowder:
	itemball SILVERPOWDER

SafariZoneEastFullRestore:
	itemball FULL_RESTORE

SafariZoneEastAreaSignText:
	text "Safari Zone"
	line "East Area"
	done

SafariZoneEastRestHouseSignText:
	text "Rest House"
	done

SafariZoneEastTrainerTipsSignText:
	text "Trainer Tips"

	para "Search for rare"
	line "#mon at night"
	cont "or in the morning!"
	done

SafariZoneEast_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $16, $0, 3, SAFARI_ZONE_HUB
	warp_def $17, $0, 4, SAFARI_ZONE_HUB
	warp_def $4, $0, 1, SAFARI_ZONE_NORTH
	warp_def $5, $0, 2, SAFARI_ZONE_NORTH
	warp_def $9, $19, 1, SAFARI_ZONE_EAST_REST_HOUSE

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 22, 4, SIGNPOST_READ, SafariZoneEastAreaSign
	signpost 10, 26, SIGNPOST_READ, SafariZoneEastRestHouseSign
	signpost 4, 6, SIGNPOST_READ, SafariZoneEastTrainerTipsSign

.PersonEvents:
	db 3
	person_event SPRITE_POKE_BALL, 13, 20, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, SafariZoneEastCarbos, EVENT_SAFARI_ZONE_EAST_CARBOS
	person_event SPRITE_POKE_BALL, 11, 5, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, SafariZoneEastSilverPowder, EVENT_SAFARI_ZONE_EAST_SILVERPOWDER
	person_event SPRITE_POKE_BALL, 1, 3, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, SafariZoneEastFullRestore, EVENT_SAFARI_ZONE_FULL_RESTORE
