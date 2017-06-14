const_value set 2
	const ROUTE5_BREEDER
	const ROUTE5_POKEFAN_M

Route5_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PokefanMScript_0x1adb19:
	jumptextfaceplayer .Text

.Text:
	text "The road is closed"
	line "until the problem"

	para "at the Power Plant"
	line "is solved."
	done

Route5UndergroundPathSign:
	habitatlist .Text, UNDERGROUND

.Text:
	text "Underground Path"

	para "Cerulean City -"
	line "Vermilion City"
	done

Route5_MapEventHeader:
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
	db 1
	person_event SPRITE_POKEFAN_M, 28, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x1adb19, EVENT_ROUTE_5_6_POKEFAN_M_BLOCKS_UNDERGROUND_PATH
