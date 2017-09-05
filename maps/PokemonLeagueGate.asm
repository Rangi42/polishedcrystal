PokemonLeagueGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

PokemonLeagueGate_MapEventHeader:

.Warps: db 8
	warp_def 7, 19, 1, ROUTE_22
	warp_def 7, 20, 1, ROUTE_22
	warp_def 17, 10, 1, ROUTE_26
	warp_def 17, 11, 1, ROUTE_26
	warp_def 0, 10, 1, ROUTE_23
	warp_def 0, 11, 2, ROUTE_23
	warp_def 7, 1, 2, ROUTE_28
	warp_def 7, 2, 2, ROUTE_28

.XYTriggers: db 2
	xy_trigger 0, 10, 10, PokemonLeagueGateXYTriggerScript1
	xy_trigger 0, 10, 11, PokemonLeagueGateXYTriggerScript2

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_OFFICER, 10, 8, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, OfficerScript_0x9ba03, -1
	person_event SPRITE_BLACK_BELT, 5, 7, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9baf1, EVENT_OPENED_MT_SILVER
	person_event SPRITE_BLACK_BELT, 5, 14, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9bb37, EVENT_FOUGHT_SNORLAX

PokemonLeagueGateXYTriggerScript2:
	applyonemovement PLAYER, step_left
PokemonLeagueGateXYTriggerScript1:
	spriteface PLAYER, LEFT
	jump UnknownScript_0x9ba04

OfficerScript_0x9ba03:
	faceplayer
UnknownScript_0x9ba04:
	showtext UnknownText_0x9ba29
	dotrigger $1
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
