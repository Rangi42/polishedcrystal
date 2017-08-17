SafariZoneHub_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SafariZoneHub_MapEventHeader:

.Warps: db 9
	warp_def 27, 16, 1, SAFARI_ZONE_FUCHSIA_GATE
	warp_def 27, 17, 2, SAFARI_ZONE_FUCHSIA_GATE
	warp_def 12, 31, 1, SAFARI_ZONE_EAST
	warp_def 13, 31, 2, SAFARI_ZONE_EAST
	warp_def 12, 2, 5, SAFARI_ZONE_WEST
	warp_def 13, 2, 6, SAFARI_ZONE_WEST
	warp_def 2, 16, 5, SAFARI_ZONE_NORTH
	warp_def 2, 17, 6, SAFARI_ZONE_NORTH
	warp_def 21, 19, 1, SAFARI_ZONE_HUB_REST_HOUSE

.XYTriggers: db 0

.Signposts: db 2
	signpost 24, 16, SIGNPOST_JUMPTEXT, SafariZoneHubAreaSignText
	signpost 22, 20, SIGNPOST_JUMPTEXT, SafariZoneHubRestHouseSignText

.PersonEvents: db 3
	person_event SPRITE_BUG_MANIAC, 6, 26, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerBug_maniacKai, -1
	itemball_event 12, 15, NUGGET, 1, EVENT_SAFARI_ZONE_HUB_NUGGET
	itemball_event 21, 8, ULTRA_BALL, 1, EVENT_SAFARI_ZONE_HUB_ULTRA_BALL

TrainerBug_maniacKai:
	trainer EVENT_BEAT_BUG_MANIAC_KAI, BUG_MANIAC, KAI, Bug_maniacKaiSeenText, Bug_maniacKaiBeatenText, 0, Bug_maniacKaiScript

Bug_maniacKaiScript:
	end_if_just_battled
	jumptextfaceplayer Bug_maniacKaiAfterText

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
