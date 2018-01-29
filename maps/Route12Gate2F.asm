Route12Gate2F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

Route12Gate2F_MapEventHeader:
	db 1 ; warps
	warp_def 7, 7, -1, ROUTE_12_GATE_2F

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 2, 1, SIGNPOST_UP, Route12Gate2FBinoculars1
	signpost 2, 6, SIGNPOST_UP, Route12Gate2FBinoculars2

	db 0 ; person events

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
