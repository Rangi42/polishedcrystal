const_value set 2
	const FUCHSIACITY_YOUNGSTER
	const FUCHSIACITY_POKEFAN_M
	const FUCHSIACITY_TEACHER
	const FUCHSIACITY_FRUIT_TREE

FuchsiaCity_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks
	dbw MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_FUCHSIA
	return

YoungsterScript_0x194b22:
	jumptextfaceplayer UnknownText_0x194b45

PokefanMScript_0x194b25:
	jumptextfaceplayer UnknownText_0x194b83

TeacherScript_0x194b28:
	jumptextfaceplayer UnknownText_0x194bd3

FuchsiaCitySign:
	jumptext FuchsiaCitySignText

FuchsiaGymSign:
	jumptext FuchsiaGymSignText

SafariZoneOfficeSign:
	jumptext SafariZoneOfficeSignText

WardensHomeSign:
	jumptext WardensHomeSignText

SafariZoneClosedSign:
	jumptext SafariZoneClosedSignText

NoLitteringSign:
	jumptext NoLitteringSignText

FuchsiaCityPokeCenterSign:
	jumpstd pokecentersign

FuchsiaCityMartSign:
	jumpstd martsign

FruitTreeScript_0x194b43:
	fruittree FRUITTREE_FUCHSIA_CITY

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
	text "The Safari Zone is"
	line "closed… It's sad,"

	para "considering it's"
	line "Fuchsia's main"
	cont "attraction."
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

WardensHomeSignText:
	text "Safari Zone"
	line "Warden's Home"
	done

SafariZoneClosedSignText:
	text "The Warden is"
	line "traveling abroad."

	para "Therefore, the"
	line "Safari Zone is"
	cont "closed."
	done

NoLitteringSignText:
	text "No littering."

	para "Please take your"
	line "waste with you."
	done

FuchsiaCity_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 11
	warp_def $d, $5, 2, FUCHSIA_MART
	warp_def $d, $16, 1, SAFARI_ZONE_MAIN_OFFICE
	warp_def $1b, $8, 1, FUCHSIA_GYM
	warp_def $1b, $b, 1, FUCHSIA_BILL_SPEECH_HOUSE
	warp_def $1b, $13, 1, FUCHSIA_POKECENTER_1F
	warp_def $1b, $1b, 1, SAFARI_ZONE_WARDENS_HOME
	warp_def $3, $12, 1, FUCHSIA_POKECENTER_1F ; SAFARI_ZONE_FUCHSIA_GATE_BETA
	warp_def $16, $25, 1, ROUTE_15_FUCHSIA_GATE
	warp_def $17, $25, 2, ROUTE_15_FUCHSIA_GATE
	warp_def $23, $7, 1, ROUTE_19___FUCHSIA_GATE
	warp_def $23, $8, 2, ROUTE_19___FUCHSIA_GATE

.XYTriggers:
	db 0

.Signposts:
	db 8
	signpost 15, 21, SIGNPOST_READ, FuchsiaCitySign
	signpost 29, 5, SIGNPOST_READ, FuchsiaGymSign
	signpost 15, 25, SIGNPOST_READ, SafariZoneOfficeSign
	signpost 29, 27, SIGNPOST_READ, WardensHomeSign
	signpost 5, 17, SIGNPOST_READ, SafariZoneClosedSign
	signpost 15, 13, SIGNPOST_READ, NoLitteringSign
	signpost 27, 20, SIGNPOST_READ, FuchsiaCityPokeCenterSign
	signpost 13, 6, SIGNPOST_READ, FuchsiaCityMartSign

.PersonEvents:
	db 4
	person_event SPRITE_YOUNGSTER, 18, 23, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x194b22, -1
	person_event SPRITE_POKEFAN_M, 8, 13, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x194b25, -1
	person_event SPRITE_TEACHER, 14, 16, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, TeacherScript_0x194b28, -1
	person_event SPRITE_FRUIT_TREE, 1, 8, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FruitTreeScript_0x194b43, -1
