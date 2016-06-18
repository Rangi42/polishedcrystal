const_value set 2
	const SAFARIZONENORTH_POKE_BALL1
	const SAFARIZONENORTH_POKE_BALL2

SafariZoneNorth_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SafariZoneNorthAreaSign:
	jumptext SafariZoneNorthAreaSignText

SafariZoneNorthRestHouseSign:
	jumptext SafariZoneNorthRestHouseSignText

SafariZoneNorthTrainerTips1Sign:
	jumptext SafariZoneNorthTrainerTips1SignText

SafariZoneNorthTrainerTips2Sign:
	jumptext SafariZoneNorthTrainerTips2SignText

SafariZoneNorthQuickClaw:
	itemball QUICK_CLAW

SafariZoneNorthProtein:
	itemball PROTEIN

SafariZoneNorthHiddenLuckyPunch:
	dwb EVENT_SAFARI_ZONE_NORTH_HIDDEN_LUCKY_PUNCH, LUCKY_PUNCH

SafariZoneNorthAreaSignText:
	text "Safari Zone"
	line "North Area"
	done

SafariZoneNorthRestHouseSignText:
	text "Rest House"
	done

SafariZoneNorthTrainerTips1SignText:
	text "Trainer Tips"

	para "Moves of the same"
	line "type can be"
	cont "physical, special,"
	cont "or status-based."
	done

SafariZoneNorthTrainerTips2SignText:
	text "Trainer Tips"

	para "#mon hide in"
	line "tall grass!"

	para "Zigzag through"
	line "grassy areas to"
	cont "flush them out."
	done

SafariZoneNorth_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 7
	warp_def $1a, $1d, 3, SAFARI_ZONE_EAST
	warp_def $1b, $1d, 4, SAFARI_ZONE_EAST
	warp_def $1f, $4, 5, SAFARI_ZONE_HUB
	warp_def $1f, $5, 6, SAFARI_ZONE_HUB
	warp_def $1f, $e, 7, SAFARI_ZONE_HUB
	warp_def $1f, $f, 8, SAFARI_ZONE_HUB
	warp_def $3, $19, 1, SAFARI_ZONE_NORTH_REST_HOUSE

.XYTriggers:
	db 0

.Signposts:
	db 5
	signpost 27, 9, SIGNPOST_READ, SafariZoneNorthAreaSign
	signpost 4, 26, SIGNPOST_READ, SafariZoneNorthRestHouseSign
	signpost 24, 20, SIGNPOST_READ, SafariZoneNorthTrainerTips1Sign
	signpost 29, 13, SIGNPOST_READ, SafariZoneNorthTrainerTips2Sign
	signpost 13, 23, SIGNPOST_ITEM, SafariZoneNorthHiddenLuckyPunch

.PersonEvents:
	db 2
	person_event SPRITE_POKE_BALL, 12, 18, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, SafariZoneNorthQuickClaw, EVENT_SAFARI_ZONE_NORTH_QUICK_CLAW
	person_event SPRITE_POKE_BALL, 3, 11, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, SafariZoneNorthProtein, EVENT_SAFARI_ZONE_NORTH_PROTEIN
