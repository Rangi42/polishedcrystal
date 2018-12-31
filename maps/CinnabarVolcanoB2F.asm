CinnabarVolcanoB2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, CinnabarVolcanoB2FBouldersLand

CinnabarVolcanoB2F_MapEventHeader:

.Warps: db 3
	warp_def 3, 13, 5, CINNABAR_VOLCANO_B1F
	warp_def 19, 25, 6, CINNABAR_VOLCANO_B1F
	warp_def 6, 6, 7, CINNABAR_VOLCANO_B1F ; hole

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 4
	person_event SPRITE_MOLTRES, 22, 18, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CinnabarVolcanoMoltres, EVENT_CINNABAR_VOLCANO_MOLTRES
	person_event SPRITE_LAWRENCE, 24, 12, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_FINAL_BIRD
	smashrock_event 19, 21
	itemball_event 3, 18, FLAME_ORB, 1, EVENT_CINNABAR_VOLCANO_B2F_FLAME_ORB

const_value set 1
	const CINNABARVOLCANOB2F_MOLTRES
	const CINNABARVOLCANOB2F_LAWRENCE

CinnabarVolcanoB2FBouldersLand:
	checkevent EVENT_BOULDER_IN_CINNABAR_VOLCANO_B1F
	iffalse .skip1
	changeblock 6, 6, $5f
.skip1
	return

CinnabarVolcanoB2FLawrenceEncounterScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	checkcode VAR_FACING
	if_equal UP, .up
	if_equal DOWN, .down
	if_equal LEFT, .left
.right
	appear CINNABARVOLCANOB2F_LAWRENCE
	applymovement CINNABARVOLCANOB2F_LAWRENCE, CinnabarVolcanoB2FMovementData_LawrenceApproachLeftRight
	spriteface PLAYER, DOWN
	jump .continue
.up
	moveperson CINNABARVOLCANOB2F_LAWRENCE, 13, 24
	appear CINNABARVOLCANOB2F_LAWRENCE
	applymovement CINNABARVOLCANOB2F_LAWRENCE, CinnabarVolcanoB2FMovementData_LawrenceApproachUp
	spriteface CINNABARVOLCANOB2F_LAWRENCE, UP
	spriteface PLAYER, DOWN
	jump .continue
.down
	moveperson CINNABARVOLCANOB2F_LAWRENCE, 13, 24
	appear CINNABARVOLCANOB2F_LAWRENCE
	applymovement CINNABARVOLCANOB2F_LAWRENCE, CinnabarVolcanoB2FMovementData_LawrenceApproachDown
	jump .continue
.left
	moveperson CINNABARVOLCANOB2F_LAWRENCE, 14, 24
	appear CINNABARVOLCANOB2F_LAWRENCE
	applymovement CINNABARVOLCANOB2F_LAWRENCE, CinnabarVolcanoB2FMovementData_LawrenceApproachLeftRight
	spriteface CINNABARVOLCANOB2F_LAWRENCE, UP
	spriteface PLAYER, DOWN
.continue
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext CinnabarVolcanoB2FLawrenceSpeechText
	spriteface CINNABARVOLCANOB2F_LAWRENCE, UP
	opentext
	writetext CinnabarVolcanoB2FLawrenceEscapeRopeText
	pause 15
	closetext
	playsound SFX_WARP_TO
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear CINNABARVOLCANOB2F_LAWRENCE
	waitsfx
	special Special_FadeInQuickly
	setevent EVENT_HEARD_LAWRENCES_FINAL_SPEECH
	clearevent EVENT_LAWRENCE_SHAMOUTI_SHRINE_RUINS
	special RestartMapMusic
	end

CinnabarVolcanoMoltres:
	faceplayer
	opentext
	writetext MoltresText
	cry MOLTRES
	pause 15
	closetext
	loadwildmon MOLTRES, 70
	writecode VAR_BATTLETYPE, BATTLETYPE_LEGENDARY
	startbattle
	disappear CINNABARVOLCANOB2F_MOLTRES
	setevent EVENT_CINNABAR_VOLCANO_MOLTRES
	reloadmapafterbattle
	writebyte MOLTRES
	special SpecialMonCheck
	iffalse .NoCandela
	setevent EVENT_CELADON_UNIVERSITY_CANDELA
	clearevent EVENT_SHAMOUTI_COAST_CANDELA
.NoCandela
	checkevent EVENT_SEAFOAM_ISLANDS_ARTICUNO
	iffalse .end
	checkevent EVENT_ROUTE_10_ZAPDOS
	iffalse .end
	special SpecialBirdsCheck
	iffalse .end
	jump CinnabarVolcanoB2FLawrenceEncounterScript
.end
	end

MoltresText:
	text "Gyaoo!"
	done

CinnabarVolcanoB2FLawrenceSpeechText:
	text "Lawrence: Hello"
	line "again, <PLAYER>."

	para "So you are search-"
	line "ing for Moltres"
	cont "here too."
	cont "Did I inspire you?"

	para "…What?! You caught"
	line "it already?"
	cont "Impossible."

	para "I spent years"
	line "hunting through"

	para "Victory Road, and"
	line "the islands south"
	cont "of Kanto…"

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

CinnabarVolcanoB2FLawrenceEscapeRopeText:
	text "Lawrence used an"
	line "Escape Rope!"
	done

CinnabarVolcanoB2FMovementData_LawrenceApproachUp:
	step_right
	step_right
	step_right
	step_right
	step_right
	step_end

CinnabarVolcanoB2FMovementData_LawrenceApproachLeftRight:
	step_right
	step_right
	step_right
	step_right
	step_right
	step_up
	step_end

CinnabarVolcanoB2FMovementData_LawrenceApproachDown:
	step_right
	step_right
	step_right
	step_right
	step_right
	step_up
	step_up
	step_end
