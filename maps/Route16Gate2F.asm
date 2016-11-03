const_value set 2

Route16Gate2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route16Gate2FBinoculars1:
	jumptext Route16Gate2FBinoculars1Text

Route16Gate2FBinoculars2:
	jumptext Route16Gate2FBinoculars2Text

Route16Gate2FBinoculars1Text:
	text "Looked into the"
	line "binoculars."

	para "It's Celadon Dept."
	line "Store!"
	done

Route16Gate2FBinoculars2Text:
	text "Looked into the"
	line "binoculars."

	para "There's a long"
	line "path over water!"
	done

Route16Gate2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $7, $7, 5, ROUTE_16_GATE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 2, 1, SIGNPOST_UP, Route16Gate2FBinoculars1
	signpost 2, 6, SIGNPOST_UP, Route16Gate2FBinoculars2

.PersonEvents:
	db 0
