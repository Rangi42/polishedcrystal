Route28_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route28Sign:
	jumptext Route28SignText

Route28HiddenRareCandy:
	dwb EVENT_ROUTE_28_HIDDEN_RARE_CANDY, RARE_CANDY

Route28SignText:
	text "Route 28"
	done

Route28_MapEventHeader:
.Warps:
	db 2
	warp_def $3, $7, 1, ROUTE_28_FAMOUS_SPEECH_HOUSE
	warp_def $5, $21, 7, POKEMON_LEAGUE_GATE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 5, 31, SIGNPOST_READ, Route28Sign
	signpost 3, 25, SIGNPOST_ITEM, Route28HiddenRareCandy

.PersonEvents:
	db 0
