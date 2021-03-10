VermilionHouseDiglettsCaveSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, VERMILION_CITY, 6
	warp_event  3,  7, VERMILION_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionDiglettsCaveSpeechHouseGentlemanText, -1

VermilionDiglettsCaveSpeechHouseGentlemanText:
	text "Over many years,"
	line "Diglett dug a"
	cont "large tunnel."

	para "That tunnel goes"
	line "to a distant town."
	done
