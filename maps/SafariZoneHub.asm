SafariZoneHub_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SafariZoneHub_MapEventHeader:

.Warps: db 9
	warp_def $1b, $10, 1, SAFARI_ZONE_FUCHSIA_GATE
	warp_def $1b, $11, 2, SAFARI_ZONE_FUCHSIA_GATE
	warp_def $c, $1f, 1, SAFARI_ZONE_EAST
	warp_def $d, $1f, 2, SAFARI_ZONE_EAST
	warp_def $c, $2, 5, SAFARI_ZONE_WEST
	warp_def $d, $2, 6, SAFARI_ZONE_WEST
	warp_def $2, $10, 5, SAFARI_ZONE_NORTH
	warp_def $2, $11, 6, SAFARI_ZONE_NORTH
	warp_def $15, $13, 1, SAFARI_ZONE_HUB_REST_HOUSE

.XYTriggers: db 0

.Signposts: db 2
	signpost 24, 16, SIGNPOST_READ, SafariZoneHubAreaSign
	signpost 22, 20, SIGNPOST_READ, SafariZoneHubRestHouseSign

.PersonEvents: db 3
	person_event SPRITE_BUG_MANIAC, 6, 26, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerBug_maniacKai, -1
	person_event SPRITE_BALL_CUT_FRUIT, 12, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SafariZoneHubNugget, EVENT_SAFARI_ZONE_HUB_NUGGET
	person_event SPRITE_BALL_CUT_FRUIT, 21, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SafariZoneHubUltraBall, EVENT_SAFARI_ZONE_HUB_ULTRA_BALL

TrainerBug_maniacKai:
	trainer EVENT_BEAT_BUG_MANIAC_KAI, BUG_MANIAC, KAI, Bug_maniacKaiSeenText, Bug_maniacKaiBeatenText, 0, Bug_maniacKaiScript

Bug_maniacKaiScript:
	end_if_just_battled
	opentext
	writetext Bug_maniacKaiAfterText
	waitbutton
	closetext
	end

SafariZoneHubNugget:
	itemball NUGGET

SafariZoneHubUltraBall:
	itemball ULTRA_BALL

SafariZoneHubAreaSign:
	jumptext SafariZoneHubAreaSignText

SafariZoneHubRestHouseSign:
	jumptext SafariZoneHubRestHouseSignText

Bug_maniacKaiSeenText:
	text "My Venonat evolved"
	line "into a Venomoth?!"
	done

Bug_maniacKaiBeatenText:
	text "I thought it would"
	line "for sure evolve"
	cont "into Butterfree!"
	done

Bug_maniacKaiAfterText:
	text "Venonat is so"
	line "similar to"
	cont "Butterfree!"

	para "Their weight,"
	line "their eyes,"
	cont "their abilities…"

	para "Evolution is"
	line "weird sometimes."
	done

SafariZoneHubAreaSignText:
	text "Safari Zone"
	line "Center Area"
	done

SafariZoneHubRestHouseSignText:
	text "Rest House"
	done
