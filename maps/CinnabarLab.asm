CinnabarLab_MapScriptHeader:
	db 1 ; scene scripts
	scene_script CinnabarLabTrigger0

	db 0 ; callbacks

	db 0 ; warp events
;	warp_def $9, $e, 3, CINNABAR_LAB
;	warp_def $9, $f, 3, CINNABAR_LAB
;	warp_def $6, $2, 2, CINNABAR_LAB

	db 1 ; coord events
	coord_event  2,  6, 1, CinnabarLabCelebiEventScript

	db 8 ; bg events
	bg_event  8, 14, SIGNPOST_JUMPTEXT, CinnabarLabRoom1SignText
	bg_event  9, 14, SIGNPOST_JUMPTEXT, CinnabarLabLockedDoorText
	bg_event 16, 14, SIGNPOST_JUMPTEXT, CinnabarLabRoom2SignText
	bg_event 17, 14, SIGNPOST_JUMPTEXT, CinnabarLabLockedDoorText
	bg_event 24, 14, SIGNPOST_JUMPTEXT, CinnabarLabRoom3SignText
	bg_event 25, 14, SIGNPOST_JUMPTEXT, CinnabarLabLockedDoorText
	bg_event  3,  6, SIGNPOST_JUMPTEXT, CinnabarLabRoom4SignText
	bg_event  3,  6, SIGNPOST_ITEM + BERSERK_GENE, EVENT_CINNABAR_LAB_HIDDEN_BERSERK_GENE

	db 9 ; object events
	object_event 15,  6, SPRITE_GIOVANNI, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event 15,  4, SPRITE_ARMORED_MEWTWO, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event 11,  6, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event 20,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CINNABAR_LAB_SCIENTIST1
	object_event 11,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CINNABAR_LAB_SCIENTIST2
	object_event 15,  7, SPRITE_MEWTWO, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CINNABAR_LAB_MEWTWO
	object_event 14,  8, SPRITE_CELEBI, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CINNABAR_LAB_CELEBI
	object_event 15,  8, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CINNABAR_LAB_CHRIS
	object_event 15,  8, SPRITE_KRIS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CINNABAR_LAB_KRIS

	const_def 1 ; object constants
	const CINNABARLAB_GIOVANNI
	const CINNABARLAB_ARMORED_MEWTWO
	const CINNABARLAB_SCIENTIST1
	const CINNABARLAB_SCIENTIST2
	const CINNABARLAB_SCIENTIST3
	const CINNABARLAB_MEWTWO
	const CINNABARLAB_CELEBI
	const CINNABARLAB_CHRIS
	const CINNABARLAB_KRIS

CinnabarLabTrigger0:
	priorityjump CinnabarLabStepDownScript
	end

CinnabarLabStepDownScript:
	checkcode VAR_YCOORD
	ifnotequal $6, .Done
	checkcode VAR_XCOORD
	ifnotequal $2, .Done
	applyonemovement PLAYER, step_down
.Done
	setscene $1
	end

CinnabarLabCelebiEventScript:
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	pause 15
	setevent EVENT_CINNABAR_LAB_CELEBI
	setevent EVENT_CINNABAR_LAB_MEWTWO
	setevent EVENT_CINNABAR_LAB_CHRIS
	setevent EVENT_CINNABAR_LAB_KRIS
	clearevent EVENT_CINNABAR_LAB_SCIENTIST1
	setevent EVENT_CINNABAR_LAB_SCIENTIST2
	setscene $0
	warpfacing UP, CINNABAR_LAB, 15, 9
	special Special_FadeOutMusic
	pause 30
	showtext CinnabarLabContinueTestingText
	showemote EMOTE_SHOCK, CINNABARLAB_GIOVANNI, 15
	playmusic MUSIC_ROCKET_OVERTURE
	turnobject CINNABARLAB_GIOVANNI, DOWN
	showtext CinnabarLabGiovanniWhoAreYouText
	applymovement CINNABARLAB_GIOVANNI, CinnabarLabGiovanniStepAsideMovementData
	applymovement PLAYER, CinnabarLabPlayerStepsUpMovementData
	opentext
	writetext CinnabarLabGiovanniAttackText
	cry MEWTWO
	waitsfx
	closetext
	clearevent EVENT_TIME_TRAVELING
	winlosstext CinnabarLabGiovanniBeatenText, 0
	setlasttalked CINNABARLAB_GIOVANNI
	loadtrainer GIOVANNI, GIOVANNI1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special DeleteSavedMusic
	playmusic MUSIC_NONE
	setevent EVENT_TIME_TRAVELING
	showtext CinnabarLabGiovanniAfterText
	showemote EMOTE_SHOCK, CINNABARLAB_ARMORED_MEWTWO, 15
	opentext
	writetext CinnabarLabMewtwoText
	cry MEWTWO
	waitsfx
	closetext
	playmusic MUSIC_KANTO_LEGEND_BATTLE_XY
	pause 15
	playsound SFX_SWORDS_DANCE
	callasm BlindingFlash
	callasm BlindingFlash
	waitsfx
	pause 15
	playsound SFX_OUTRAGE
	callasm BlindingFlash
	callasm BlindingFlash
	waitsfx
	pause 15
	playsound SFX_EMBER
	callasm BlindingFlash
	callasm BlindingFlash
	earthquake 30
	waitsfx
	pause 15
	applymovement CINNABARLAB_ARMORED_MEWTWO, CinnabarLabMewtwoFloatsDownMovementData
	applymovement PLAYER, CinnabarLabPlayerStepsBackMovementData
	pause 15
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Female
	appear CINNABARLAB_CHRIS
	jump .Continue
.Female
	appear CINNABARLAB_KRIS
.Continue
	applyonemovement PLAYER, hide_person
	waitsfx
	showemote EMOTE_SHOCK, CINNABARLAB_GIOVANNI, 10
	cry MEWTWO
	waitsfx
	turnobject CINNABARLAB_ARMORED_MEWTWO, LEFT
	applymovement PLAYER, CinnabarLabPan1MovementData
	playsound SFX_PSYCHIC
	turnobject CINNABARLAB_SCIENTIST1, RIGHT
	showemote EMOTE_SHOCK, CINNABARLAB_SCIENTIST1, 10
	applymovement CINNABARLAB_SCIENTIST1, CinnabarLabScientist1Thrown1MovementData
	playsound SFX_TACKLE
	applymovement CINNABARLAB_SCIENTIST1, CinnabarLabScientist1Thrown2MovementData
	disappear CINNABARLAB_SCIENTIST1
	appear CINNABARLAB_SCIENTIST3
	turnobject CINNABARLAB_ARMORED_MEWTWO, RIGHT
	applymovement PLAYER, CinnabarLabPan2MovementData
	playsound SFX_PSYCHIC
	turnobject CINNABARLAB_SCIENTIST2, LEFT
	showemote EMOTE_SHOCK, CINNABARLAB_SCIENTIST2, 10
	applymovement CINNABARLAB_SCIENTIST2, CinnabarLabScientist2Thrown1MovementData
	playsound SFX_TACKLE
	applymovement CINNABARLAB_SCIENTIST2, CinnabarLabScientist2Thrown2MovementData
	waitsfx
	opentext
	writetext CinnabarLabGiovanniStopText
	pause 20
	closetext
	playsound SFX_PSYCHIC
	applymovement CINNABARLAB_GIOVANNI, CinnabarLabGiovanniThrown1MovementData
	turnobject CINNABARLAB_ARMORED_MEWTWO, UP
	applymovement PLAYER, CinnabarLabPan3MovementData
	waitsfx
	playsound SFX_TACKLE
	applyonemovement CINNABARLAB_GIOVANNI, jump_step_up
	waitsfx
	applymovement PLAYER, CinnabarLabPan4MovementData
	disappear CINNABARLAB_CHRIS
	disappear CINNABARLAB_KRIS
	turnobject CINNABARLAB_ARMORED_MEWTWO, DOWN
	pause 30
	applyonemovement CINNABARLAB_ARMORED_MEWTWO, slow_step_down
	playsound SFX_KINESIS
	special FadeOutPalettes
	pause 15
	disappear CINNABARLAB_ARMORED_MEWTWO
	appear CINNABARLAB_MEWTWO
	waitsfx
	special FadeInPalettes
	opentext
	writetext CinnabarLabMewtwoText
	cry MEWTWO
	waitsfx
	closetext
	playsound SFX_GAME_FREAK_LOGO_GS
	special FadeOutPalettes
	pause 30
	appear CINNABARLAB_CELEBI
	special FadeInPalettes
	waitsfx
	opentext
	writetext CinnabarLabCelebiText
	cry CELEBI
	waitsfx
	closetext
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	playsound SFX_PROTECT
	applymovement CINNABARLAB_CELEBI, CinnabarLabCelebiFloatsMovementData
	waitsfx
	playsound SFX_GAME_FREAK_LOGO_GS
	special FadeOutPalettes
	pause 30
	waitsfx
	setmapscene ILEX_FOREST, $1
	warp ILEX_FOREST, 10, 26
	end

CinnabarLabGiovanniStepAsideMovementData:
	slow_step_right
	slow_step_right
	turn_head_left
	step_end

CinnabarLabPlayerStepsUpMovementData:
	slow_step_up
	slow_step_up
	step_end

CinnabarLabMewtwoFloatsDownMovementData:
	set_sliding
	jump_step_down
	remove_sliding
	step_end

CinnabarLabPlayerStepsBackMovementData:
	fix_facing
	step_down
	remove_fixed_facing
	step_end

CinnabarLabPan1MovementData:
	big_step_left
	big_step_left
	big_step_left
	big_step_up
	big_step_up
	big_step_up
	step_end

CinnabarLabScientist1Thrown1MovementData:
	set_sliding
	fix_facing
	step_up
	step_up
	remove_fixed_facing
	remove_sliding
	big_step_left
	step_end

CinnabarLabScientist1Thrown2MovementData:
	jump_step_right
	turn_head_up
	step_end

CinnabarLabPan2MovementData:
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	step_end

CinnabarLabScientist2Thrown1MovementData:
	set_sliding
	fix_facing
	step_up
	step_up
	remove_fixed_facing
	remove_sliding
	big_step_right
	step_end

CinnabarLabScientist2Thrown2MovementData:
	jump_step_left
	turn_head_up
	step_end

CinnabarLabGiovanniThrown1MovementData:
	set_sliding
	step_left
	turn_head_down
	fix_facing
	step_up
	step_up
	remove_fixed_facing
	step_end

CinnabarLabPan3MovementData:
	step_up
	step_up
	step_end

CinnabarLabPan4MovementData:
	step_left
	step_left
	step_left
	step_down
	step_down
	step_down
	step_down
	step_down
	turn_head_up
	show_person
	step_end

CinnabarLabCelebiFloatsMovementData:
	turn_head_down
	fix_facing
	slow_step_up
	slow_step_up
	slow_step_up
	remove_fixed_facing
	step_end

CinnabarLabRoom1SignText:
	text "Cloning Room"
	done

CinnabarLabRoom2SignText:
	text "Cybernetics Room"
	done

CinnabarLabRoom3SignText:
	text "Storage Room"
	done

CinnabarLabRoom4SignText:
	text "Project Amber"
	line "Testing Room"

	para "ABSOLUTELY NO"
	line "ENTRY WITHOUT"
	cont "LEVEL 5 CLEARANCE"
	done

CinnabarLabLockedDoorText:
	text "It's locked…"
	done

CinnabarLabContinueTestingText:
	text "Continue the"
	line "tests. Your"

	para "creation has per-"
	line "formed very well"
	cont "so far, Dr.Fu--"
	done

CinnabarLabGiovanniWhoAreYouText:
	text "Who are you?!"
	line "You aren't part"
	cont "of Team Rocket."

	para "Are you a spy for"
	line "the police?"

	para "…Fine. You want to"
	line "know about Team"
	cont "Rocket's business?"
	cont "I'll show you."

	para "The world's most"
	line "powerful #mon…"
	done

CinnabarLabGiovanniAttackText:
	text "Giovanni: Attack!"
	done

CinnabarLabGiovanniBeatenText:
	text "Giovanni: What?!"
	line "Impossible!"
	done

CinnabarLabGiovanniAfterText:
	text "Giovanni: How was"
	line "a kid like you"

	para "able to beat the"
	line "perfect #mon?"

	para "It was created to"
	line "fight for me!"

	para "It shouldn't be"
	line "this useless!"
	done

CinnabarLabMewtwoText:
	text "???: Myuu!"
	done

CinnabarLabGiovanniStopText:
	text "Giovanni: Stop"
	line "this now!"
	done

CinnabarLabCelebiText:
	text "Celebi: Biii!"
	done
