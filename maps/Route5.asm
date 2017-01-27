const_value set 2
	const ROUTE5_BREEDER
	const ROUTE5_POKEFAN_M

Route5_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_OBJECTS, .RebattleBreeder

.RebattleBreeder:
	clearevent EVENT_BEAT_BREEDER_CARLENE
	return

TrainerBreederCarlene:
	trainer EVENT_BEAT_BREEDER_CARLENE, BREEDER, CARLENE, BreederCarleneSeenText, BreederCarleneBeatenText, 0, BreederCarleneScript

BreederCarleneScript:
	end_if_just_battled
	opentext
	writetext BreederCarleneAfterText
	waitbutton
	closetext
	end

PokefanMScript_0x1adb19:
	jumptextfaceplayer UnknownText_0x1adb22

Route5UndergroundPathSign:
	jumptext Route5UndergroundPathSignText

BreederCarleneSeenText:
	text "My team is bred"
	line "to handle any"
	cont "situation!"
	done

BreederCarleneBeatenText:
	text "We couldn't"
	line "handle you!"
	done

BreederCarleneAfterText:
	text "I make my Smeargle"
	line "Sketch a move,"

	para "then breed it"
	line "to pass the move"
	cont "down!"

	para "Isn't that smart?"
	done

UnknownText_0x1adb22:
	text "The road is closed"
	line "until the problem"

	para "at the Power Plant"
	line "is solved."
	done

Route5UndergroundPathSignText:
	text "Underground Path"

	para "Cerulean City -"
	line "Vermilion City"
	done

Route5_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $1b, $11, 1, ROUTE_5_UNDERGROUND_ENTRANCE
	warp_def $1f, $8, 1, ROUTE_5_SAFFRON_CITY_GATE
	warp_def $1f, $9, 2, ROUTE_5_SAFFRON_CITY_GATE
	warp_def $15, $a, 1, ROUTE_5_CLEANSE_TAG_SPEECH_HOUSE

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 29, 17, SIGNPOST_READ, Route5UndergroundPathSign

.PersonEvents:
	db 2
	person_event SPRITE_BREEDER, 10, 13, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 5, TrainerBreederCarlene, -1
	person_event SPRITE_POKEFAN_M, 28, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x1adb19, EVENT_ROUTE_5_6_POKEFAN_M_BLOCKS_UNDERGROUND_PATH
