CeruleanCape_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanCape_MapEventHeader:

.Warps: db 3
	warp_def 5, 9, 1, BILLS_HOUSE
	warp_def 29, 38, 1, DIM_CAVE_2F
	warp_def 29, 39, 1, DIM_CAVE_2F

.XYTriggers: db 3
	xy_trigger 1, 6, 4, CeruleanCapeDateInterruptedTrigger1
	xy_trigger 1, 7, 4, CeruleanCapeDateInterruptedTrigger2
	xy_trigger 1, 12, 9, CeruleanCapeDateInterruptedTrigger3

.Signposts: db 3
	signpost 5, 7, SIGNPOST_JUMPTEXT, BillsHouseSignText
	signpost 12, 31, SIGNPOST_ITEM + PEARL_STRING, EVENT_CERULEAN_CAPE_HIDDEN_PEARL_STRING
	signpost 3, 18, SIGNPOST_ITEM + BOTTLE_CAP, EVENT_CERULEAN_CAPE_HIDDEN_BOTTLE_CAP

.PersonEvents: db 15
	person_event SPRITE_CERULEAN_CAPE_MISTY, 9, 8, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_MISTY_BOYFRIEND
	person_event SPRITE_COOLTRAINER_M, 10, 8, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_MISTY_BOYFRIEND
	person_event SPRITE_SWIMMER_GUY, 7, 25, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerSwimmermRomeo, -1
	person_event SPRITE_SWIMMER_GUY, 16, 41, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerSwimmermMalcolm, -1
	person_event SPRITE_SWIMMER_GUY, 23, 21, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerSwimmermArmand, -1
	person_event SPRITE_BEAUTY, 13, 19, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 1, TrainerBeautyBridget, -1
	person_event SPRITE_BEAUTY, 21, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerBeautyVeronica, -1
	person_event SPRITE_GENTLEMAN, 27, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerGentlemanCamus, -1
	person_event SPRITE_GENTLEMAN, 26, 41, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerGentlemanGeoffrey, -1
	person_event SPRITE_COOLTRAINER_F, 33, 14, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerGuitaristfMorgan, -1
	person_event SPRITE_LADY, 26, 7, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerLadyJessica, -1
	person_event SPRITE_FISHER, 11, 32, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherLeroy, -1
	person_event SPRITE_COOLTRAINER_M, 8, -4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_COOLTRAINER_M_BEFORE
	person_event SPRITE_COOLTRAINER_M, 8, -2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x19f520, EVENT_ROUTE_25_COOLTRAINER_M_AFTER
	itemball_event 12, 31, SHELL_BELL, 1, EVENT_CERULEAN_CAPE_SHELL_BELL

const_value set 1
	const CERULEANCAPE_MISTY
	const CERULEANCAPE_MISTY_BOYFRIEND

CeruleanCapeDateInterruptedTrigger1:
	showemote EMOTE_HEART, CERULEANCAPE_MISTY, 15
	pause 30
	showemote EMOTE_SHOCK, CERULEANCAPE_MISTY_BOYFRIEND, 10
	spriteface CERULEANCAPE_MISTY, DOWN
	applyonemovement CERULEANCAPE_MISTY_BOYFRIEND, big_step_down
	disappear CERULEANCAPE_MISTY_BOYFRIEND
	pause 15
	playmusic MUSIC_BEAUTY_ENCOUNTER
	spriteface CERULEANCAPE_MISTY, UP
	pause 10
	applymovement CERULEANCAPE_MISTY, MovementData_0x19efed
	showtext UnknownText_0x19f006
	spriteface PLAYER, DOWN
	applymovement CERULEANCAPE_MISTY, MovementData_0x19effa
	jump CeruleanCapeDateFinishScript

CeruleanCapeDateInterruptedTrigger2:
	showemote EMOTE_HEART, CERULEANCAPE_MISTY, 15
	pause 30
	showemote EMOTE_SHOCK, CERULEANCAPE_MISTY_BOYFRIEND, 10
	spriteface CERULEANCAPE_MISTY, DOWN
	applymovement CERULEANCAPE_MISTY_BOYFRIEND, MovementData_0x19efea
	disappear CERULEANCAPE_MISTY_BOYFRIEND
	pause 15
	playmusic MUSIC_BEAUTY_ENCOUNTER
	spriteface CERULEANCAPE_MISTY, UP
	pause 10
	applymovement CERULEANCAPE_MISTY, MovementData_0x19eff4
	showtext UnknownText_0x19f006
	spriteface PLAYER, UP
	applymovement CERULEANCAPE_MISTY, MovementData_0x19effd
CeruleanCapeDateFinishScript:
	spriteface PLAYER, LEFT
	applymovement CERULEANCAPE_MISTY, MovementData_0x19f000
	disappear CERULEANCAPE_MISTY
	clearevent EVENT_TRAINERS_IN_CERULEAN_GYM
	dotrigger $0
	special RestartMapMusic
	end

CeruleanCapeDateInterruptedTrigger3:
	showemote EMOTE_HEART, CERULEANCAPE_MISTY, 15
	pause 30
	spriteface CERULEANCAPE_MISTY_BOYFRIEND, DOWN
	showemote EMOTE_SHOCK, CERULEANCAPE_MISTY_BOYFRIEND, 10
	spriteface CERULEANCAPE_MISTY, DOWN
	applymovement CERULEANCAPE_MISTY_BOYFRIEND, .RunAwayMovement1
	spriteface CERULEANCAPE_MISTY, UP
	applymovement CERULEANCAPE_MISTY_BOYFRIEND, .RunAwayMovement2
	disappear CERULEANCAPE_MISTY_BOYFRIEND
	pause 15
	playmusic MUSIC_BEAUTY_ENCOUNTER
	spriteface CERULEANCAPE_MISTY, DOWN
	pause 10
	applymovement CERULEANCAPE_MISTY, .ApproachMovement
	showtext UnknownText_0x19f006
	applymovement CERULEANCAPE_MISTY, .LeaveMovement
	disappear CERULEANCAPE_MISTY
	clearevent EVENT_TRAINERS_IN_CERULEAN_GYM
	dotrigger $0
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

TrainerSwimmermRomeo:
	trainer EVENT_BEAT_SWIMMERM_ROMEO, SWIMMERM, ROMEO, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Admire my fitness!"
	line "My victory is"
	cont "assured!"
	done

.BeatenText:
	text "Oh! That's it?"
	done

.AfterText:
	text "Being a good"
	line "Swimmer doesn't"

	para "make me a good"
	line "trainer…"
	done

TrainerSwimmermMalcolm:
	trainer EVENT_BEAT_SWIMMERM_MALCOLM, SWIMMERM, MALCOLM, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "Don't tell me,"
	line "you visit lots of"

	para "#mon Gyms,"
	line "right?"
	done

TrainerSwimmermArmand:
	trainer EVENT_BEAT_SWIMMERM_ARMAND, SWIMMERM, ARMAND, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "That gal on the"
	line "shore… Her music"
	cont "is good, but she's"

	para "distracting the"
	line "#mon!"
	done

TrainerBeautyBridget:
	trainer EVENT_BEAT_BEAUTY_BRIDGET, BEAUTY, BRIDGET, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Hey! You're block-"
	line "ing my view!"
	done

.BeatenText:
	text "I was just trying"
	line "to enjoy the view…"
	done

.AfterText:
	text "I think the view"
	line "here is beautiful."
	cont "Don't you agree?"
	done

TrainerBeautyVeronica:
	trainer EVENT_BEAT_BEAUTY_VERONICA, BEAUTY, VERONICA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "Treat me mean and"
	line "I'll tell you where"
	cont "to go!"

	para "Must be why I'm"
	line "single. …Haha!"
	done

TrainerGentlemanCamus:
	trainer EVENT_BEAT_GENTLEMAN_CAMUS, GENTLEMAN, CAMUS, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Seeing you reminds"
	line "me of my own wild"
	cont "youth."
	done

.BeatenText:
	text "What a wild"
	line "battle!"
	done

.AfterText:
	text "I was once a ta-"
	line "lented trainer,"

	para "but now I'm just an"
	line "old has-been."

	para "Enjoy it while"
	line "you're still young."
	done

TrainerGentlemanGeoffrey:
	trainer EVENT_BEAT_GENTLEMAN_GEOFFREY, GENTLEMAN, GEOFFREY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I wanted a change,"
	line "so I got into"
	cont "#mon!"
	done

.BeatenText:
	text "Despite my age, I'm"
	line "still a beginner."
	done

.AfterText:
	text "Sometimes a change"
	line "is as good as a"
	cont "rest."

	para "I feel so refresh-"
	line "ed!"
	done

TrainerGuitaristfMorgan:
	trainer EVENT_BEAT_GUITARISTF_MORGAN, GUITARISTF, MORGAN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Listen to that"
	line "reverb!"
	done

.BeatenText:
	text "What a rockin'"
	line "battle!"
	done

.AfterText:
	text "The echoing cliffs"
	line "make the Cape a"
	cont "perfect sound-"
	cont "board!"
	done

TrainerLadyJessica:
	trainer EVENT_BEAT_LADY_JESSICA, LADY, JESSICA, .SeenText, .BeatenText, 0, .Script

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

TrainerFisherLeroy:
	trainer EVENT_BEAT_FISHER_LEROY, FISHER, LEROY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "All I ever catch"
	line "catch is Magikarp…"
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
