NavelRockRoof_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_SPRITES, NavelRockRoofDailyLeafRematchCallback

	db 1 ; warp events
	warp_event  9, 15, NAVEL_ROCK_INSIDE, 14

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	object_event  8,  8, SPRITE_LEAF, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, Leaf, EVENT_LEAF_IN_NAVEL_ROCK
	object_event  8,  8, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CHRIS_IN_NAVEL_ROCK
	object_event  8,  8, SPRITE_KRIS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_KRIS_IN_NAVEL_ROCK

	const_def 1 ; object constants
	const NAVELROCKROOF_GREEN
	const NAVELROCKROOF_CHRIS
	const NAVELROCKROOF_KRIS

NavelRockRoofDailyLeafRematchCallback:
	disappear NAVELROCKROOF_GREEN
	checkflag ENGINE_LEAF_IN_NAVEL_ROCK
	iftrue .Disappear
	appear NAVELROCKROOF_GREEN
.Disappear
	return

.Appear:
	appear NAVELROCKROOF_GREEN
	return

Leaf:
	special Special_FadeOutMusic
	showtextfaceplayer LeafText
	winlosstext LeafWinLossText, LeafWinLossText
	loadtrainer LEAF, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special Special_FadeOutMusic
	showtextfaceplayer LeafAfterText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear NAVELROCKROOF_GREEN
	pause 15
	special Special_FadeInQuickly
	pause 30
	special HealParty
	refreshscreen
	checktime 1 << NITE
	iffalse .Sun
	changeblock 6, 0, $76
	changeblock 8, 0, $77
	changeblock 6, 2, $7a
	changeblock 8, 2, $7b
.Sun
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .FemaleEndingSequence
	checkcode VAR_FACING
	ifequal UP, .RightMaleEndingSequence
	turnobject PLAYER, UP
	moveobject NAVELROCKROOF_CHRIS, 7, 8
	appear NAVELROCKROOF_CHRIS
	jump .EndingSequence

.RightMaleEndingSequence:
	applyonemovement PLAYER, slow_step_up
	appear NAVELROCKROOF_CHRIS
	jump .EndingSequence

.FemaleEndingSequence:
	checkcode VAR_FACING
	ifequal UP, .RightFemaleEndingSequence
	turnobject PLAYER, UP
	moveobject NAVELROCKROOF_KRIS, 7, 8
	appear NAVELROCKROOF_KRIS
	jump .EndingSequence

.RightFemaleEndingSequence:
	applyonemovement PLAYER, slow_step_up
	appear NAVELROCKROOF_KRIS
.EndingSequence:
	applyonemovement PLAYER, hide_person
	pause 30
	applymovement PLAYER, NavelRockRoofPanUpMovementData
	pause 40
	disappear NAVELROCKROOF_CHRIS
	disappear NAVELROCKROOF_KRIS
	setevent EVENT_BEAT_LEAF
	credits
	end

LeafText:
	text "…………"
	line "…………!"
	done

LeafWinLossText:
	text "…!"
	done

LeafAfterText:
	text "…………"
	line "…………"
	done

NavelRockRoofPanUpMovementData:
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	step_end
