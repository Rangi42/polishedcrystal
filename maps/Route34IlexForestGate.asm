Route34IlexForestGate_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_OBJECTS, UnknownScript_0x62d2d

	db 4 ; warp events
	warp_event  4,  0, ROUTE_34, 1
	warp_event  5,  0, ROUTE_34, 2
	warp_event  4,  7, ILEX_FOREST, 1
	warp_event  5,  7, ILEX_FOREST, 1

	db 1 ; coord events
	coord_event  4,  7, 0, UnknownScript_0x62d3d

	db 0 ; bg events

	db 4 ; object events
	object_event  9,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, TeacherScript_0x62d63, EVENT_ROUTE_34_ILEX_FOREST_GATE_TEACHER_BEHIND_COUNTER
	object_event  5,  7, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, TeacherScript_0x62d63, EVENT_ROUTE_34_ILEX_FOREST_GATE_TEACHER_IN_WALKWAY
	object_event  9,  4, SPRITE_HERACROSS, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_POKEMON, HERACROSS, UnknownText_0x62e83, -1
	object_event  3,  4, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x62e97, EVENT_ROUTE_34_ILEX_FOREST_GATE_LASS

	const_def 1 ; object constants
	const ROUTE34ILEXFORESTGATE_TEACHER1
	const ROUTE34ILEXFORESTGATE_TEACHER2

UnknownScript_0x62d2d:
	checkevent EVENT_FOREST_IS_RESTLESS
	iffalse UnknownScript_0x62d38
	disappear ROUTE34ILEXFORESTGATE_TEACHER1
	appear ROUTE34ILEXFORESTGATE_TEACHER2
	return

UnknownScript_0x62d38:
	disappear ROUTE34ILEXFORESTGATE_TEACHER2
	appear ROUTE34ILEXFORESTGATE_TEACHER1
	return

UnknownScript_0x62d3d:
	checkevent EVENT_FOREST_IS_RESTLESS
	iffalse UnknownScript_0x62d62
	showemote EMOTE_SHOCK, ROUTE34ILEXFORESTGATE_TEACHER2, 20
	turnobject ROUTE34ILEXFORESTGATE_TEACHER2, LEFT
	turnobject PLAYER, RIGHT
	follow PLAYER, ROUTE34ILEXFORESTGATE_TEACHER2
	applymovement PLAYER, MovementData_0x62d97
	stopfollow
	turnobject PLAYER, DOWN
	showtext UnknownText_0x62e41
	applymovement ROUTE34ILEXFORESTGATE_TEACHER2, MovementData_0x62d9a
UnknownScript_0x62d62:
	end

TeacherScript_0x62d63:
	checkevent EVENT_FOREST_IS_RESTLESS
	iftrue_jumptextfaceplayer UnknownText_0x62e41
	checkevent EVENT_GOT_TM54_FALSE_SWIPE
	iftrue_jumptextfaceplayer UnknownText_0x62df6
	faceplayer
	opentext
	writetext UnknownText_0x62d9d
	buttonsound
	verbosegivetmhm TM_FALSE_SWIPE
	setevent EVENT_GOT_TM54_FALSE_SWIPE
	thisopenedtext

UnknownText_0x62df6:
	text "It's False Swipe."

	para "Teach it to a"
	line "special #mon."
	done

MovementData_0x62d97:
	step_up
	step_up
	step_end

MovementData_0x62d9a:
	step_down
	step_right
	step_end

UnknownText_0x62d9d:
	text "Oh, honey. You're"
	line "making a #dex?"

	para "It must be hard to"
	line "catch all those"
	cont "#mon."

	para "Here, take this"
	line "TM."
	done

UnknownText_0x62e41:
	text "Something's wrong"
	line "in Ilex Forest…"

	para "You should stay"
	line "away right now."
	done

UnknownText_0x62e83:
	text "Heracross: Cross!"
	done

UnknownText_0x62e97:
	text "Did you see the"
	line "shrine honoring"
	cont "the protector?"

	para "It watches over"
	line "the Forest from"
	cont "across time."

	para "I think that it"
	line "must be a Grass-"
	cont "type #mon."
	done
