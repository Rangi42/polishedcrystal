Route15FuchsiaGate2F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

Route15FuchsiaGate2F_MapEventHeader:
	db 1 ; warps
	warp_def 7, 7, -1, ROUTE_15_FUCHSIA_GATE_2F

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 2, 1, SIGNPOST_UP, Route15FuchsiaGate2FBinoculars1
	signpost 2, 6, SIGNPOST_UP, Route15FuchsiaGate2FBinoculars2

	db 0 ; person events

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
