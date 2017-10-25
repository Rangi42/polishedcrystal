Route15FuchsiaGate2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route15FuchsiaGate2F_MapEventHeader:

.Warps: db 1
	warp_def 7, 7, -1, ROUTE_15_FUCHSIA_GATE_2F

.XYTriggers: db 0

.Signposts: db 2
	signpost 2, 1, SIGNPOST_UP, Route15FuchsiaGate2FBinoculars1
	signpost 2, 6, SIGNPOST_UP, Route15FuchsiaGate2FBinoculars2

.PersonEvents: db 0

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
