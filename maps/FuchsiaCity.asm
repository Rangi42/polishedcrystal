FuchsiaCity_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, FuchsiaCityFlyPoint

	db 11 ; warp events
	warp_event  5, 13, FUCHSIA_MART, 2
	warp_event  8, 27, FUCHSIA_GYM, 1
	warp_event 11, 27, FUCHSIA_BILL_SPEECH_HOUSE, 1
	warp_event 19, 27, FUCHSIA_POKECENTER_1F, 1
	warp_event 27, 27, SAFARI_ZONE_WARDENS_HOME, 1
	warp_event 18,  3, SAFARI_ZONE_FUCHSIA_GATE, 3
	warp_event 37, 22, ROUTE_15_FUCHSIA_GATE, 1
	warp_event 37, 23, ROUTE_15_FUCHSIA_GATE, 2
	warp_event  7, 33, ROUTE_19_FUCHSIA_GATE, 1
	warp_event  8, 33, ROUTE_19_FUCHSIA_GATE, 2
	warp_event 15, 27, FUCHSIA_SAFARI_BALL_HOUSE, 1

	db 0 ; coord events

	db 14 ; bg events
	bg_event 21, 15, SIGNPOST_JUMPTEXT, FuchsiaCitySignText
	bg_event  5, 29, SIGNPOST_JUMPTEXT, FuchsiaGymSignText
	bg_event 25, 15, SIGNPOST_JUMPTEXT, SafariZoneOfficeSignText
	bg_event 22, 13, SIGNPOST_JUMPTEXT, SafariZoneOfficeClosedSignText
	bg_event 27, 29, SIGNPOST_JUMPTEXT, WardensHomeSignText
	bg_event 17,  5, SIGNPOST_JUMPTEXT, SafariZoneClosedSignText
	bg_event 14, 19, SIGNPOST_JUMPTEXT, NoLitteringSignText
	bg_event  7,  7, SIGNPOST_JUMPTEXT, SafariZoneExhibitSignText
	bg_event 13,  7, SIGNPOST_JUMPTEXT, SafariZoneExhibitSignText
	bg_event 27,  7, SIGNPOST_JUMPTEXT, SafariZoneExhibitSignText
	bg_event 33,  7, SIGNPOST_JUMPTEXT, SafariZoneExhibitSignText
	bg_event 31, 13, SIGNPOST_JUMPTEXT, SafariZoneExhibitSignText
	bg_event 31, 27, SIGNPOST_JUMPTEXT, HouseForSaleSignText
	bg_event 11, 35, SIGNPOST_JUMPTEXT, FuchsiaCityCarefulSwimmingSignText

	db 6 ; object events
	object_event 23, 18, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x194b45, -1
	object_event 10,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 1, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x194b83, -1
	object_event 16, 13, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x194bd3, -1
	object_event 28,  8, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, FuchsiaCityPokefanFText, -1
	cuttree_event 16, 19, EVENT_FUCHSIA_CITY_CUT_TREE
	fruittree_event 14, 17, FRUITTREE_FUCHSIA_CITY, LIECHI_BERRY

FuchsiaCityFlyPoint:
	setflag ENGINE_FLYPOINT_FUCHSIA
	return

UnknownText_0x194b45:
	text "One of the Elite"
	line "Four used to be"

	para "the Leader of"
	line "Fuchsia's Gym."
	done

UnknownText_0x194b83:
	text "Koga's daughter"
	line "succeeded him as"

	para "the Gym Leader"
	line "after he joined"
	cont "the Elite Four."
	done

UnknownText_0x194bd3:
	text "The Safari Game is"
	line "canceled…"

	para "At least the"
	line "Safari Zone is"
	cont "still open."

	para "You'll need a"
	line "strong #mon"

	para "to explore it,"
	line "though."
	done

FuchsiaCityPokefanFText:
	text "When the Safari"
	line "Zone Warden left,"

	para "there was nobody"
	line "to maintain the"
	cont "town zoo."

	para "So the #mon"
	line "were released back"
	cont "into the wild."
	done

FuchsiaCitySignText:
	text "Fuchsia City"

	para "Behold! It's"
	line "Passion Pink!"
	done

FuchsiaGymSignText:
	text "Fuchsia City"
	line "#mon Gym"
	cont "Leader: Janine"

	para "The Poisonous"
	line "Ninja Master"
	done

SafariZoneOfficeSignText:
	text "There's a notice"
	line "here…"

	para "Safari Zone Office"
	line "is closed until"
	cont "further notice."
	done

SafariZoneOfficeClosedSignText:
	text "It's locked…"
	done

WardensHomeSignText:
	text "Safari Zone"
	line "Warden's Home"
	done

SafariZoneClosedSignText:
	text "The Warden is"
	line "traveling abroad."

	para "Therefore, the"
	line "Safari Game is"
	cont "canceled."
	done

NoLitteringSignText:
	text "No littering."

	para "Please take your"
	line "waste with you."
	done

SafariZoneExhibitSignText:
	text "The sign has been"
	line "torn away…"
	done

HouseForSaleSignText:
	text "What's this?"

	para "House for Sale…"
	line "Nobody lives here."
	done

FuchsiaCityCarefulSwimmingSignText:
	text "Please be careful"
	line "if you are swim-"
	cont "ming to Seafoam"
	cont "Islands."

	para "Fuchsia Police"
	done
