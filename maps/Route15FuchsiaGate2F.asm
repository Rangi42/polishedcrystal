Route15FuchsiaGate2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  7,  7, ROUTE_15_FUCHSIA_GATE_2F, -1

	db 0 ; coord events

	db 2 ; bg events
	bg_event  1,  2, SIGNPOST_UP, Route15FuchsiaGate2FBinoculars1
	bg_event  6,  2, SIGNPOST_UP, Route15FuchsiaGate2FBinoculars2

	db 0 ; object events

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
