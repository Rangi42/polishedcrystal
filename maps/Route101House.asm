Route101House_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, ROUTE_101, 3
	warp_event  4,  7, ROUTE_101, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_HIKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route101HouseHikerText, -1

Route101HouseHikerText:
	text "Feel free to"
	line "pick the berries  "
	cont "on the tree outside"

	para "they grow back"
	line "faster than I"
	cont "can use them!"
	done
