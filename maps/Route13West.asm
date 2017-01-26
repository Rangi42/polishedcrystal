const_value set 2
	const ROUTE13WEST_POKEFAN_M1
	const ROUTE13WEST_POKEFAN_M2

Route13West_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerHikerKenny:
	trainer EVENT_BEAT_HIKER_KENNY, HIKER, KENNY, HikerKennySeenText, HikerKennyBeatenText, 0, HikerKennyScript

HikerKennyScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a26c2
	waitbutton
	closetext
	end

Route13DirectionsSign:
	jumptext Route13DirectionsSignText

HikerKennySeenText:
	text "I should go to"
	line "Rock Tunnel to get"
	cont "myself an Onix."
	done

HikerKennyBeatenText:
	text "I lost…"
	done

UnknownText_0x1a26c2:
	text "Geological fea-"
	line "tures don't appear"
	cont "to change."

	para "But they actually"
	line "change, little by"
	cont "little."
	done

Route13DirectionsSignText:
	text "North to Lavender"
	line "Town"

	para "West to Fuchsia"
	line "City"
	done

Route13West_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 13, 17, SIGNPOST_READ, Route13DirectionsSign

.PersonEvents:
	db 2
	person_event SPRITE_POKEFAN_M, 10, 14, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerHikerKenny, -1
	person_event SPRITE_POKEFAN_M, 6, 25, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
