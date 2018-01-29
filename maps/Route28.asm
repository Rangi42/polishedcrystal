Route28_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

Route28_MapEventHeader:
	db 2 ; warps
	warp_def 3, 7, 1, ROUTE_28_FAMOUS_SPEECH_HOUSE
	warp_def 5, 33, 7, POKEMON_LEAGUE_GATE

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 5, 31, SIGNPOST_JUMPTEXT, Route28SignText
	signpost 3, 25, SIGNPOST_ITEM + RARE_CANDY, EVENT_ROUTE_28_HIDDEN_RARE_CANDY

	db 0 ; person events

Route28SignText:
	text "Route 28"
	done
