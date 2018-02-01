Route18Gate2F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 1 ; warps
	warp_def 7, 7, -1, ROUTE_18_GATE_2F

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 2, 1, SIGNPOST_UP, Route18Gate2FBinoculars1
	signpost 2, 6, SIGNPOST_UP, Route18Gate2FBinoculars2

	db 0 ; person events

Route18Gate2FBinoculars1:
	jumptext Route18Gate2FBinoculars1Text

Route18Gate2FBinoculars2:
	jumptext Route18Gate2FBinoculars2Text

Route18Gate2FBinoculars1Text:
	text "Looked into the"
	line "binoculars."

	para "Pallet Town is in"
	line "the west!"
	done

Route18Gate2FBinoculars2Text:
	text "Looked into the"
	line "binoculars."

	para "There are people"
	line "swimming!"
	done
