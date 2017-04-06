const_value set 2
	const SAFARIZONEHUB_POKE_BALL1
	const SAFARIZONEHUB_POKE_BALL2

SafariZoneHub_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SafariZoneHubAreaSign:
	jumptext SafariZoneHubAreaSignText

SafariZoneHubRestHouseSign:
	jumptext SafariZoneHubRestHouseSignText

SafariZoneHubNugget:
	itemball NUGGET

SafariZoneHubUltraBall:
	itemball ULTRA_BALL

SafariZoneHubAreaSignText:
	text "Safari Zone"
	line "Center Area"
	done

SafariZoneHubRestHouseSignText:
	text "Rest House"
	done

SafariZoneHub_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 9
	warp_def $19, $e, 1, SAFARI_ZONE_FUCHSIA_GATE
	warp_def $19, $f, 2, SAFARI_ZONE_FUCHSIA_GATE
	warp_def $a, $1d, 1, SAFARI_ZONE_EAST
	warp_def $b, $1d, 2, SAFARI_ZONE_EAST
	warp_def $0, $4, 3, SAFARI_ZONE_NORTH
	warp_def $0, $5, 4, SAFARI_ZONE_NORTH
	warp_def $0, $e, 5, SAFARI_ZONE_NORTH
	warp_def $0, $f, 6, SAFARI_ZONE_NORTH
	warp_def $13, $11, 1, SAFARI_ZONE_HUB_REST_HOUSE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 22, 14, SIGNPOST_READ, SafariZoneHubAreaSign
	signpost 20, 18, SIGNPOST_READ, SafariZoneHubRestHouseSign

.PersonEvents:
	db 2
	person_event SPRITE_BALL_CUT_FRUIT, 10, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SafariZoneHubNugget, EVENT_SAFARI_ZONE_HUB_NUGGET
	person_event SPRITE_BALL_CUT_FRUIT, 19, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SafariZoneHubUltraBall, EVENT_SAFARI_ZONE_HUB_ULTRA_BALL
