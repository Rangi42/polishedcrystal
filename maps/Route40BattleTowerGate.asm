Route40BattleTowerGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  4,  7, ROUTE_40, 1
	warp_event  5,  7, ROUTE_40, 1
	warp_event  4,  0, BATTLE_TOWER_OUTSIDE, 1
	warp_event  5,  0, BATTLE_TOWER_OUTSIDE, 2

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, OfficerText_0x19ab0b, EVENT_BATTLE_TOWER_CLOSED
	object_event  3,  3, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, RockerScript_0x9f669, -1
	object_event  7,  5, SPRITE_TWIN, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, TwinScript_0x9f66c, -1

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
