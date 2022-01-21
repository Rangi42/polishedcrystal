Route18Gate2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  7, ROUTE_18_GATE_2F, -1

	def_coord_events

	def_bg_events
	bg_event  1,  2, BGEVENT_UP, Route18Gate2FBinoculars1
	bg_event  6,  2, BGEVENT_UP, Route18Gate2FBinoculars2

	def_object_events

Route18Gate2FBinoculars1:
	jumptext Route18Gate2FBinoculars1Text

Route18Gate2FBinoculars2:
	jumptext Route18Gate2FBinoculars2Text

Route18Gate2FBinoculars1Text:
	text "Looked into the"
	line "binoculars."

	para "Pallet Town is in"
	line "the west!"
	done

Route18Gate2FBinoculars2Text:
	text "Looked into the"
	line "binoculars."

	para "There are people"
	line "swimming!"
	done
