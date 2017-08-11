LavenderTown_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, LavenderTownFlyPoint

LavenderTown_MapEventHeader:

.Warps: db 7
	warp_def $7, $5, 1, LAVENDER_POKECENTER_1F
	warp_def $b, $5, 1, MR_FUJIS_HOUSE
	warp_def $f, $3, 1, LAVENDER_TOWN_SPEECH_HOUSE
	warp_def $f, $7, 1, LAVENDER_NAME_RATER
	warp_def $7, $1, 2, LAVENDER_MART
	warp_def $d, $d, 1, SOUL_HOUSE
	warp_def $7, $e, 1, LAV_RADIO_TOWER_1F

.XYTriggers: db 0

.Signposts: db 4
	signpost 5, 11, SIGNPOST_JUMPTEXT, LavenderTownSignText
	signpost 9, 15, SIGNPOST_JUMPTEXT, KantoRadioStationSignText
	signpost 11, 3, SIGNPOST_JUMPTEXT, VolunteerPokemonHouseSignText
	signpost 15, 15, SIGNPOST_JUMPTEXT, SoulHouseSignText

.PersonEvents: db 4
	person_event SPRITE_POKEFAN_M, 9, 12, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x1ad702, -1
	person_event SPRITE_TEACHER, 17, 2, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x1ad73a, -1
	person_event SPRITE_GRAMPS, 14, 14, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x1ad75c, -1
	person_event SPRITE_YOUNGSTER, 13, 6, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_JUMPTEXTFP, 1, UnknownText_0x1ad7ac, -1

LavenderTownFlyPoint:
	setflag ENGINE_FLYPOINT_LAVENDER
	return

UnknownText_0x1ad702:
	text "That's quite some"
	line "building, eh?"

	para "It's Kanto's Radio"
	line "Tower."
	done

UnknownText_0x1ad73a:
	text "Kanto has many"
	line "good radio shows."
	done

UnknownText_0x1ad75c:
	text "People come from"
	line "all over to pay"

	para "their respects to"
	line "the departed souls"
	cont "of #mon."
	done

UnknownText_0x1ad7ac:
	text "You need a #"
	line "Flute to wake"
	cont "sleeping #mon."

	para "Every trainer has"
	line "to know that!"
	done

LavenderTownSignText:
	text "Lavender Town"

	para "The Noble Purple"
	line "Town"
	done

KantoRadioStationSignText:
	text "Kanto Radio"
	line "Station"

	para "Your Favorite"
	line "Programs On-Air"
	cont "Around the Clock!"
	done

VolunteerPokemonHouseSignText:
	text "Lavender Volunteer"
	line "#mon House"
	done

SoulHouseSignText:
	text "House of Memories"

	para "May the Souls of"
	line "#mon Rest Easy"
	done
