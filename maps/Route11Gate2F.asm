Route11Gate2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  7, ROUTE_11_GATE_2F, -1

	def_coord_events

	def_bg_events
	bg_event  1,  2, BGEVENT_UP, Route11Gate2FBinoculars1
	bg_event  6,  2, BGEVENT_UP, Route11Gate2FBinoculars2

	def_object_events

Route11Gate2FBinoculars1:
	jumptext Route11Gate2FBinoculars1Text

Route11Gate2FBinoculars2:
	jumptext Route11Gate2FBinoculars2Text

Route11Gate2FBinoculars1Text:
	text "Looked into the"
	line "binoculars."

	para "It's a beautiful"
	line "view!"
	done

Route11Gate2FBinoculars2Text:
	text "Looked into the"
	line "binoculars."

	para "The only way to"
	line "get from Cerulean"
	cont "City to Lavender"

	para "is by way of the"
	line "Rock Tunnel."
	done
