PokemonLeagueGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 8 ; warp events
	warp_event 19,  7, ROUTE_22, 1
	warp_event 20,  7, ROUTE_22, 1
	warp_event 10, 17, ROUTE_26, 1
	warp_event 11, 17, ROUTE_26, 1
	warp_event 10,  0, ROUTE_23, 1
	warp_event 11,  0, ROUTE_23, 2
	warp_event  1,  7, ROUTE_28, 2
	warp_event  2,  7, ROUTE_28, 2

	db 2 ; coord events
	coord_event 10, 10, 0, PokemonLeagueGateXYTriggerScript1
	coord_event 11, 10, 0, PokemonLeagueGateXYTriggerScript2

	db 0 ; bg events

	db 3 ; object events
	object_event  8, 10, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, OfficerScript_0x9ba03, -1
	object_event  7,  5, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9baf1, EVENT_OPENED_MT_SILVER
	object_event 14,  5, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9bb37, EVENT_FOUGHT_SNORLAX

PokemonLeagueGateXYTriggerScript2:
	applyonemovement PLAYER, step_left
PokemonLeagueGateXYTriggerScript1:
	turnobject PLAYER, LEFT
	jump UnknownScript_0x9ba04

OfficerScript_0x9ba03:
	faceplayer
UnknownScript_0x9ba04:
	showtext UnknownText_0x9ba29
	setscene $1
	end

UnknownText_0x9ba29:
	text "Only trainers who"
	line "have proven them-"
	cont "selves may pass."

	para "You took the Johto"
	line "Gym challenge?"

	para "The guards ahead"
	line "will check your"
	cont "badges."

	para "Go on now."
	done

UnknownText_0x9baf1:
	text "This way leads to"
	line "Mt.Silver."

	para "You'll see scary-"
	line "strong #mon out"
	cont "there."
	done

UnknownText_0x9bb37:
	text "Off to the #mon"
	line "League, are you?"

	para "The Elite Four are"
	line "so strong it's"

	para "scary, and they're"
	line "ready for you!"
	done
