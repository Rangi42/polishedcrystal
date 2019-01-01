Route28_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  7,  3, ROUTE_28_FAMOUS_SPEECH_HOUSE, 1
	warp_event 33,  5, POKEMON_LEAGUE_GATE, 7

	db 0 ; coord events

	db 2 ; bg events
	bg_event 31,  5, SIGNPOST_JUMPTEXT, Route28SignText
	bg_event 25,  3, SIGNPOST_ITEM + RARE_CANDY, EVENT_ROUTE_28_HIDDEN_RARE_CANDY

	db 0 ; object events

Route28SignText:
	text "Route 28"
	done
