const_value set 2
	const ROUTE10_ZAPDOS
	const ROUTE10_LAWRENCE
	const ROUTE10_LAWRENCES_ZAPDOS
	const ROUTE10_CHRIS
	const ROUTE10_KRIS
	const ROUTE10_CUT_TREE1
	const ROUTE10_CUT_TREE2
	const ROUTE10_CUT_TREE3
	const ROUTE10_CUT_TREE4

Route10North_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 2

	; callbacks

	dbw MAPCALLBACK_NEWMAP, .FlyPoint
	dbw MAPCALLBACK_OBJECTS, .Zapdos

.Trigger0:
	end

.Trigger1:
	priorityjump Route10NorthLawrenceEncounter1Script
	end

.FlyPoint:
	setflag ENGINE_FLYPOINT_ROCK_TUNNEL
	return

.Zapdos:
	checkevent EVENT_RETURNED_MACHINE_PART
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
	applymovement PLAYER, Route10NorthMovementData_PlayerStepDown
	showemote EMOTE_SHOCK, ROUTE10_LAWRENCE, 15
	special Special_FadeOutMusic
	pause 15
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceApproach1
	spriteface PLAYER, RIGHT
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	opentext
	writetext Route10NorthLawrenceGreetingText
	waitbutton
	closetext
	follow ROUTE10_LAWRENCE, PLAYER
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceShowZapdos
	stopfollow
	spriteface ROUTE10_LAWRENCE, UP
	spriteface PLAYER, UP
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .FemalePan
	appear ROUTE10_CHRIS
	applymovement PLAYER, Route10NorthMovementData_HidePlayer
	applymovement PLAYER, Route10NorthMovementData_PanUp
	pause 40
	applymovement PLAYER, Route10NorthMovementData_PanDown
	applymovement PLAYER, Route10NorthMovementData_ShowPlayer
	disappear ROUTE10_CHRIS
	jump .Finish
.FemalePan
	appear ROUTE10_KRIS
	applymovement PLAYER, Route10NorthMovementData_HidePlayer
	applymovement PLAYER, Route10NorthMovementData_PanUp
	pause 40
	moveperson ROUTE10_LAWRENCE, 13, 52
	applymovement PLAYER, Route10NorthMovementData_PanDown
	applymovement PLAYER, Route10NorthMovementData_ShowPlayer
	disappear ROUTE10_KRIS
.Finish
	spriteface ROUTE10_LAWRENCE, LEFT
	spriteface PLAYER, RIGHT
	opentext
	writetext Route10NorthLawrenceZapdosText
	waitbutton
	closetext
	appear ROUTE10_LAWRENCES_ZAPDOS
	playsound SFX_BALL_POOF
	spriteface ROUTE10_LAWRENCE, RIGHT
	waitsfx
	pause 15
	cry ZAPDOS
	waitsfx
	spriteface ROUTE10_LAWRENCE, DOWN
	opentext
	writetext Route10NorthLawrenceFlyText
	waitbutton
	closetext
	playsound SFX_FLY
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear ROUTE10_LAWRENCE
	disappear ROUTE10_LAWRENCES_ZAPDOS
	waitsfx
	pause 15
	special Special_FadeInQuickly
	variablesprite SPRITE_CERULEAN_CAPE_MISTY, SPRITE_MISTY
	dotrigger $0
	special RestartMapMusic
	end

Route10NorthLawrenceEncounter2Script:
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	variablesprite SPRITE_CERULEAN_CAPE_MISTY, SPRITE_LAWRENCE
	special RunCallback_04
	checkcode VAR_FACING
	if_equal UP, .up
	if_equal DOWN, .down
	if_equal LEFT, .left
.right
	moveperson ROUTE10_LAWRENCE, 7, 44
	moveperson ROUTE10_LAWRENCES_ZAPDOS, 10, 44
	appear ROUTE10_LAWRENCE
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceApproach2LeftRight
	spriteface PLAYER, LEFT
	jump .continue
.up
	moveperson ROUTE10_LAWRENCE, 8, 44
	moveperson ROUTE10_LAWRENCES_ZAPDOS, 12, 44
	appear ROUTE10_LAWRENCE
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceApproach2UpDown
	spriteface ROUTE10_LAWRENCE, DOWN
	jump .continue
.down
	moveperson ROUTE10_LAWRENCE, 8, 44
	moveperson ROUTE10_LAWRENCES_ZAPDOS, 12, 44
	appear ROUTE10_LAWRENCE
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceApproach2UpDown
	spriteface ROUTE10_LAWRENCE, UP
	jump .continue
.left
	moveperson ROUTE10_LAWRENCE, 9, 44
	moveperson ROUTE10_LAWRENCES_ZAPDOS, 12, 44
	appear ROUTE10_LAWRENCE
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceApproach2LeftRight
.continue
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	opentext
	writetext Route10NorthLawrenceSpeechText
	waitbutton
	closetext
	pause 15
	appear ROUTE10_LAWRENCES_ZAPDOS
	playsound SFX_BALL_POOF
	spriteface ROUTE10_LAWRENCE, LEFT
	waitsfx
	pause 15
	cry ZAPDOS
	waitsfx
	spriteface ROUTE10_LAWRENCE, DOWN
	opentext
	writetext Route10NorthLawrenceFlyText
	waitbutton
	closetext
	playsound SFX_FLY
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear ROUTE10_LAWRENCE
	disappear ROUTE10_LAWRENCES_ZAPDOS
	waitsfx
	pause 15
	special Special_FadeInQuickly
	variablesprite SPRITE_CERULEAN_CAPE_MISTY, SPRITE_MISTY
	setevent EVENT_HEARD_LAWRENCES_FINAL_SPEECH
	clearevent EVENT_LAWRENCE_VICTORY_ROAD
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
	writecode VAR_BATTLETYPE, BATTLETYPE_KANTO_LEGEND
	startbattle
	disappear ROUTE10_ZAPDOS
	setevent EVENT_ZAPDOS_GONE
	setevent EVENT_ROUTE_10_ZAPDOS
	reloadmapafterbattle
	checkevent EVENT_SEAFOAM_ISLANDS_ARTICUNO
	iffalse .end
	checkevent EVENT_CINNABAR_VOLCANO_MOLTRES
	iffalse .end
	special SpecialBirdsCheck
	iffalse .end
	jump Route10NorthLawrenceEncounter2Script
.end
	end

Route10RockTunnelSign:
	jumptext RockTunnelSignText

PowerPlantSign:
	jumptext PowerPlantSignText

Route10CutTree:
	jumpstd cuttree

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

	para "Meet me in Victory"
	line "Road, the last"

	para "known nest of"
	line "Moltres."

	para "I'll show you that"
	line "I deserve to own"
	cont "those Pokemon."
	done

RockTunnelSignText:
	text "Rock Tunnel"
	done

PowerPlantSignText:
	text "Kanto Power Plant"
	done

Route10NorthMovementData_PlayerStepDown:
	step_down
	step_end

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

Route10NorthMovementData_HidePlayer:
	hide_person
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

Route10NorthMovementData_ShowPlayer:
	show_person
	step_end

Route10North_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $23, $b, 1, ROUTE_10_POKECENTER_1F
	warp_def $33, $3, 1, POWER_PLANT
	warp_def $2b, $4, 1, ROCK_TUNNEL_2F
	warp_def $21, $8, 1, ROCK_TUNNEL_1F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 53, 5, SIGNPOST_READ, PowerPlantSign
	signpost 35, 7, SIGNPOST_READ, Route10RockTunnelSign

.PersonEvents:
	db 9
	person_event SPRITE_ZAPDOS, 44, 13, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route10Zapdos, EVENT_ROUTE_10_ZAPDOS
	person_event SPRITE_CERULEAN_CAPE_MISTY, 52, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_ROUTE_10
	person_event SPRITE_ZAPDOS, 52, 14, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCES_ZAPDOS_ROUTE_10
	person_event SPRITE_CHRIS, 52, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CHRIS_IN_NAVEL_ROCK
	person_event SPRITE_KRIS, 52, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_KRIS_IN_NAVEL_ROCK
	person_event SPRITE_CUT_TREE, 21, 7, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route10CutTree, EVENT_ROUTE_10_CUT_TREE_1
	person_event SPRITE_CUT_TREE, 21, 9, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route10CutTree, EVENT_ROUTE_10_CUT_TREE_2
	person_event SPRITE_CUT_TREE, 21, 11, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route10CutTree, EVENT_ROUTE_10_CUT_TREE_3
	person_event SPRITE_CUT_TREE, 21, 13, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route10CutTree, EVENT_ROUTE_10_CUT_TREE_4
