TinTower1F_MapScriptHeader:
	def_scene_scripts
	scene_script TinTower1FTrigger0

	def_callbacks
	callback MAPCALLBACK_OBJECTS, UnknownScript_0x18502f
	callback MAPCALLBACK_TILES, TinTowerStairsCallback

	def_warp_events
	warp_event  7, 15, BELLCHIME_TRAIL, 3
	warp_event  8, 15, BELLCHIME_TRAIL, 3
	warp_event  8,  2, TIN_TOWER_2F, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7,  9, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SUICUNE, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TIN_TOWER_1F_SUICUNE
	object_event  5,  9, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, RAIKOU, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TIN_TOWER_1F_RAIKOU
	object_event 10,  9, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, ENTEI, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TIN_TOWER_1F_ENTEI
	object_event  6,  3, SPRITE_EUSINE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, TinTowerEusineHoOhText, EVENT_TIN_TOWER_1F_EUSINE
	object_event  3,  9, SPRITE_ELDER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, TinTower1FSage1Text, EVENT_TIN_TOWER_1F_WISE_TRIO_1
	object_event  9, 11, SPRITE_ELDER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, TinTower1FSage2Text, EVENT_TIN_TOWER_1F_WISE_TRIO_1
	object_event 12,  6, SPRITE_ELDER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, TinTower1FSage3Text, EVENT_TIN_TOWER_1F_WISE_TRIO_1
	object_event  2,  2, SPRITE_ELDER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TinTower1FSage4Script, EVENT_TIN_TOWER_1F_WISE_TRIO_2
	object_event  7,  1, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TinTower1FSage5Script, EVENT_TIN_TOWER_1F_WISE_TRIO_2
	object_event 12,  2, SPRITE_ELDER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TinTower1FSage6Script, EVENT_TIN_TOWER_1F_WISE_TRIO_2

	object_const_def
	const TINTOWER1F_SUICUNE
	const TINTOWER1F_RAIKOU
	const TINTOWER1F_ENTEI
	const TINTOWER1F_EUSINE
	const TINTOWER1F_SAGE1
	const TINTOWER1F_SAGE2
	const TINTOWER1F_SAGE3

TinTower1FTrigger0:
	sdefer SuicuneBattle
	end

UnknownScript_0x18502f:
	checkevent EVENT_GOT_RAINBOW_WING
	iftrue UnknownScript_0x185047
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse UnknownScript_0x185050
	special SpecialBeastsCheck
	iffalse UnknownScript_0x185050
	clearevent EVENT_TIN_TOWER_1F_WISE_TRIO_2
	setevent EVENT_TIN_TOWER_1F_WISE_TRIO_1
UnknownScript_0x185047:
	checkevent EVENT_FOUGHT_HO_OH
	iffalse .Done
	appear TINTOWER1F_EUSINE
.Done:
	endcallback

UnknownScript_0x185050:
	checkevent EVENT_FOUGHT_SUICUNE
	iftrue UnknownScript_0x185077
	appear TINTOWER1F_SUICUNE
	setval RAIKOU
	special SpecialMonCheck
	iftrue UnknownScript_0x185065
	appear TINTOWER1F_RAIKOU
	sjump UnknownScript_0x185067

UnknownScript_0x185065:
	disappear TINTOWER1F_RAIKOU
UnknownScript_0x185067:
	setval ENTEI
	special SpecialMonCheck
	iftrue UnknownScript_0x185074
	appear TINTOWER1F_ENTEI
	sjump UnknownScript_0x185076

UnknownScript_0x185074:
	disappear TINTOWER1F_ENTEI
UnknownScript_0x185076:
	endcallback

UnknownScript_0x185077:
	disappear TINTOWER1F_SUICUNE
	disappear TINTOWER1F_RAIKOU
	disappear TINTOWER1F_ENTEI
	clearevent EVENT_TIN_TOWER_1F_WISE_TRIO_1
	setevent EVENT_TIN_TOWER_1F_WISE_TRIO_2
	endcallback

TinTowerStairsCallback:
	checkevent EVENT_GOT_RAINBOW_WING
	iftrue .NoChange
	changeblock 8, 2, $9
.NoChange:
	endcallback

SuicuneBattle:
	applymovement PLAYER, TinTowerPlayerMovement1
	pause 15
	setval RAIKOU
	special SpecialMonCheck
	iftrue .Next1 ; if player caught Raikou, he doesn't appear in Tin Tower
	applymovement TINTOWER1F_RAIKOU, TinTowerRaikouMovement1
	turnobject PLAYER, LEFT
	cry RAIKOU
	pause 10
	playsound SFX_WARP_FROM
	applymovement TINTOWER1F_RAIKOU, TinTowerRaikouMovement2
	disappear TINTOWER1F_RAIKOU
	playsound SFX_EXIT_BUILDING
	waitsfx
.Next1:
	setval ENTEI
	special SpecialMonCheck
	iftrue .Next2 ; if player caught Entei, he doesn't appear in Tin Tower
	applymovement TINTOWER1F_ENTEI, TinTowerEnteiMovement1
	turnobject PLAYER, RIGHT
	cry ENTEI
	pause 10
	playsound SFX_WARP_FROM
	applymovement TINTOWER1F_ENTEI, TinTowerEnteiMovement2
	disappear TINTOWER1F_ENTEI
	playsound SFX_EXIT_BUILDING
	waitsfx
.Next2:
	turnobject PLAYER, UP
	pause 10
	applymovement PLAYER, TinTowerPlayerMovement2
	applymovement TINTOWER1F_SUICUNE, TinTowerSuicuneMovement
	cry SUICUNE
	pause 20
	loadwildmon SUICUNE, 40
	loadvar VAR_BATTLETYPE, BATTLETYPE_LEGENDARY
	startbattle
	dontrestartmapmusic
	disappear TINTOWER1F_SUICUNE
	setevent EVENT_FOUGHT_SUICUNE
	setevent EVENT_SAW_SUICUNE_ON_ROUTE_42
	setmapscene ROUTE_42, $0
	setevent EVENT_SAW_SUICUNE_ON_ROUTE_36
	setmapscene ROUTE_36, $0
	setevent EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	setmapscene CIANWOOD_CITY, $0
	setscene $1
	clearevent EVENT_SET_WHEN_FOUGHT_HO_OH
	reloadmapafterbattle
	turnobject PLAYER, DOWN
	pause 20
	playmusic MUSIC_MYSTICALMAN_ENCOUNTER
	playsound SFX_ENTER_DOOR
	moveobject TINTOWER1F_EUSINE, 8, 15
	appear TINTOWER1F_EUSINE
	applymovement TINTOWER1F_EUSINE, TinTower1FEusineEntersMovement
	playsound SFX_ENTER_DOOR
	moveobject TINTOWER1F_SAGE1, 7, 15
	appear TINTOWER1F_SAGE1
	applymovement TINTOWER1F_SAGE1, TinTower1FSage1EntersMovement
	playsound SFX_ENTER_DOOR
	moveobject TINTOWER1F_SAGE2, 7, 15
	appear TINTOWER1F_SAGE2
	applymovement TINTOWER1F_SAGE2, TinTower1FSage2EntersMovement
	playsound SFX_ENTER_DOOR
	moveobject TINTOWER1F_SAGE3, 7, 15
	appear TINTOWER1F_SAGE3
	applymovement TINTOWER1F_SAGE3, TinTower1FSage3EntersMovement
	moveobject TINTOWER1F_SAGE1, 5, 13
	moveobject TINTOWER1F_SAGE2, 7, 13
	moveobject TINTOWER1F_SAGE3, 9, 13
	turnobject PLAYER, RIGHT
	showtext TinTowerEusineSuicuneText
	applymovement TINTOWER1F_EUSINE, TinTower1FEusineLeavesMovement
	playsound SFX_EXIT_BUILDING
	disappear TINTOWER1F_EUSINE
	waitsfx
	special Special_FadeOutMusic
	pause 20
	playmapmusic
	end

TinTower1FSage4Script:
	checkevent EVENT_FOUGHT_HO_OH
	iftrue UnknownScript_0x185185
	jumptextfaceplayer TinTower1FSage4Text1

UnknownScript_0x185185:
	jumptextfaceplayer TinTower1FSage4Text2

TinTower1FSage5Script:
	faceplayer
	opentext
	checkevent EVENT_FOUGHT_HO_OH
	iftrue UnknownScript_0x1851b6
	checkevent EVENT_GOT_RAINBOW_WING
	iftrue UnknownScript_0x1851b0
	writetext TinTower1FSage5Text1
	promptbutton
	verbosegivekeyitem RAINBOW_WING
	closetext
	refreshscreen
	earthquake 72
	waitsfx
	playsound SFX_STRENGTH
	changeblock 8, 2, $20
	reloadmappart
	setevent EVENT_GOT_RAINBOW_WING
	closetext
	opentext
UnknownScript_0x1851b0:
	jumpopenedtext TinTower1FSage5Text2

UnknownScript_0x1851b6:
	jumpopenedtext TinTower1FSage5Text3

TinTower1FSage6Script:
	checkevent EVENT_FOUGHT_HO_OH
	iftrue UnknownScript_0x1851c5
	jumptextfaceplayer TinTower1FSage6Text1

UnknownScript_0x1851c5:
	jumptextfaceplayer TinTower1FSage6Text2

TinTowerPlayerMovement1:
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	step_end

TinTowerRaikouMovement1:
	fix_facing
	fast_jump_step_down
	step_end

TinTowerRaikouMovement2:
	fix_facing
	fast_jump_step_down
	fast_jump_step_right
	fast_jump_step_down
	step_end

TinTowerEnteiMovement1:
	fix_facing
	fast_jump_step_down
	step_end

TinTowerEnteiMovement2:
	fix_facing
	fast_jump_step_down
	fast_jump_step_left
	fast_jump_step_down
	step_end

TinTowerSuicuneMovement:
	fix_facing
	fast_jump_step_down
	step_end

TinTowerPlayerMovement2:
	fix_facing
	run_step_down
	remove_fixed_facing
	step_end

TinTower1FEusineEntersMovement:
	step_up
	step_up
	step_up
	turn_head_left
	step_end

TinTower1FEusineLeavesMovement:
	step_down
	step_down
	step_down
	step_end

TinTower1FSage1EntersMovement:
	step_up
	step_up
	step_left
	step_left
	turn_head_up
	step_end

TinTower1FSage2EntersMovement:
	step_up
	step_up
	step_end

TinTower1FSage3EntersMovement:
	step_up
	step_right
	step_right
	step_up
	step_end

TinTowerEusineSuicuneText:
	text "Eusine: Awesome!"
	line "Too awesome, even!"

	para "I've never seen a"
	line "battle that great."

	para "That was truly"
	line "inspiring to see."

	para "Suicune was tough,"
	line "but you were even"

	para "more incredible,"
	line "<PLAYER>."

	para "I heard Suicune's"
	line "mystic power"

	para "summons a rainbow-"
	line "colored #mon."

	para "Maybe, just maybe,"
	line "what went on today"

	para "will cause that"
	line "#mon to appear."

	para "I'm going to study"
	line "the legends more."

	para "Thanks for showing"
	line "me that fantastic"
	cont "battle."

	para "Later, <PLAYER>!"
	done

TinTower1FSage1Text:
	text "According to"
	line "legend…"

	para "When the souls of"
	line "#mon and humans"

	para "commune, from the"
	line "heavens descends a"

	para "#mon of rainbow"
	line "colors…"

	para "Could it mean the"
	line "legendary #mon"

	para "are testing us"
	line "humans?"
	done

TinTower1FSage2Text:
if DEF(FAITHFUL)
	text "When the Brass"
else
	text "When the Gong"
endc
	line "Tower burned down,"

	para "three nameless"
	line "#mon were said"

	para "to have perished."
	line "It was tragic."

	para "However…"

	para "A rainbow-colored"
	line "#mon…"

	para "In other words…"

	para "Ho-Oh descended"
	line "from the sky and"

	para "gave new life to"
	line "the three #mon."

	para "They are…"

	para "Suicune, Entei and"
	line "Raikou."

	para "That is what they"
	line "say."
	done

TinTower1FSage3Text:
	text "The two towers are"
	line "said to have been"

	para "built to foster"
	line "friendship and"

	para "hope between #-"
	line "mon and people."

	para "That was 700 years"
	line "ago, but the ideal"

	para "still remains"
	line "important today."
	done

TinTower1FSage4Text1:
	text "Ho-Oh appears to"
	line "have descended"

	para "upon this, the"
	line "Bell Tower!"
	done

TinTower1FSage5Text1:
	text "This will protect"
	line "you. Take it."
	done

TinTower1FSage5Text2:
	text "Now, go."
	done

TinTower1FSage6Text1:
	text "I believe you are"
	line "being tested."

	para "Free your mind"
	line "from uncertainty,"
	cont "and advance."
	done

TinTowerEusineHoOhText:
	text "I knew it."

	para "I knew you'd get"
	line "to see the #mon"

	para "of rainbow colors,"
	line "<PLAYER>."

	para "It happened just"
	line "as I envisioned."

	para "My research isn't"
	line "bad, I might say."

	para "I'm going to keep"
	line "studying #mon"

	para "to become a famous"
	line "#Maniac!"
	done

TinTower1FSage4Text2:
	text "The legendary"
	line "#mon are said"

	para "to embody three"
	line "powers…"

	para "The lightning that"
	line "struck the tower."

	para "The fire that"
	line "burned the tower."

	para "And the rain that"
	line "put out the fire…"
	done

TinTower1FSage5Text3:
	text "When the legendary"
	line "#mon appeared…"

	para "They struck terror"
	line "in those who saw"
	cont "their rise."

	para "And…"

	para "Some even took to"
	line "futile attacks."

	para "The legendary"
	line "#mon, knowing"

	para "their own power,"
	line "fled, ignoring the"
	cont "frightened people."
	done

TinTower1FSage6Text2:
	text "Of the legendary"
	line "#mon, Suicune"

	para "is said to be the"
	line "closest to Ho-Oh."

	para "I hear there may"
	line "also be a link to"

	para "#mon known as"
	line "Unown."

	para "The #mon Unown"
	line "must be sharing a"

	para "cooperative bond"
	line "with Suicune."
	done
