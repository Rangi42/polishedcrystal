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
	warp_def $1b, $10, 1, SAFARI_ZONE_FUCHSIA_GATE
	warp_def $1b, $11, 2, SAFARI_ZONE_FUCHSIA_GATE
	warp_def $c, $1f, 1, SAFARI_ZONE_EAST
	warp_def $d, $1f, 2, SAFARI_ZONE_EAST
	warp_def $c, $2, 5, SAFARI_ZONE_WEST
	warp_def $d, $2, 6, SAFARI_ZONE_WEST
	warp_def $2, $10, 5, SAFARI_ZONE_NORTH
	warp_def $2, $11, 6, SAFARI_ZONE_NORTH
	warp_def $15, $13, 1, SAFARI_ZONE_HUB_REST_HOUSE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 24, 16, SIGNPOST_READ, SafariZoneHubAreaSign
	signpost 22, 20, SIGNPOST_READ, SafariZoneHubRestHouseSign

.PersonEvents:
	db 2
	person_event SPRITE_BALL_CUT_FRUIT, 12, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SafariZoneHubNugget, EVENT_SAFARI_ZONE_HUB_NUGGET
	person_event SPRITE_BALL_CUT_FRUIT, 21, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SafariZoneHubUltraBall, EVENT_SAFARI_ZONE_HUB_ULTRA_BALL
