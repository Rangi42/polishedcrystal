MahoganyMart1F_MapScriptHeader:

.MapTriggers: db 2
	dw MahoganyMart1FTrigger0
	dw MahoganyMart1FTrigger1

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, UnknownScript_0x6c35b

MahoganyMart1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 3, 1, MAHOGANY_TOWN
	warp_def 7, 4, 1, MAHOGANY_TOWN
	warp_def 3, 7, 1, TEAM_ROCKET_BASE_B1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 5
	person_event SPRITE_PHARMACIST, 3, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, PharmacistScript_0x6c367, EVENT_TEAM_ROCKET_BASE_POPULATION
	person_event SPRITE_BLACK_BELT, 6, 1, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BlackBeltScript_0x6c37b, EVENT_TEAM_ROCKET_BASE_POPULATION
	person_event SPRITE_LANCE, 6, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	person_event SPRITE_DRAGONITE, 6, 3, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	person_event SPRITE_GRANNY, 3, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_MAHOGANY_2, EVENT_MAHOGANY_MART_OWNERS

const_value set 1
	const MAHOGANYMART1F_PHARMACIST
	const MAHOGANYMART1F_BLACK_BELT
	const MAHOGANYMART1F_LANCE
	const MAHOGANYMART1F_DRAGONITE

MahoganyMart1FTrigger1:
	priorityjump UnknownScript_0x6c38f
MahoganyMart1FTrigger0:
	end

UnknownScript_0x6c35b:
	checkevent EVENT_UNCOVERED_STAIRCASE_IN_MAHOGANY_MART
	iftrue UnknownScript_0x6c362
	return

UnknownScript_0x6c362:
	changeblock 6, 2, $1e
	return

PharmacistScript_0x6c367:
	checkevent EVENT_DECIDED_TO_HELP_LANCE
	iftrue_jumptextfaceplayer UnknownText_0x6c46b
	pokemart MARTTYPE_STANDARD, MART_MAHOGANY_1

BlackBeltScript_0x6c37b:
	checkevent EVENT_DECIDED_TO_HELP_LANCE
	iftrue_jumptextfaceplayer UnknownText_0x6c501
	jumptextfaceplayer UnknownText_0x6c494

UnknownScript_0x6c38f:
	pause 15
	opentext
	writetext UnknownText_0x6c52a
	pause 15
	closetext
	playsound SFX_TACKLE
	applymovement MAHOGANYMART1F_DRAGONITE, MovementData_0x6c3f6
	applymovement MAHOGANYMART1F_BLACK_BELT, MovementData_0x6c3fb
	pause 15
	disappear MAHOGANYMART1F_DRAGONITE
	pause 15
	applymovement MAHOGANYMART1F_LANCE, MovementData_0x6c407
	showtext UnknownText_0x6c549
	follow MAHOGANYMART1F_LANCE, PLAYER
	applymovement MAHOGANYMART1F_LANCE, MovementData_0x6c40a
	applymovement MAHOGANYMART1F_PHARMACIST, MovementData_0x6c403
	applymovement MAHOGANYMART1F_LANCE, MovementData_0x6c40e
	stopfollow
	opentext
	writetext UnknownText_0x6c59e
	waitbutton
	showemote EMOTE_SHOCK, MAHOGANYMART1F_PHARMACIST, 10
	playsound SFX_FAINT
	changeblock 6, 2, $1e
	reloadmappart
	closetext
	setevent EVENT_UNCOVERED_STAIRCASE_IN_MAHOGANY_MART
	spriteface MAHOGANYMART1F_LANCE, LEFT
	showtext UnknownText_0x6c5ba
	applyonemovement MAHOGANYMART1F_LANCE, slow_step_right
	playsound SFX_EXIT_BUILDING
	disappear MAHOGANYMART1F_LANCE
	dotrigger $0
	waitsfx
	end

MovementData_0x6c3f6:
	fix_facing
	big_step_left
	big_step_right
	remove_fixed_facing
	step_end

MovementData_0x6c3fb:
	fix_facing
	big_step_left
	remove_fixed_facing
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	step_end

MovementData_0x6c403:
	fix_facing
	big_step_left
	remove_fixed_facing
	step_end

MovementData_0x6c407:
	slow_step_left
	turn_head_down
	step_end

MovementData_0x6c40a:
	slow_step_right
	slow_step_up
	slow_step_up
	step_end

MovementData_0x6c40e:
	slow_step_up
	slow_step_right
	slow_step_right
	step_end

UnknownText_0x6c46b:
	text "Arrgh… You found"
	line "the secret stair-"
	cont "way…"
	done

UnknownText_0x6c494:
	text "Heheh! The experi-"
	line "ment worked like a"
	cont "charm."

	para "Magikarp are just"
	line "worthless, but"

	para "Gyarados are big"
	line "moneymakers."
	done

UnknownText_0x6c501:
	text "Urrgh…"

	para "That guy's dragon"
	line "#mon are tough…"
	done

UnknownText_0x6c52a:
	text "Lance: Dragonite,"
	line "Hyper Beam."
	done

UnknownText_0x6c549:
	text "What took you,"
	line "<PLAYER>?"

	para "Just as I thought,"
	line "that strange radio"

	para "signal is coming"
	line "from here."
	done

UnknownText_0x6c59e:
	text "The stairs are"
	line "right here."
	done

UnknownText_0x6c5ba:
	text "Lance: <PLAYER>, we"
	line "should split up to"

	para "check this place."
	line "I'll go first."
	done
