Route30BerrySpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_30, 1
	warp_event  3,  7, ROUTE_30, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route30BerryHousePokefanMScript, -1

Route30BerryHousePokefanMScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_MULCH_FROM_ROUTE_30_HOUSE
	iftrue UnknownScript_0x196d79
	writetext Route30BerrySpeechHouseMonEatBerriesText
	buttonsound
	verbosegiveitem MULCH
	iffalse UnknownScript_0x196d7d
	setevent EVENT_GOT_MULCH_FROM_ROUTE_30_HOUSE
UnknownScript_0x196d79:
	writetext Route30BerrySpeechHouseCheckTreesText
	waitbutton
UnknownScript_0x196d7d:
	endtext

Route30BerrySpeechHouseMonEatBerriesText:
	text "You know, #mon"
	line "eat Berries."

	para "They take time to"
	line "grow back when"
	cont "they're picked,"

	para "but using Mulch"
	line "on the soil really"
	cont "speeds that up!"

	para "Here. I'll share"
	line "some with you!"
	done

Route30BerrySpeechHouseCheckTreesText:
	text "I buy top-quality"
	line "Mulch in Goldenrod"
	cont "City."
	done
