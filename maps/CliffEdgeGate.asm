const_value set 2
	const CLIFFEDGEGATE_RECEPTIONIST

CliffEdgeGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CliffEdgeGateReceptionistScript:
	jumptextfaceplayer CliffEdgeGateReceptionistText

CliffEdgeGateHiddenBigPearl:
	dwb EVENT_CLIFF_EDGE_GATE_HIDDEN_BIG_PEARL, BIG_PEARL

CliffEdgeGateReceptionistText:
	text "Yellow Forest is"
	line "this way!"

	para "It's a popular"
	line "tourist sight!"
	done

CliffEdgeGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $13, $11, 8, CIANWOOD_CITY
	warp_def $13, $3, 1, ROUTE_47

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 6, 17, SIGNPOST_ITEM, CliffEdgeGateHiddenBigPearl

.PersonEvents:
	db 1
	person_event SPRITE_RECEPTIONIST, 16, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CliffEdgeGateReceptionistScript, -1
