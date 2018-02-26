SeafoamIslandsB4F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 6 ; warp events
	warp_event  3,  3, SEAFOAM_ISLANDS_B3F, 5
	warp_event  7, 11, SEAFOAM_ISLANDS_B3F, 6
	warp_event 25,  7, SEAFOAM_ISLANDS_B3F, 7
	warp_event 27,  2, SEAFOAM_ISLANDS_B3F, 8
	warp_event 31, 13, SEAFOAM_ISLANDS_B3F, 9
	warp_event 37, 13, SEAFOAM_ISLANDS_B3F, 10

	db 0 ; coord events

	db 0 ; bg events

	db 5 ; object events
	object_event 22, 13, SPRITE_ARTICUNO, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, SeafoamIslandsArticuno, EVENT_SEAFOAM_ISLANDS_ARTICUNO
	object_event 16, 16, SPRITE_LAPRAS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_FINAL_BIRD_SURF
	object_event 21, 16, SPRITE_LAWRENCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_FINAL_BIRD
	itemball_event 33,  7, NEVERMELTICE, 1, EVENT_SEAFOAM_ISLANDS_B4F_NEVERMELTICE
	itemball_event 23,  2, ULTRA_BALL, 1, EVENT_SEAFOAM_ISLANDS_B4F_ULTRA_BALL

	const_def 1 ; object constants
	const SEAFOAMISLANDSB4F_ARTICUNO
	const SEAFOAMISLANDSB4F_LAWRENCE_SURF
	const SEAFOAMISLANDSB4F_LAWRENCE

SeafoamIslandsB4FLawrenceEncounterScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	checkcode VAR_FACING
	ifequal UP, .up
	ifequal DOWN, .down
	ifequal LEFT, .left
.right
	appear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	applymovement SEAFOAMISLANDSB4F_LAWRENCE_SURF, SeafoamIslandsB4FMovementData_LawrenceSurfApproach1
	turnobject SEAFOAMISLANDSB4F_LAWRENCE_SURF, UP
	disappear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	appear SEAFOAMISLANDSB4F_LAWRENCE
	applymovement SEAFOAMISLANDSB4F_LAWRENCE, SeafoamIslandsB4FMovementData_LawrenceApproach
	turnobject PLAYER, DOWN
	jump .continue
.up
	moveobject SEAFOAMISLANDSB4F_LAWRENCE_SURF, 17, 16
	appear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	applymovement SEAFOAMISLANDSB4F_LAWRENCE_SURF, SeafoamIslandsB4FMovementData_LawrenceSurfApproach2
	turnobject SEAFOAMISLANDSB4F_LAWRENCE_SURF, UP
	disappear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	appear SEAFOAMISLANDSB4F_LAWRENCE
	applymovement SEAFOAMISLANDSB4F_LAWRENCE, SeafoamIslandsB4FMovementData_LawrenceApproach
	turnobject SEAFOAMISLANDSB4F_LAWRENCE, RIGHT
	turnobject PLAYER, LEFT
	jump .continue
.down
	moveobject SEAFOAMISLANDSB4F_LAWRENCE_SURF, 17, 16
	appear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	applymovement SEAFOAMISLANDSB4F_LAWRENCE_SURF, SeafoamIslandsB4FMovementData_LawrenceSurfApproach2
	turnobject SEAFOAMISLANDSB4F_LAWRENCE_SURF, UP
	disappear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	appear SEAFOAMISLANDSB4F_LAWRENCE
	applymovement SEAFOAMISLANDSB4F_LAWRENCE, SeafoamIslandsB4FMovementData_LawrenceApproach
	applymovement SEAFOAMISLANDSB4F_LAWRENCE, SeafoamIslandsB4FMovementData_LawrenceContinueDown
	turnobject SEAFOAMISLANDSB4F_LAWRENCE, RIGHT
	turnobject PLAYER, LEFT
	jump .continue
.left
	moveobject SEAFOAMISLANDSB4F_LAWRENCE_SURF, 18, 16
	appear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	applymovement SEAFOAMISLANDSB4F_LAWRENCE_SURF, SeafoamIslandsB4FMovementData_LawrenceSurfApproach3
	turnobject SEAFOAMISLANDSB4F_LAWRENCE_SURF, UP
	disappear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	appear SEAFOAMISLANDSB4F_LAWRENCE
	applymovement SEAFOAMISLANDSB4F_LAWRENCE, SeafoamIslandsB4FMovementData_LawrenceApproach
	applymovement SEAFOAMISLANDSB4F_LAWRENCE, SeafoamIslandsB4FMovementData_LawrenceContinueLeft
.continue
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext SeafoamIslandsB4FLawrenceSpeechText
	turnobject SEAFOAMISLANDSB4F_LAWRENCE, UP
	opentext
	writetext SeafoamIslandsB4FLawrenceEscapeRopeText
	pause 15
	closetext
	playsound SFX_WARP_TO
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear SEAFOAMISLANDSB4F_LAWRENCE
	waitsfx
	special Special_FadeInQuickly
	setevent EVENT_HEARD_LAWRENCES_FINAL_SPEECH
	clearevent EVENT_LAWRENCE_SHAMOUTI_SHRINE_RUINS
	special RestartMapMusic
	end

SeafoamIslandsArticuno:
	faceplayer
	opentext
	writetext ArticunoText
	cry ARTICUNO
	pause 15
	closetext
	loadwildmon ARTICUNO, 70
	writecode VAR_BATTLETYPE, BATTLETYPE_LEGENDARY
	startbattle
	disappear SEAFOAMISLANDSB4F_ARTICUNO
	setevent EVENT_SEAFOAM_ISLANDS_ARTICUNO
	reloadmapafterbattle
	writebyte ARTICUNO
	special SpecialMonCheck
	iffalse .NoBlanche
	setevent EVENT_CELADON_UNIVERSITY_BLANCHE
	clearevent EVENT_SHAMOUTI_COAST_BLANCHE
.NoBlanche
	checkevent EVENT_ROUTE_10_ZAPDOS
	iffalse .end
	checkevent EVENT_CINNABAR_VOLCANO_MOLTRES
	iffalse .end
	special SpecialBirdsCheck
	iffalse .end
	jump SeafoamIslandsB4FLawrenceEncounterScript
.end
	end

ArticunoText:
	text "Gyaoo!"
	done

SeafoamIslandsB4FLawrenceSpeechText:
	text "Lawrence: Hello"
	line "again, <PLAYER>."

	para "So you are collec-"
	line "ting legends too."
	cont "Did I inspire you?"

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

SeafoamIslandsB4FLawrenceEscapeRopeText:
	text "Lawrence used an"
	line "Escape Rope!"
	done

SeafoamIslandsB4FMovementData_LawrenceSurfApproach1:
	step_right
SeafoamIslandsB4FMovementData_LawrenceSurfApproach2:
	step_right
SeafoamIslandsB4FMovementData_LawrenceSurfApproach3:
	step_right
	step_right
	step_right
	step_end

SeafoamIslandsB4FMovementData_LawrenceApproach:
	step_up
	slow_step_up
	step_end

SeafoamIslandsB4FMovementData_LawrenceContinueDown:
	slow_step_up
	slow_step_up
	step_end

SeafoamIslandsB4FMovementData_LawrenceContinueLeft:
	slow_step_up
	slow_step_right
	step_end
