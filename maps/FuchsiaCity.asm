FuchsiaCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, FuchsiaCityFlyPoint

FuchsiaCity_MapEventHeader:

.Warps: db 11
	warp_def 13, 5, 2, FUCHSIA_MART
	warp_def 27, 8, 1, FUCHSIA_GYM
	warp_def 27, 11, 1, FUCHSIA_BILL_SPEECH_HOUSE
	warp_def 27, 19, 1, FUCHSIA_POKECENTER_1F
	warp_def 27, 27, 1, SAFARI_ZONE_WARDENS_HOME
	warp_def 3, 18, 3, SAFARI_ZONE_FUCHSIA_GATE
	warp_def 22, 37, 1, ROUTE_15_FUCHSIA_GATE
	warp_def 23, 37, 2, ROUTE_15_FUCHSIA_GATE
	warp_def 33, 7, 1, ROUTE_19_FUCHSIA_GATE
	warp_def 33, 8, 2, ROUTE_19_FUCHSIA_GATE
	warp_def 27, 15, 1, FUCHSIA_SAFARI_BALL_HOUSE

.XYTriggers: db 0

.Signposts: db 14
	signpost 15, 21, SIGNPOST_JUMPTEXT, FuchsiaCitySignText
	signpost 29, 5, SIGNPOST_JUMPTEXT, FuchsiaGymSignText
	signpost 15, 25, SIGNPOST_JUMPTEXT, SafariZoneOfficeSignText
	signpost 13, 22, SIGNPOST_JUMPTEXT, SafariZoneOfficeClosedSignText
	signpost 29, 27, SIGNPOST_JUMPTEXT, WardensHomeSignText
	signpost 5, 17, SIGNPOST_JUMPTEXT, SafariZoneClosedSignText
	signpost 19, 14, SIGNPOST_JUMPTEXT, NoLitteringSignText
	signpost 7, 7, SIGNPOST_JUMPTEXT, SafariZoneExhibitSignText
	signpost 7, 13, SIGNPOST_JUMPTEXT, SafariZoneExhibitSignText
	signpost 7, 27, SIGNPOST_JUMPTEXT, SafariZoneExhibitSignText
	signpost 7, 33, SIGNPOST_JUMPTEXT, SafariZoneExhibitSignText
	signpost 13, 31, SIGNPOST_JUMPTEXT, SafariZoneExhibitSignText
	signpost 27, 31, SIGNPOST_JUMPTEXT, HouseForSaleSignText
	signpost 35, 11, SIGNPOST_JUMPTEXT, FuchsiaCityCarefulSwimmingSignText

.PersonEvents: db 6
	person_event SPRITE_YOUNGSTER, 18, 23, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x194b45, -1
	person_event SPRITE_POKEFAN_M, 8, 10, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x194b83, -1
	person_event SPRITE_TEACHER, 13, 16, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x194bd3, -1
	person_event SPRITE_POKEFAN_F, 8, 28, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, FuchsiaCityPokefanFText, -1
	cuttree_event 19, 16, EVENT_FUCHSIA_CITY_CUT_TREE
	fruittree_event 17, 14, FRUITTREE_FUCHSIA_CITY, LIECHI_BERRY

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
