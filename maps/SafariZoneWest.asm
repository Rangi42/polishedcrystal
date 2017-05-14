const_value set 2

SafariZoneWest_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SafariZoneWestAreaSign:
	jumptext SafariZoneWestAreaSignText

SafariZoneWestRestHouseSign:
	jumptext SafariZoneWestRestHouseSignText

SafariZoneWestTrainerTips1Sign:
	jumptext SafariZoneWestTrainerTips1SignText

SafariZoneWestTrainerTips2Sign:
	jumptext SafariZoneWestTrainerTips2SignText

SafariZoneWestAreaSignText:
	text "Safari Zone"
	line "West Area"
	done

SafariZoneWestRestHouseSignText:
	text "Rest House"
	done

SafariZoneWestTrainerTips1SignText:
	text "Trainer Tips"

	para "Fire-type Pokemon"
	line "cannot be burnt,"

	para "Electric types"
	line "can't be paralyzed,"

	para "and Ice types can't"
	line "be frozen solid."
	done

SafariZoneWestTrainerTips2SignText:
	text "Trainer Tips"

	para "TODO"
	done

SafariZoneWest_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 8
	warp_def $2, $16, 7, SAFARI_ZONE_NORTH
	warp_def $2, $17, 8, SAFARI_ZONE_NORTH
	warp_def $2, $1c, 3, SAFARI_ZONE_NORTH
	warp_def $2, $1d, 4, SAFARI_ZONE_NORTH
	warp_def $18, $1f, 5, SAFARI_ZONE_HUB
	warp_def $19, $1f, 6, SAFARI_ZONE_HUB
	warp_def $d, $d, 1, SAFARI_ZONE_WEST_REST_HOUSE_1
	warp_def $5, $5, 1, SAFARI_ZONE_WEST_REST_HOUSE_2

.XYTriggers:
	db 0

.Signposts:
	db 4
	signpost 24, 26, SIGNPOST_READ, SafariZoneWestAreaSign
	signpost 14, 14, SIGNPOST_READ, SafariZoneWestRestHouseSign
	signpost 6, 28, SIGNPOST_READ, SafariZoneWestTrainerTips1Sign
	signpost 5, 19, SIGNPOST_READ, SafariZoneWestTrainerTips2Sign

.PersonEvents:
	db 0
