Route10North_MapScriptHeader:
	def_scene_scripts
	scene_script Route10NorthTrigger0
	scene_script Route10NorthTrigger1

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route10NorthFlyPoint
	callback MAPCALLBACK_OBJECTS, Route10NorthZapdos

	def_warp_events
	warp_event 11, 35, ROUTE_10_POKECENTER_1F, 1
	warp_event  3, 51, POWER_PLANT, 1
	warp_event  4, 43, ROCK_TUNNEL_2F, 1
	warp_event  8, 33, ROCK_TUNNEL_1F, 1
	warp_event 10,  1, DIM_CAVE_5F, 1

	def_coord_events

	def_bg_events
	bg_event  5, 53, BGEVENT_JUMPTEXT, PowerPlantSignText
	bg_event  7, 35, BGEVENT_JUMPTEXT, RockTunnelSignText

	def_object_events
	object_event 13, 44, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, ZAPDOS, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route10Zapdos, EVENT_ROUTE_10_ZAPDOS
	object_event  6, 52, SPRITE_LAWRENCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_ROUTE_10
	object_event 14, 52, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, ZAPDOS, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCES_ZAPDOS_ROUTE_10
	object_event 12, 52, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_CHRIS_IN_NAVEL_ROCK
	object_event 12, 52, SPRITE_KRIS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_KRIS_IN_NAVEL_ROCK
	itemball_event 11,  3, FULL_RESTORE, 1, EVENT_ROUTE_10_FULL_RESTORE
	cuttree_event  7, 21, EVENT_ROUTE_10_CUT_TREE_1
	cuttree_event  9, 21, EVENT_ROUTE_10_CUT_TREE_2
	cuttree_event 11, 21, EVENT_ROUTE_10_CUT_TREE_3
	cuttree_event 13, 21, EVENT_ROUTE_10_CUT_TREE_4

; SPRITE_MOM is not in this map's overworld sprite set, so it default to the
; player sprite, whatever gender they are.

	object_const_def
	const ROUTE10_ZAPDOS
	const ROUTE10_LAWRENCE
	const ROUTE10_LAWRENCES_ZAPDOS
	const ROUTE10_CHRIS
	const ROUTE10_KRIS

Route10NorthTrigger1:
	priorityjump Route10NorthLawrenceEncounter1Script
Route10NorthTrigger0:
	end

Route10NorthFlyPoint:
	setflag ENGINE_FLYPOINT_ROCK_TUNNEL
	return

Route10NorthZapdos:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse .NoAppear
	checkevent EVENT_ZAPDOS_GONE
	iffalse .Appear
.NoAppear
	disappear ROUTE10_ZAPDOS
	return
.Appear:
	appear ROUTE10_ZAPDOS
	return

Route10NorthLawrenceEncounter1Script:
	applyonemovement PLAYER, step_down
	showemote EMOTE_SHOCK, ROUTE10_LAWRENCE, 15
	special Special_FadeOutMusic
	pause 15
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceApproach1
	turnobject PLAYER, RIGHT
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext Route10NorthLawrenceGreetingText
	follow ROUTE10_LAWRENCE, PLAYER
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceShowZapdos
	stopfollow
	turnobject ROUTE10_LAWRENCE, UP
	turnobject PLAYER, UP
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .FemalePan
	appear ROUTE10_CHRIS
	applyonemovement PLAYER, hide_object
	applymovement PLAYER, Route10NorthMovementData_PanUp
	pause 40
	disappear ROUTE10_LAWRENCE
	moveobject ROUTE10_LAWRENCE, 13, 52
	appear ROUTE10_LAWRENCE
	applymovement PLAYER, Route10NorthMovementData_PanDown
	applyonemovement PLAYER, show_object
	disappear ROUTE10_CHRIS
	jump .Finish
.FemalePan
	appear ROUTE10_KRIS
	applyonemovement PLAYER, hide_object
	applymovement PLAYER, Route10NorthMovementData_PanUp
	pause 40
	disappear ROUTE10_LAWRENCE
	moveobject ROUTE10_LAWRENCE, 13, 52
	appear ROUTE10_LAWRENCE
	applymovement PLAYER, Route10NorthMovementData_PanDown
	applyonemovement PLAYER, show_object
	disappear ROUTE10_KRIS
.Finish
	turnobject ROUTE10_LAWRENCE, LEFT
	turnobject PLAYER, RIGHT
	showtext Route10NorthLawrenceZapdosText
	appear ROUTE10_LAWRENCES_ZAPDOS
	playsound SFX_BALL_POOF
	turnobject ROUTE10_LAWRENCE, RIGHT
	waitsfx
	pause 15
	cry ZAPDOS
	waitsfx
	turnobject ROUTE10_LAWRENCE, DOWN
	showtext Route10NorthLawrenceFlyText
	playsound SFX_FLY
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear ROUTE10_LAWRENCE
	disappear ROUTE10_LAWRENCES_ZAPDOS
	waitsfx
	pause 15
	special Special_FadeInQuickly
	setscene $0
	special RestartMapMusic
	end

Route10NorthLawrenceEncounter2Script:
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	checkcode VAR_FACING
	ifequal UP, .up
	ifequal DOWN, .down
	ifequal LEFT, .left
.right
	moveobject ROUTE10_LAWRENCE, 7, 44
	moveobject ROUTE10_LAWRENCES_ZAPDOS, 10, 44
	appear ROUTE10_LAWRENCE
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceApproach2LeftRight
	turnobject PLAYER, LEFT
	jump .continue
.up
	moveobject ROUTE10_LAWRENCE, 8, 44
	moveobject ROUTE10_LAWRENCES_ZAPDOS, 12, 44
	appear ROUTE10_LAWRENCE
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceApproach2UpDown
	turnobject ROUTE10_LAWRENCE, DOWN
	jump .continue
.down
	moveobject ROUTE10_LAWRENCE, 8, 44
	moveobject ROUTE10_LAWRENCES_ZAPDOS, 12, 44
	appear ROUTE10_LAWRENCE
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceApproach2UpDown
	turnobject ROUTE10_LAWRENCE, UP
	jump .continue
.left
	moveobject ROUTE10_LAWRENCE, 9, 44
	moveobject ROUTE10_LAWRENCES_ZAPDOS, 12, 44
	appear ROUTE10_LAWRENCE
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceApproach2LeftRight
.continue
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext Route10NorthLawrenceSpeechText
	pause 15
	appear ROUTE10_LAWRENCES_ZAPDOS
	playsound SFX_BALL_POOF
	turnobject ROUTE10_LAWRENCE, LEFT
	waitsfx
	pause 15
	cry ZAPDOS
	waitsfx
	turnobject ROUTE10_LAWRENCE, DOWN
	showtext Route10NorthLawrenceFlyText
	playsound SFX_FLY
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear ROUTE10_LAWRENCE
	disappear ROUTE10_LAWRENCES_ZAPDOS
	waitsfx
	pause 15
	special Special_FadeInQuickly
	setevent EVENT_HEARD_LAWRENCES_FINAL_SPEECH
	clearevent EVENT_LAWRENCE_SHAMOUTI_SHRINE_RUINS
	special RestartMapMusic
	end

Route10Zapdos:
	faceplayer
	opentext
	writetext ZapdosText
	cry ZAPDOS
	pause 15
	closetext
	loadwildmon ZAPDOS, 60
	writecode VAR_BATTLETYPE, BATTLETYPE_LEGENDARY
	startbattle
	disappear ROUTE10_ZAPDOS
	setevent EVENT_ZAPDOS_GONE
	setevent EVENT_ROUTE_10_ZAPDOS
	reloadmapafterbattle
	writebyte ZAPDOS
	special SpecialMonCheck
	iffalse .NoSpark
	setevent EVENT_CELADON_UNIVERSITY_SPARK
	clearevent EVENT_SHAMOUTI_COAST_SPARK
.NoSpark
	checkevent EVENT_SEAFOAM_ISLANDS_ARTICUNO
	iffalse .end
	checkevent EVENT_CINNABAR_VOLCANO_MOLTRES
	iffalse .end
	special SpecialBirdsCheck
	iffalse .end
	jump Route10NorthLawrenceEncounter2Script
.end
	end

ZapdosText:
	text "Gyaoo!"
	done

Route10NorthLawrenceGreetingText:
	text "Lawrence: We meet"
	line "again, <PLAYER>."

	para "I came here in"
	line "search of the"

	para "legendary bird of"
	line "fire, but found"
	cont "the wrong one."

	para "Can you see up"
	line "there?"
	done

Route10NorthLawrenceZapdosText:
	text "Lawrence: That's"
	line "a Zapdos."

	para "It must have been"
	line "attracted by the"
	cont "generator."

	para "…So that was your"
	line "doing?"

	para "In that case, I'll"
	line "leave this legen-"

	para "dary #mon for"
	line "you to catch."

	para "You see, I have"
	line "no interest in"
	cont "duplicates."
	done

Route10NorthLawrenceFlyText:
	text "Lawrence: Zapdos,"
	line "Fly!"
	done

Route10NorthLawrenceSpeechText:
	text "Lawrence: Hello"
	line "again, <PLAYER>."

	para "So you wanted that"
	line "Zapdos after all."

	para "I was starting"
	line "to think you"

	para "didn't care about"
	line "the legends."

	para "…What?! You caught"
	line "all three birds?"
	cont "Impossible."

	para "Even I, with my"
	line "knowledge and"

	para "resources, have"
	line "not found Moltres…"

	para "Why have you"
	line "succeeded where I"
	cont "failed?"

	para "Can you appreciate"
	line "the majesty of the"
	cont "winged mirages?"

	para "Have you even"
	line "heard of the"

	para "guardian of the"
	line "sea before?"

	para "This is unaccept-"
	line "able."

	para "Meet me at the"
	line "ruined shrine on"
	cont "Shamouti Island."

	para "I'll show you that"
	line "I deserve to own"
	cont "those #mon."
	done

RockTunnelSignText:
	text "Rock Tunnel"
	done

PowerPlantSignText:
	text "Kanto Power Plant"
	done

Route10NorthMovementData_LawrenceApproach1:
	step_left
	step_left
	step_end

Route10NorthMovementData_LawrenceShowZapdos:
	step_right
	step_right
	step_right
	step_right
Route10NorthMovementData_LawrenceApproach2UpDown:
	step_right
Route10NorthMovementData_LawrenceApproach2LeftRight:
	step_right
	step_right
	step_right
	step_right
	step_end

Route10NorthMovementData_PanUp:
	fix_facing
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	remove_fixed_facing
	step_end

Route10NorthMovementData_PanDown:
	fix_facing
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	remove_fixed_facing
	step_end
