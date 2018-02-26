CinnabarVolcanoB2F_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, CinnabarVolcanoB2FBouldersLand

	db 3 ; warp events
	warp_event 13,  3, CINNABAR_VOLCANO_B1F, 5
	warp_event 25, 19, CINNABAR_VOLCANO_B1F, 6
	warp_event  6,  6, CINNABAR_VOLCANO_B1F, 7 ; hole

	db 0 ; coord events

	db 0 ; bg events

	db 4 ; object events
	object_event 18, 22, SPRITE_MOLTRES, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, CinnabarVolcanoMoltres, EVENT_CINNABAR_VOLCANO_MOLTRES
	object_event 12, 24, SPRITE_LAWRENCE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_FINAL_BIRD
	smashrock_event 21, 19
	itemball_event 18,  3, FLAME_ORB, 1, EVENT_CINNABAR_VOLCANO_B2F_FLAME_ORB

	const_def 1 ; object constants
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
	ifequal UP, .up
	ifequal DOWN, .down
	ifequal LEFT, .left
.right
	appear CINNABARVOLCANOB2F_LAWRENCE
	applymovement CINNABARVOLCANOB2F_LAWRENCE, CinnabarVolcanoB2FMovementData_LawrenceApproachLeftRight
	turnobject PLAYER, DOWN
	jump .continue
.up
	moveobject CINNABARVOLCANOB2F_LAWRENCE, 13, 24
	appear CINNABARVOLCANOB2F_LAWRENCE
	applymovement CINNABARVOLCANOB2F_LAWRENCE, CinnabarVolcanoB2FMovementData_LawrenceApproachUp
	turnobject CINNABARVOLCANOB2F_LAWRENCE, UP
	turnobject PLAYER, DOWN
	jump .continue
.down
	moveobject CINNABARVOLCANOB2F_LAWRENCE, 13, 24
	appear CINNABARVOLCANOB2F_LAWRENCE
	applymovement CINNABARVOLCANOB2F_LAWRENCE, CinnabarVolcanoB2FMovementData_LawrenceApproachDown
	jump .continue
.left
	moveobject CINNABARVOLCANOB2F_LAWRENCE, 14, 24
	appear CINNABARVOLCANOB2F_LAWRENCE
	applymovement CINNABARVOLCANOB2F_LAWRENCE, CinnabarVolcanoB2FMovementData_LawrenceApproachLeftRight
	turnobject CINNABARVOLCANOB2F_LAWRENCE, UP
	turnobject PLAYER, DOWN
.continue
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext CinnabarVolcanoB2FLawrenceSpeechText
	turnobject CINNABARVOLCANOB2F_LAWRENCE, UP
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
