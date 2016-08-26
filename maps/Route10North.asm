const_value set 2
	const ROUTE10_ZAPDOS
	const ROUTE10_LAWRENCE
	const ROUTE10_LAWRENCES_ZAPDOS
	const ROUTE10_CHRIS
	const ROUTE10_KRIS

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
	priorityjump Route10NorthEncounterLawrenceScript
	end

.Trigger1:
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

Route10NorthEncounterLawrenceScript:
	applymovement PLAYER, Route10NorthMovementData_PlayerStepDown
	showemote EMOTE_SHOCK, ROUTE10_LAWRENCE, 15
	special Special_FadeOutMusic
	pause 15
	applymovement ROUTE10_LAWRENCE, Route10NorthMovementData_LawrenceApproach
	spriteface PLAYER, RIGHT
	playmusic MUSIC_LAWRENCE
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
	pause 30
	applymovement PLAYER, Route10NorthMovementData_PanDown
	applymovement PLAYER, Route10NorthMovementData_ShowPlayer
	disappear ROUTE10_CHRIS
	jump .Finish
.FemalePan
	appear ROUTE10_KRIS
	applymovement PLAYER, Route10NorthMovementData_HidePlayer
	applymovement PLAYER, Route10NorthMovementData_PanUp
	pause 30
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
	dotrigger $1
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
	end

PowerPlantSign:
	jumptext PowerPlantSignText

Route10PokeCenterSign:
	jumpstd pokecentersign

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

PowerPlantSignText:
	text "Kanto Power Plant"
	done

Route10NorthMovementData_PlayerStepDown:
	step_down
	step_end

Route10NorthMovementData_LawrenceApproach:
	step_left
	step_left
	step_end

Route10NorthMovementData_LawrenceShowZapdos:
	step_right
	step_right
	step_right
	step_right
	step_right
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
	remove_fixed_facing
	step_end

Route10NorthMovementData_PanDown:
	fix_facing
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
	db 3
	warp_def $1, $b, 1, ROUTE_10_POKECENTER_1F
	warp_def $9, $3, 1, POWER_PLANT
	warp_def $3, $2, 1, ROCK_TUNNEL_2F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 11, 5, SIGNPOST_READ, PowerPlantSign
	signpost 1, 12, SIGNPOST_READ, Route10PokeCenterSign

.PersonEvents:
	db 5
	person_event SPRITE_ZAPDOS, 5, 13, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route10Zapdos, EVENT_ROUTE_10_ZAPDOS
	person_event SPRITE_CERULEAN_CAPE_MISTY, 10, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_ROUTE_10
	person_event SPRITE_ZAPDOS, 10, 14, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCES_ZAPDOS_ROUTE_10
	person_event SPRITE_CHRIS, 10, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CHRIS_IN_NAVEL_ROCK
	person_event SPRITE_KRIS, 10, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_KRIS_IN_NAVEL_ROCK
