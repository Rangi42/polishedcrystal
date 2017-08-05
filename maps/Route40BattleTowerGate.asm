Route40BattleTowerGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route40BattleTowerGate_MapEventHeader:

.Warps: db 4
	warp_def $7, $4, 1, ROUTE_40
	warp_def $7, $5, 1, ROUTE_40
	warp_def $0, $4, 1, BATTLE_TOWER_OUTSIDE
	warp_def $0, $5, 2, BATTLE_TOWER_OUTSIDE

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_ROCKER, 3, 3, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, RockerScript_0x9f669, -1
	person_event SPRITE_TWIN, 5, 7, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, TwinScript_0x9f66c, -1

RockerScript_0x9f669:
	jumptextfaceplayer UnknownText_0x9f716

TwinScript_0x9f66c:
	jumptextfaceplayer UnknownText_0x9f7c8

UnknownText_0x9f716:
	text "Are you going to"
	line "the Battle Tower?"

	para "If you win a whole"
	line "lot, you can earn"

	para "Battle Points and"
	line "trade them in for"
	cont "special items."
	done

UnknownText_0x9f7c8:
	text "The levels of the"
	line "#mon I want to"

	para "use are all"
	line "different."

	para "I have to go train"
	line "them now!"
	done
