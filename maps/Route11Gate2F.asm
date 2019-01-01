Route11Gate2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  7,  7, ROUTE_11_GATE_2F, -1

	db 0 ; coord events

	db 2 ; bg events
	bg_event  1,  2, SIGNPOST_UP, Route11Gate2FBinoculars1
	bg_event  6,  2, SIGNPOST_UP, Route11Gate2FBinoculars2

	db 0 ; object events

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
