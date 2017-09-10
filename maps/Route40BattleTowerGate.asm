Route40BattleTowerGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route40BattleTowerGate_MapEventHeader:

.Warps: db 4
	warp_def 7, 4, 1, ROUTE_40
	warp_def 7, 5, 1, ROUTE_40
	warp_def 0, 4, 1, BATTLE_TOWER_OUTSIDE
	warp_def 0, 5, 2, BATTLE_TOWER_OUTSIDE

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, OfficerText_0x19ab0b, EVENT_BATTLE_TOWER_CLOSED
	person_event SPRITE_ROCKER, 3, 3, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, RockerScript_0x9f669, -1
	person_event SPRITE_TWIN, 5, 7, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, TwinScript_0x9f66c, -1

OfficerText_0x19ab0b:
	text "Are you going to"
	line "the Battle Tower?"

	para "If you win a whole"
	line "lot, you can earn"

	para "Battle Points and"
	line "trade them in for"
	cont "special items."
	done

RockerScript_0x9f669:
	checkevent EVENT_BATTLE_TOWER_OPEN
	iftrue_jumptextfaceplayer .OpenText
	thistextfaceplayer

	text "Did you come to"
	line "see the Battle"
	cont "Tower too?"

	para "But I guess you"
	line "can't go in yet."
	done

.OpenText:
	text "Battle Tower has"
	line "opened."

	para "I want to go, but"
	line "I haven't thought"

	para "up a cool line for"
	line "when I win."
	done

TwinScript_0x9f66c:
	checkevent EVENT_BATTLE_TOWER_OPEN
	iftrue_jumptextfaceplayer .OpenText
	thistextfaceplayer

	text "I'm going to train"
	line "my #mon so I'll"

	para "be all ready for"
	line "the Battle Tower."
	done

.OpenText:
	text "The levels of the"
	line "#mon I want to"

	para "use are all"
	line "different."

	para "I have to go train"
	line "them now!"
	done
