Route12Gate2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  7,  7, ROUTE_12_GATE_2F, -1

	db 0 ; coord events

	db 2 ; bg events
	bg_event  1,  2, SIGNPOST_UP, Route12Gate2FBinoculars1
	bg_event  6,  2, SIGNPOST_UP, Route12Gate2FBinoculars2

	db 0 ; object events

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
