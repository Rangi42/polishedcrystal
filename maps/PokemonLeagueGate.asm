const_value set 2
	const POKEMONLEAGUEGATE_OFFICER
	const POKEMONLEAGUEGATE_BLACK_BELT1
	const POKEMONLEAGUEGATE_BLACK_BELT2

PokemonLeagueGate_MapScriptHeader:
.MapTriggers:
	db 2
	dw UnknownScript_0x9b9fb
	dw UnknownScript_0x9b9fc

.MapCallbacks:
	db 0

UnknownScript_0x9b9fb:
	end

UnknownScript_0x9b9fc:
	end

PokemonLeagueGateXYTriggerScript2:
	applymovement PLAYER, PokemonLeagueGateXYTriggerScript2Movement

PokemonLeagueGateXYTriggerScript1:
	spriteface PLAYER, LEFT
	jump UnknownScript_0x9ba04

OfficerScript_0x9ba03:
	faceplayer
UnknownScript_0x9ba04:
	opentext
	writetext UnknownText_0x9ba29
	waitbutton
	closetext
	dotrigger $1
	end

BlackBeltScript_0x9ba21:
	jumptextfaceplayer UnknownText_0x9baf1

BlackBeltScript_0x9ba24:
	jumptextfaceplayer UnknownText_0x9bb37

PokemonLeagueGateXYTriggerScript2Movement:
	step_left
	step_end

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

PokemonLeagueGate_MapEventHeader:
.Warps:
	db 8
	warp_def $7, $13, 1, ROUTE_22
	warp_def $7, $14, 1, ROUTE_22
	warp_def $11, $a, 1, ROUTE_26
	warp_def $11, $b, 1, ROUTE_26
	warp_def $0, $a, 1, ROUTE_23
	warp_def $0, $b, 2, ROUTE_23
	warp_def $7, $1, 2, ROUTE_28
	warp_def $7, $2, 2, ROUTE_28

.XYTriggers:
	db 2
	xy_trigger 0, $a, $a, PokemonLeagueGateXYTriggerScript1
	xy_trigger 0, $a, $b, PokemonLeagueGateXYTriggerScript2

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_OFFICER, 10, 8, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, OfficerScript_0x9ba03, -1
	person_event SPRITE_BLACK_BELT, 5, 7, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BlackBeltScript_0x9ba21, EVENT_OPENED_MT_SILVER
	person_event SPRITE_BLACK_BELT, 5, 14, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BlackBeltScript_0x9ba24, EVENT_FOUGHT_SNORLAX
