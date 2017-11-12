Route10North_MapScriptHeader:

.MapTriggers: db 2
	dw Route10NorthTrigger0
	dw Route10NorthTrigger1

.MapCallbacks: db 2
	dbw MAPCALLBACK_NEWMAP, Route10NorthFlyPoint
	dbw MAPCALLBACK_OBJECTS, Route10NorthZapdos

Route10North_MapEventHeader:

.Warps: db 5
	warp_def 35, 11, 1, ROUTE_10_POKECENTER_1F
	warp_def 51, 3, 1, POWER_PLANT
	warp_def 43, 4, 1, ROCK_TUNNEL_2F
	warp_def 33, 8, 1, ROCK_TUNNEL_1F
	warp_def 1, 10, 1, DIM_CAVE_5F

.XYTriggers: db 0

.Signposts: db 2
	signpost 53, 5, SIGNPOST_JUMPTEXT, PowerPlantSignText
	signpost 35, 7, SIGNPOST_JUMPTEXT, RockTunnelSignText

.PersonEvents: db 10
	person_event SPRITE_ZAPDOS, 44, 13, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route10Zapdos, EVENT_ROUTE_10_ZAPDOS
	person_event SPRITE_CERULEAN_CAPE_MISTY, 52, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_ROUTE_10
	person_event SPRITE_ZAPDOS, 52, 14, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCES_ZAPDOS_ROUTE_10
	person_event SPRITE_PLAYER, 52, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CHRIS_IN_NAVEL_ROCK
	person_event SPRITE_PLAYER, 52, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_KRIS_IN_NAVEL_ROCK
	itemball_event 3, 11, FULL_RESTORE, 1, EVENT_ROUTE_10_FULL_RESTORE
	cuttree_event 21, 7, EVENT_ROUTE_10_CUT_TREE_1
	cuttree_event 21, 9, EVENT_ROUTE_10_CUT_TREE_2
	cuttree_event 21, 11, EVENT_ROUTE_10_CUT_TREE_3
	cuttree_event 21, 13, EVENT_ROUTE_10_CUT_TREE_4

const_value set 1
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
	applyonemovement PLAYER, step_down
	showemote EMOTE_SHOCK, ROUTE10_LAWRENCE, 15
	special Special_FadeOutMusic
	pause 15
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceApproach1
	spriteface PLAYER, RIGHT
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext Route10NorthLawrenceGreetingText
	follow ROUTE10_LAWRENCE, PLAYER
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceShowZapdos
	stopfollow
	spriteface ROUTE10_LAWRENCE, UP
	spriteface PLAYER, UP
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .FemalePan
	appear ROUTE10_CHRIS
	applyonemovement PLAYER, hide_person
	applymovement PLAYER, Route10NorthMovementData_PanUp
	pause 40
	applymovement PLAYER, Route10NorthMovementData_PanDown
	applyonemovement PLAYER, show_person
	disappear ROUTE10_CHRIS
	jump .Finish
.FemalePan
	appear ROUTE10_KRIS
	applyonemovement PLAYER, hide_person
	applymovement PLAYER, Route10NorthMovementData_PanUp
	pause 40
	disappear ROUTE10_LAWRENCE
	moveperson ROUTE10_LAWRENCE, 13, 52
	appear ROUTE10_LAWRENCE
	applymovement PLAYER, Route10NorthMovementData_PanDown
	applyonemovement PLAYER, show_person
	disappear ROUTE10_KRIS
.Finish
	spriteface ROUTE10_LAWRENCE, LEFT
	spriteface PLAYER, RIGHT
	showtext Route10NorthLawrenceZapdosText
	appear ROUTE10_LAWRENCES_ZAPDOS
	playsound SFX_BALL_POOF
	spriteface ROUTE10_LAWRENCE, RIGHT
	waitsfx
	pause 15
	cry ZAPDOS
	waitsfx
	spriteface ROUTE10_LAWRENCE, DOWN
	showtext Route10NorthLawrenceFlyText
	playsound SFX_FLY
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear ROUTE10_LAWRENCE
	disappear ROUTE10_LAWRENCES_ZAPDOS
	waitsfx
	pause 15
	special Special_FadeInQuickly
	variablesprite SPRITE_CERULEAN_CAPE_MISTY, SPRITE_MISTY
	special MapCallbackSprites_LoadUsedSpritesGFX
	dotrigger $0
	special RestartMapMusic
	end

Route10NorthLawrenceEncounter2Script:
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	variablesprite SPRITE_CERULEAN_CAPE_MISTY, SPRITE_LAWRENCE
	special MapCallbackSprites_LoadUsedSpritesGFX
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
	showtext Route10NorthLawrenceSpeechText
	pause 15
	appear ROUTE10_LAWRENCES_ZAPDOS
	playsound SFX_BALL_POOF
	spriteface ROUTE10_LAWRENCE, LEFT
	waitsfx
	pause 15
	cry ZAPDOS
	waitsfx
	spriteface ROUTE10_LAWRENCE, DOWN
	showtext Route10NorthLawrenceFlyText
	playsound SFX_FLY
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear ROUTE10_LAWRENCE
	disappear ROUTE10_LAWRENCES_ZAPDOS
	waitsfx
	pause 15
	special Special_FadeInQuickly
	variablesprite SPRITE_CERULEAN_CAPE_MISTY, SPRITE_MISTY
	special MapCallbackSprites_LoadUsedSpritesGFX
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
	cont "those Pokemon."
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
