Route12Gate2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route12Gate2F_MapEventHeader:

.Warps: db 1
	warp_def 7, 7, -1, ROUTE_12_GATE_2F

.XYTriggers: db 0

.Signposts: db 2
	signpost 2, 1, SIGNPOST_UP, Route12Gate2FBinoculars1
	signpost 2, 6, SIGNPOST_UP, Route12Gate2FBinoculars2

.PersonEvents: db 0

Route12Gate2FBinoculars1:
	jumptext Route12Gate2FBinoculars1Text

Route12Gate2FBinoculars2:
	jumptext Route12Gate2FBinoculars2Text

Route12Gate2FBinoculars1Text:
	text "Looked into the"
	line "binoculars."

	para "A man fishing!"
	done

Route12Gate2FBinoculars2Text:
	text "Looked into the"
	line "binoculars."

	para "It's the Radio"
	line "Tower!"
	done
