Route1617Gate2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  7,  7, ROUTE_16_17_GATE_2F, -1

	db 0 ; coord events

	db 2 ; bg events
	bg_event  1,  2, SIGNPOST_UP, Route1617Gate2FBinoculars1
	bg_event  6,  2, SIGNPOST_UP, Route1617Gate2FBinoculars2

	db 0 ; object events

Route1617Gate2FBinoculars1:
	jumptext Route1617Gate2FBinoculars1Text

Route1617Gate2FBinoculars2:
	jumptext Route1617Gate2FBinoculars2Text

Route1617Gate2FBinoculars1Text:
	text "Looked into the"
	line "binoculars."

	para "It's Celadon Dept."
	line "Store!"
	done

Route1617Gate2FBinoculars2Text:
	text "Looked into the"
	line "binoculars."

	para "There's a long"
	line "path over water!"
	done
