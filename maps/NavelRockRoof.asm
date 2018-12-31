NavelRockRoof_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_SPRITES, NavelRockRoofDailyLeafRematchCallback

NavelRockRoof_MapEventHeader:

.Warps: db 1
	warp_def 15, 9, 14, NAVEL_ROCK_INSIDE

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_LEAF, 8, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, Leaf, EVENT_LEAF_IN_NAVEL_ROCK
	person_event SPRITE_CHRIS, 8, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CHRIS_IN_NAVEL_ROCK
	person_event SPRITE_KRIS, 8, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_KRIS_IN_NAVEL_ROCK

const_value set 1
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
	checknite
	iffalse .Sun
	changeblock 6, 0, $76
	changeblock 8, 0, $77
	changeblock 6, 2, $7a
	changeblock 8, 2, $7b
.Sun
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .FemaleEndingSequence
	checkcode VAR_FACING
	if_equal UP, .RightMaleEndingSequence
	spriteface PLAYER, UP
	moveperson NAVELROCKROOF_CHRIS, 7, 8
	appear NAVELROCKROOF_CHRIS
	jump .EndingSequence

.RightMaleEndingSequence:
	applyonemovement PLAYER, slow_step_up
	appear NAVELROCKROOF_CHRIS
	jump .EndingSequence

.FemaleEndingSequence:
	checkcode VAR_FACING
	if_equal UP, .RightFemaleEndingSequence
	spriteface PLAYER, UP
	moveperson NAVELROCKROOF_KRIS, 7, 8
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
