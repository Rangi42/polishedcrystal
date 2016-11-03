const_value set 2

Route1718Gate2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route1718Gate2FBinoculars1:
	jumptext Route1718Gate2FBinoculars1Text

Route1718Gate2FBinoculars2:
	jumptext Route1718Gate2FBinoculars2Text

Route1718Gate2FBinoculars1Text:
	text "Looked into the"
	line "binoculars."

	para "Pallet Town is in"
	line "the west!"
	done

Route1718Gate2FBinoculars2Text:
	text "Looked into the"
	line "binoculars."

	para "There are people"
	line "swimming!"
	done

Route1718Gate2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $7, $7, 5, ROUTE_17_18_GATE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 2, 1, SIGNPOST_UP, Route1718Gate2FBinoculars1
	signpost 2, 6, SIGNPOST_UP, Route1718Gate2FBinoculars2

.PersonEvents:
	db 0
