Route11Gate2F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 1 ; warps
	warp_def 7, 7, -1, ROUTE_11_GATE_2F

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 2, 1, SIGNPOST_UP, Route11Gate2FBinoculars1
	signpost 2, 6, SIGNPOST_UP, Route11Gate2FBinoculars2

	db 0 ; person events

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
