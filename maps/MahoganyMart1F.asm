MahoganyMart1F_MapScriptHeader:
	def_scene_scripts
	scene_script MahoganyMart1FTrigger0
	scene_script MahoganyMart1FTrigger1

	def_callbacks
	callback MAPCALLBACK_TILES, UnknownScript_0x6c35b

	def_warp_events
	warp_event  3,  7, MAHOGANY_TOWN, 1
	warp_event  4,  7, MAHOGANY_TOWN, 1
	warp_event  7,  3, TEAM_ROCKET_BASE_B1F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, MahoganyMart1FPharmacistScript, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  1,  6, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMart1FBlackBeltScript, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  4,  6, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	object_event  3,  6, SPRITE_DRAGONITE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	object_event  1,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_MAHOGANY_2, EVENT_MAHOGANY_MART_OWNERS

	object_const_def
	const MAHOGANYMART1F_PHARMACIST
	const MAHOGANYMART1F_BLACK_BELT
	const MAHOGANYMART1F_LANCE
	const MAHOGANYMART1F_DRAGONITE

MahoganyMart1FTrigger1:
	sdefer MahoganyMart1FLanceUncoversStaircaseScript
MahoganyMart1FTrigger0:
	end

UnknownScript_0x6c35b:
	checkevent EVENT_UNCOVERED_STAIRCASE_IN_MAHOGANY_MART
	iftrue UnknownScript_0x6c362
	endcallback

UnknownScript_0x6c362:
	changeblock 6, 2, $1e
	endcallback

MahoganyMart1FPharmacistScript:
	checkevent EVENT_DECIDED_TO_HELP_LANCE
	iftrue_jumptextfaceplayer MahoganyMart1FPharmacistText_LanceEntered
	pokemart MARTTYPE_STANDARD, MART_MAHOGANY_1

MahoganyMart1FBlackBeltScript:
	checkevent EVENT_DECIDED_TO_HELP_LANCE
	iftrue_jumptextfaceplayer MahoganyMart1FBlackBeltText_LanceEntered
	jumptextfaceplayer MahoganyMart1FBlackBeltText

MahoganyMart1FLanceUncoversStaircaseScript:
	pause 15
	opentext
	writetext MahoganyMart1FLanceDragoniteHyperBeamText
	pause 15
	closetext
	playsound SFX_TACKLE
	applymovement MAHOGANYMART1F_DRAGONITE, MahoganyMart1FDragoniteTackleMovement
	applymovement MAHOGANYMART1F_BLACK_BELT, MahoganyMart1FBlackBeltKnockedBackMovement
	pause 15
	disappear MAHOGANYMART1F_DRAGONITE
	pause 15
	applymovement MAHOGANYMART1F_LANCE, MahoganyMart1FLanceApproachPlayerMovement
	showtext MahoganyMart1FLanceRadioText
	follow MAHOGANYMART1F_LANCE, PLAYER
	applymovement MAHOGANYMART1F_LANCE, MahoganyMart1FLanceApproachPharmacistMovement
	applymovement MAHOGANYMART1F_PHARMACIST, MahoganyMart1FPharmacistShovedAsideMovement
	applymovement MAHOGANYMART1F_LANCE, MahoganyMart1FLanceApproachHiddenStairsMovement
	stopfollow
	opentext
	writetext MahoganyMart1FLanceStairsText
	waitbutton
	showemote EMOTE_SHOCK, MAHOGANYMART1F_PHARMACIST, 10
	playsound SFX_FAINT
	changeblock 6, 2, $1e
	reloadmappart
	closetext
	setevent EVENT_UNCOVERED_STAIRCASE_IN_MAHOGANY_MART
	turnobject MAHOGANYMART1F_LANCE, LEFT
	showtext MahoganyMart1FLanceSplitUpText
	applyonemovement MAHOGANYMART1F_LANCE, slow_step_right
	playsound SFX_EXIT_BUILDING
	disappear MAHOGANYMART1F_LANCE
	setscene $0
	waitsfx
	end

MahoganyMart1FDragoniteTackleMovement:
	fix_facing
	run_step_left
	run_step_right
	remove_fixed_facing
	step_end

MahoganyMart1FBlackBeltKnockedBackMovement:
	fix_facing
	run_step_left
	remove_fixed_facing
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	step_end

MahoganyMart1FPharmacistShovedAsideMovement:
	fix_facing
	run_step_left
	remove_fixed_facing
	step_end

MahoganyMart1FLanceApproachPlayerMovement:
	slow_step_left
	turn_head_down
	step_end

MahoganyMart1FLanceApproachPharmacistMovement:
	slow_step_right
	slow_step_up
	slow_step_up
	step_end

MahoganyMart1FLanceApproachHiddenStairsMovement:
	slow_step_up
	slow_step_right
	slow_step_right
	step_end

MahoganyMart1FPharmacistText_LanceEntered:
	text "Arrgh… You found"
	line "the secret stair-"
	cont "way…"
	done

MahoganyMart1FBlackBeltText:
	text "Heheh! The experi-"
	line "ment worked like a"
	cont "charm."

	para "Magikarp are just"
	line "worthless, but"

	para "Gyarados are big"
	line "moneymakers."
	done

MahoganyMart1FBlackBeltText_LanceEntered:
	text "Urrgh…"

	para "That guy's dragon"
	line "#mon are tough…"
	done

MahoganyMart1FLanceDragoniteHyperBeamText:
	text "Lance: Dragonite,"
	line "Hyper Beam."
	done

MahoganyMart1FLanceRadioText:
	text "What took you,"
	line "<PLAYER>?"

	para "Just as I thought,"
	line "that strange radio"

	para "signal is coming"
	line "from here."
	done

MahoganyMart1FLanceStairsText:
	text "The stairs are"
	line "right here."
	done

MahoganyMart1FLanceSplitUpText:
	text "Lance: <PLAYER>, we"
	line "should split up to"

	para "check this place."
	line "I'll go first."
	done
