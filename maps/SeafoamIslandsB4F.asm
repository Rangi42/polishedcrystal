const_value set 2
	const SEAFOAMISLANDSB4F_ARTICUNO
	const SEAFOAMISLANDSB4F_POKE_BALL1
	const SEAFOAMISLANDSB4F_POKE_BALL2
	const SEAFOAMISLANDSB4F_LAWRENCE_SURF
	const SEAFOAMISLANDSB4F_LAWRENCE

SeafoamIslandsB4F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SeafoamIslandsB4FLawrenceEncounterScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	checkcode VAR_FACING
	if_equal UP, .up
	if_equal DOWN, .down
	if_equal LEFT, .left
.right
	appear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	applymovement SEAFOAMISLANDSB4F_LAWRENCE_SURF, SeafoamIslandsB4FMovementData_LawrenceSurfApproach1
	spriteface SEAFOAMISLANDSB4F_LAWRENCE_SURF, UP
	disappear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	appear SEAFOAMISLANDSB4F_LAWRENCE
	applymovement SEAFOAMISLANDSB4F_LAWRENCE, SeafoamIslandsB4FMovementData_LawrenceApproach
	spriteface PLAYER, DOWN
	jump .continue
.up
	moveperson SEAFOAMISLANDSB4F_LAWRENCE_SURF, 17, 16
	appear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	applymovement SEAFOAMISLANDSB4F_LAWRENCE_SURF, SeafoamIslandsB4FMovementData_LawrenceSurfApproach2
	spriteface SEAFOAMISLANDSB4F_LAWRENCE_SURF, UP
	disappear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	appear SEAFOAMISLANDSB4F_LAWRENCE
	applymovement SEAFOAMISLANDSB4F_LAWRENCE, SeafoamIslandsB4FMovementData_LawrenceApproach
	spriteface SEAFOAMISLANDSB4F_LAWRENCE, RIGHT
	spriteface PLAYER, LEFT
	jump .continue
.down
	moveperson SEAFOAMISLANDSB4F_LAWRENCE_SURF, 17, 16
	appear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	applymovement SEAFOAMISLANDSB4F_LAWRENCE_SURF, SeafoamIslandsB4FMovementData_LawrenceSurfApproach2
	spriteface SEAFOAMISLANDSB4F_LAWRENCE_SURF, UP
	disappear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	appear SEAFOAMISLANDSB4F_LAWRENCE
	applymovement SEAFOAMISLANDSB4F_LAWRENCE, SeafoamIslandsB4FMovementData_LawrenceApproach
	applymovement SEAFOAMISLANDSB4F_LAWRENCE, SeafoamIslandsB4FMovementData_LawrenceContinueDown
	spriteface SEAFOAMISLANDSB4F_LAWRENCE, RIGHT
	spriteface PLAYER, LEFT
	jump .continue
.left
	moveperson SEAFOAMISLANDSB4F_LAWRENCE_SURF, 18, 16
	appear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	applymovement SEAFOAMISLANDSB4F_LAWRENCE_SURF, SeafoamIslandsB4FMovementData_LawrenceSurfApproach3
	spriteface SEAFOAMISLANDSB4F_LAWRENCE_SURF, UP
	disappear SEAFOAMISLANDSB4F_LAWRENCE_SURF
	appear SEAFOAMISLANDSB4F_LAWRENCE
	applymovement SEAFOAMISLANDSB4F_LAWRENCE, SeafoamIslandsB4FMovementData_LawrenceApproach
	applymovement SEAFOAMISLANDSB4F_LAWRENCE, SeafoamIslandsB4FMovementData_LawrenceContinueLeft
.continue
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	opentext
	writetext SeafoamIslandsB4FLawrenceSpeechText
	waitbutton
	closetext
	spriteface SEAFOAMISLANDSB4F_LAWRENCE, UP
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
	clearevent EVENT_LAWRENCE_VICTORY_ROAD
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
	writecode VAR_BATTLETYPE, BATTLETYPE_KANTO_LEGEND
	startbattle
	disappear SEAFOAMISLANDSB4F_ARTICUNO
	setevent EVENT_SEAFOAM_ISLANDS_ARTICUNO
	reloadmapafterbattle
	checkevent EVENT_ROUTE_10_ZAPDOS
	iffalse .end
	checkevent EVENT_CINNABAR_VOLCANO_MOLTRES
	iffalse .end
	special SpecialBirdsCheck
	iffalse .end
	jump SeafoamIslandsB4FLawrenceEncounterScript
.end
	end

SeafoamIslandsB4FNeverMeltIce:
	itemball NEVERMELTICE

SeafoamIslandsB4FUltraBall:
	itemball ULTRA_BALL

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

	para "Meet me in Victory"
	line "Road, the last"

	para "known nest of"
	line "Moltres."

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

SeafoamIslandsB4F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $3, $3, 5, SEAFOAM_ISLANDS_B3F
	warp_def $b, $7, 6, SEAFOAM_ISLANDS_B3F
	warp_def $7, $19, 7, SEAFOAM_ISLANDS_B3F
	warp_def $2, $1b, 8, SEAFOAM_ISLANDS_B3F
	warp_def $d, $1f, 9, SEAFOAM_ISLANDS_B3F
	warp_def $d, $25, 10, SEAFOAM_ISLANDS_B3F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 5
	person_event SPRITE_ARTICUNO, 13, 22, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SeafoamIslandsArticuno, EVENT_SEAFOAM_ISLANDS_ARTICUNO
	person_event SPRITE_POKE_BALL, 7, 33, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, SeafoamIslandsB4FNeverMeltIce, EVENT_SEAFOAM_ISLANDS_B4F_NEVERMELTICE
	person_event SPRITE_POKE_BALL, 2, 23, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, SeafoamIslandsB4FUltraBall, EVENT_SEAFOAM_ISLANDS_B4F_ULTRA_BALL
	person_event SPRITE_LAPRAS, 16, 16, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_FINAL_BIRD_SURF
	person_event SPRITE_LAWRENCE, 16, 21, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_FINAL_BIRD
