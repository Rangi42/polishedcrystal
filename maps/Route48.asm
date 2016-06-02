const_value set 2
	const ROUTE48_POKE_BALL

Route48_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route48YellowForestSign:
	jumptext Route48YellowForestSignText

Route48Nugget:
	itemball NUGGET

Route48YellowForestSignText:
	text "North to"
	line "Yellow Forest"
	done

Route48_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 11, 27, SIGNPOST_READ, Route48YellowForestSign

.PersonEvents:
	db 1
	person_event SPRITE_POKE_BALL, 13, 4, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route48Nugget, EVENT_ROUTE_48_NUGGET
