Route5UndergroundEntrance_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, ROUTE_5, 1
	warp_event  4,  7, ROUTE_5, 1
	warp_event  4,  4, UNDERGROUND, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route5UndergroundPathEntranceTeacherText, -1

Route5UndergroundPathEntranceTeacherText:
	text "Many cities in"
	line "Johto have long"

	para "histories. I'd"
	line "love to visit!"
	done
