Route34IlexForestGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, UnknownScript_0x62d2d

Route34IlexForestGate_MapEventHeader:

.Warps: db 4
	warp_def 0, 4, 1, ROUTE_34
	warp_def 0, 5, 2, ROUTE_34
	warp_def 7, 4, 1, ILEX_FOREST
	warp_def 7, 5, 1, ILEX_FOREST

.XYTriggers: db 1
	xy_trigger 0, 7, 4, UnknownScript_0x62d3d

.Signposts: db 0

.PersonEvents: db 4
	person_event SPRITE_TEACHER, 3, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, TeacherScript_0x62d63, EVENT_ROUTE_34_ILEX_FOREST_GATE_TEACHER_BEHIND_COUNTER
	person_event SPRITE_TEACHER, 7, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, TeacherScript_0x62d63, EVENT_ROUTE_34_ILEX_FOREST_GATE_TEACHER_IN_WALKWAY
	person_event SPRITE_HERACROSS, 4, 9, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_POKEMON, HERACROSS, UnknownText_0x62e83, -1
	person_event SPRITE_LASS, 4, 3, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x62e97, EVENT_ROUTE_34_ILEX_FOREST_GATE_LASS

const_value set 1
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
	spriteface ROUTE34ILEXFORESTGATE_TEACHER2, LEFT
	spriteface PLAYER, RIGHT
	follow PLAYER, ROUTE34ILEXFORESTGATE_TEACHER2
	applymovement PLAYER, MovementData_0x62d97
	stopfollow
	spriteface PLAYER, DOWN
	showtext UnknownText_0x62e41
	applymovement ROUTE34ILEXFORESTGATE_TEACHER2, MovementData_0x62d9a
UnknownScript_0x62d62:
	end

TeacherScript_0x62d63:
	faceplayer
	opentext
	checkevent EVENT_FOREST_IS_RESTLESS
	iftrue UnknownScript_0x62d84
	checkevent EVENT_GOT_TM54_FALSE_SWIPE
	iftrue UnknownScript_0x62d7e
	writetext UnknownText_0x62d9d
	buttonsound
	verbosegivetmhm TM_FALSE_SWIPE
	setevent EVENT_GOT_TM54_FALSE_SWIPE
UnknownScript_0x62d7e:
	jumpopenedtext UnknownText_0x62df6

UnknownScript_0x62d84:
	writetext UnknownText_0x62e41
	buttonsound
	endtext

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

UnknownText_0x62df6:
	text "It's False Swipe."

	para "Teach it to a"
	line "special #mon."
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
