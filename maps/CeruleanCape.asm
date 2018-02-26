CeruleanCape_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  9,  5, BILLS_HOUSE, 1
	warp_event 38, 29, DIM_CAVE_2F, 1
	warp_event 39, 29, DIM_CAVE_2F, 1

	db 3 ; coord events
	coord_event  4,  6, 1, CeruleanCapeDateInterruptedTrigger1
	coord_event  4,  7, 1, CeruleanCapeDateInterruptedTrigger2
	coord_event  9, 12, 1, CeruleanCapeDateInterruptedTrigger3

	db 3 ; bg events
	bg_event  7,  5, SIGNPOST_JUMPTEXT, BillsHouseSignText
	bg_event 31, 12, SIGNPOST_ITEM + PEARL_STRING, EVENT_CERULEAN_CAPE_HIDDEN_PEARL_STRING
	bg_event 18,  3, SIGNPOST_ITEM + BOTTLE_CAP, EVENT_CERULEAN_CAPE_HIDDEN_BOTTLE_CAP

	db 16 ; object events
	object_event  8,  9, SPRITE_MISTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CERULEAN_CAPE_BOYFRIEND
	object_event  8,  9, SPRITE_VERMILION_LAWRENCE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CERULEAN_CAPE_MISTY
	object_event  8, 10, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CERULEAN_CAPE_BOYFRIEND
	object_event 25,  7, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerSwimmermRomeo, -1
	object_event 41, 16, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerSwimmermMalcolm, -1
	object_event 21, 23, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerSwimmermArmand, -1
	object_event 19, 13, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerBeautyBridget, -1
	object_event  1, 21, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerBeautyVeronica, -1
	object_event  0, 27, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerGentlemanCamus, -1
	object_event 41, 26, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerGentlemanGeoffrey, -1
	object_event 16, 32, SPRITE_VERMILION_LAWRENCE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerGuitaristfMorgan, -1
	object_event  7, 26, SPRITE_LADY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_TRAINER, 1, TrainerLadyJessica, -1
	object_event 32, 11, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerFisherLeroy, -1
	object_event -4, 8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_COOLTRAINER_M_BEFORE
	object_event -2, 8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x19f520, EVENT_ROUTE_25_COOLTRAINER_M_AFTER
	itemball_event 31, 12, SHELL_BELL, 1, EVENT_CERULEAN_CAPE_SHELL_BELL

	const_def 1 ; object constants
	const CERULEANCAPE_MISTY
	const CERULEANCAPE_MISTY_WALK
	const CERULEANCAPE_BOYFRIEND

CeruleanCapeDateInterruptedTrigger1:
	showemote EMOTE_HEART, CERULEANCAPE_MISTY, 15
	pause 30
	showemote EMOTE_SHOCK, CERULEANCAPE_BOYFRIEND, 10
	turnobject CERULEANCAPE_MISTY, DOWN
	applyonemovement CERULEANCAPE_BOYFRIEND, big_step_down
	disappear CERULEANCAPE_BOYFRIEND
	pause 15
	playmusic MUSIC_BEAUTY_ENCOUNTER
	turnobject CERULEANCAPE_MISTY, UP
	variablesprite SPRITE_VERMILION_LAWRENCE, SPRITE_MISTY
	special MapCallbackSprites_LoadUsedSpritesGFX
	appear CERULEANCAPE_MISTY_WALK
	turnobject CERULEANCAPE_MISTY_WALK, UP
	disappear CERULEANCAPE_MISTY
	pause 5
	applymovement CERULEANCAPE_MISTY_WALK, MovementData_0x19efed
	showtext UnknownText_0x19f006
	applymovement CERULEANCAPE_MISTY_WALK, MovementData_0x19effa
	jump CeruleanCapeDateFinishScript

CeruleanCapeDateInterruptedTrigger2:
	showemote EMOTE_HEART, CERULEANCAPE_MISTY, 15
	pause 30
	showemote EMOTE_SHOCK, CERULEANCAPE_BOYFRIEND, 10
	turnobject CERULEANCAPE_MISTY, DOWN
	applymovement CERULEANCAPE_BOYFRIEND, MovementData_0x19efea
	disappear CERULEANCAPE_BOYFRIEND
	pause 15
	playmusic MUSIC_BEAUTY_ENCOUNTER
	turnobject CERULEANCAPE_MISTY, UP
	variablesprite SPRITE_VERMILION_LAWRENCE, SPRITE_MISTY
	special MapCallbackSprites_LoadUsedSpritesGFX
	appear CERULEANCAPE_MISTY_WALK
	turnobject CERULEANCAPE_MISTY_WALK, UP
	disappear CERULEANCAPE_MISTY
	pause 5
	applymovement CERULEANCAPE_MISTY_WALK, MovementData_0x19eff4
	showtext UnknownText_0x19f006
	applymovement CERULEANCAPE_MISTY_WALK, MovementData_0x19effd
CeruleanCapeDateFinishScript:
	turnobject PLAYER, LEFT
	applymovement CERULEANCAPE_MISTY_WALK, MovementData_0x19f000
	disappear CERULEANCAPE_MISTY_WALK
	clearevent EVENT_TRAINERS_IN_CERULEAN_GYM
	variablesprite SPRITE_VERMILION_LAWRENCE, SPRITE_COOLTRAINER_F
	special MapCallbackSprites_LoadUsedSpritesGFX
	setscene $0
	special RestartMapMusic
	end

CeruleanCapeDateInterruptedTrigger3:
	showemote EMOTE_HEART, CERULEANCAPE_MISTY, 15
	pause 30
	turnobject CERULEANCAPE_BOYFRIEND, DOWN
	showemote EMOTE_SHOCK, CERULEANCAPE_BOYFRIEND, 10
	turnobject CERULEANCAPE_MISTY, DOWN
	applymovement CERULEANCAPE_BOYFRIEND, .RunAwayMovement1
	turnobject CERULEANCAPE_MISTY, UP
	applymovement CERULEANCAPE_BOYFRIEND, .RunAwayMovement2
	disappear CERULEANCAPE_BOYFRIEND
	pause 15
	playmusic MUSIC_BEAUTY_ENCOUNTER
	turnobject CERULEANCAPE_MISTY, DOWN
	variablesprite SPRITE_VERMILION_LAWRENCE, SPRITE_MISTY
	special MapCallbackSprites_LoadUsedSpritesGFX
	appear CERULEANCAPE_MISTY_WALK
	turnobject CERULEANCAPE_MISTY_WALK, DOWN
	disappear CERULEANCAPE_MISTY
	pause 5
	applymovement CERULEANCAPE_MISTY_WALK, .ApproachMovement
	showtext UnknownText_0x19f006
	applymovement CERULEANCAPE_MISTY_WALK, .LeaveMovement
	disappear CERULEANCAPE_MISTY_WALK
	clearevent EVENT_TRAINERS_IN_CERULEAN_GYM
	variablesprite SPRITE_VERMILION_LAWRENCE, SPRITE_COOLTRAINER_F
	special MapCallbackSprites_LoadUsedSpritesGFX
	setscene $0
	special RestartMapMusic
	end

.RunAwayMovement1:
	big_step_right
	big_step_up
	step_end

.RunAwayMovement2:
	big_step_up
	big_step_up
	step_end

.ApproachMovement:
	step_right
	step_down
	step_down
	step_end

.LeaveMovement:
	step_up
	step_up
	step_up
	step_up
	step_end

GenericTrainerSwimmermRomeo:
	generictrainer SWIMMERM, ROMEO, EVENT_BEAT_SWIMMERM_ROMEO, .SeenText, .BeatenText

	text "Being a good"
	line "Swimmer doesn't"

	para "make me a good"
	line "trainer…"
	done

.SeenText:
	text "Admire my fitness!"
	line "My victory is"
	cont "assured!"
	done

.BeatenText:
	text "Oh! That's it?"
	done

GenericTrainerSwimmermMalcolm:
	generictrainer SWIMMERM, MALCOLM, EVENT_BEAT_SWIMMERM_MALCOLM, .SeenText, .BeatenText

	text "Don't tell me,"
	line "you visit lots of"

	para "#mon Gyms,"
	line "right?"
	done

.SeenText:
	text "My #mon and I"
	line "swim together,"

	para "but we also"
	line "battle!"
	done

.BeatenText:
	text "I wish I were as"
	line "strong as you."
	done

GenericTrainerSwimmermArmand:
	generictrainer SWIMMERM, ARMAND, EVENT_BEAT_SWIMMERM_ARMAND, .SeenText, .BeatenText

	text "That gal on the"
	line "shore… Her music"
	cont "is good, but she's"

	para "distracting the"
	line "#mon!"
	done

.SeenText:
	text "Ugh. Would that"
	line "Guitarist on the"

	para "shore keep it"
	line "down?"
	done

.BeatenText:
	text "The guitar put me"
	line "off my stride!"
	done

GenericTrainerBeautyBridget:
	generictrainer BEAUTY, BRIDGET, EVENT_BEAT_BEAUTY_BRIDGET, .SeenText, .BeatenText

	text "I think the view"
	line "here is beautiful."
	cont "Don't you agree?"
	done

.SeenText:
	text "Hey! You're block-"
	line "ing my view!"
	done

.BeatenText:
	text "I was just trying"
	line "to enjoy the view…"
	done

GenericTrainerBeautyVeronica:
	generictrainer BEAUTY, VERONICA, EVENT_BEAT_BEAUTY_VERONICA, .SeenText, .BeatenText

	text "Treat me mean and"
	line "I'll tell you where"
	cont "to go!"

	para "Must be why I'm"
	line "single. …Haha!"
	done

.SeenText:
	text "I don't date much,"
	line "but when I do,"

	para "Cerulean Cape is"
	line "the perfect spot."
	done

.BeatenText:
	text "Treat 'em mean,"
	line "keep 'em keen,"
	cont "right?"
	done

GenericTrainerGentlemanCamus:
	generictrainer GENTLEMAN, CAMUS, EVENT_BEAT_GENTLEMAN_CAMUS, .SeenText, .BeatenText

	text "I was once a ta-"
	line "lented trainer,"

	para "but now I'm just an"
	line "old has-been."

	para "Enjoy it while"
	line "you're still young."
	done

.SeenText:
	text "Seeing you reminds"
	line "me of my own wild"
	cont "youth."
	done

.BeatenText:
	text "What a wild"
	line "battle!"
	done

GenericTrainerGentlemanGeoffrey:
	generictrainer GENTLEMAN, GEOFFREY, EVENT_BEAT_GENTLEMAN_GEOFFREY, .SeenText, .BeatenText

	text "Sometimes a change"
	line "is as good as a"
	cont "rest."

	para "I feel so refresh-"
	line "ed!"
	done

.SeenText:
	text "I wanted a change,"
	line "so I got into"
	cont "#mon!"
	done

.BeatenText:
	text "Despite my age, I'm"
	line "still a beginner."
	done

GenericTrainerGuitaristfMorgan:
	generictrainer GUITARISTF, MORGAN, EVENT_BEAT_GUITARISTF_MORGAN, .SeenText, .BeatenText

	text "The echoing cliffs"
	line "make the Cape a"
	cont "perfect sound-"
	cont "board!"
	done

.SeenText:
	text "Listen to that"
	line "reverb!"
	done

.BeatenText:
	text "What a rockin'"
	line "battle!"
	done

TrainerLadyJessica:
	trainer LADY, JESSICA, EVENT_BEAT_LADY_JESSICA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	checkevent EVENT_SPOKE_TO_LADY_JESSICA
	iftrue .SpokeAgain
	writetext .AfterText1
	setevent EVENT_SPOKE_TO_LADY_JESSICA
	waitendtext

.SpokeAgain:
	writetext .AfterText2
	clearevent EVENT_SPOKE_TO_LADY_JESSICA
	waitendtext

.SeenText:
	text "Ah! You there!"
	line "Care to battle"
	cont "with me?"
	done

.BeatenText:
	text "Oh no! I got my"
	line "dress all wet!"
	done

.AfterText1:
	text "I'll have to buy a"
	line "better #mon…"
	cont "………………"
	cont "And a new dress…"
	done

.AfterText2:
	text "Why are you still"
	line "here?"

	para "Stop staring at"
	line "me!"
	cont "………………"
	cont "Creep!"
	done

GenericTrainerFisherLeroy:
	generictrainer FISHER, LEROY, EVENT_BEAT_FISHER_LEROY, .SeenText, .BeatenText

	text "All I ever catch"
	line "catch is Magikarp…"
	done

.SeenText:
	text "I keep catching"
	line "the same #mon…"

	para "Maybe a battle"
	line "will turn things"
	cont "around for me."
	done

.BeatenText:
	text "Nothing ever goes"
	line "right for me now…"
	done

MovementData_0x19efea:
	big_step_down
	big_step_down
	step_end

MovementData_0x19efed:
	step_up
MovementData_0x19eff4:
	step_up
	step_up
	step_left
	step_left
	step_left
	step_end

MovementData_0x19effa:
	step_down
	step_left
	step_end

MovementData_0x19effd:
	step_up
	step_left
	step_end

MovementData_0x19f000:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

UnknownText_0x19f006:
	text "Misty: Aww! Why"
	line "did you have to"

	para "show up and bug us"
	line "now?"

	para "Do you know what"
	line "they call people"
	cont "like you?"

	para "Pests! You heard"
	line "me right, pest!"

	para "…"

	para "…Oh? Those Badges"
	line "you have… Are they"
	cont "Johto Gym Badges?"

	para "If you have eight,"
	line "you must be good."

	para "OK, then. Come to"
	line "Cerulean Gym."

	para "I'll be happy to"
	line "take you on."

	para "I'm Misty, the"
	line "Gym Leader in"
	cont "Cerulean."
	done

BillsHouseSignText:
	text "Sea Cottage"
	line "Bill's House"
	done
