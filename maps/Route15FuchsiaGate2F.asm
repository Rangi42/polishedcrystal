Route15FuchsiaGate2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  7, ROUTE_15_FUCHSIA_GATE_2F, -1

	def_coord_events

	def_bg_events
	bg_event  1,  2, BGEVENT_UP, Route15FuchsiaGate2FBinoculars1
	bg_event  6,  2, BGEVENT_UP, Route15FuchsiaGate2FBinoculars2

	def_object_events

Route15FuchsiaGate2FBinoculars1:
	jumptext Route15FuchsiaGate2FBinoculars1Text

Route15FuchsiaGate2FBinoculars2:
	jumptext Route15FuchsiaGate2FBinoculars2Text

Route15FuchsiaGate2FBinoculars1Text:
Route15FuchsiaGate2FBinoculars2Text:
	text "Looked into the"
	line "binoculars."

	para "It looks like a"
	line "small island!"
	done
