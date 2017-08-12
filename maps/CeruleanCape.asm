CeruleanCape_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanCape_MapEventHeader:

.Warps: db 3
	warp_def $5, $b, 1, BILLS_HOUSE
	warp_def $1d, $2a, 1, DIM_CAVE_2F
	warp_def $1d, $2b, 1, DIM_CAVE_2F

.XYTriggers: db 2
	xy_trigger 1, $6, $6, UnknownScript_0x19eea0
	xy_trigger 1, $7, $6, UnknownScript_0x19eee0

.Signposts: db 3
	signpost 5, 9, SIGNPOST_JUMPTEXT, BillsHouseSignText
	signpost 12, 35, SIGNPOST_ITEM, CeruleanCapeHiddenPearlString
	signpost 4, 14, SIGNPOST_ITEM, CeruleanCapeHiddenBottleCap

.PersonEvents: db 15
	person_event SPRITE_CERULEAN_CAPE_MISTY, 9, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_MISTY_BOYFRIEND
	person_event SPRITE_COOLTRAINER_M, 10, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_MISTY_BOYFRIEND
	person_event SPRITE_COOLTRAINER_M, 8, 1, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x19efac, -1
	person_event SPRITE_BALL_CUT_FRUIT, 6, -2, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_CUT_TREE
	person_event SPRITE_SWIMMER_GUY, 7, 27, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerSwimmermRomeo, -1
	person_event SPRITE_SWIMMER_GUY, 16, 45, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerSwimmermMalcolm, -1
	person_event SPRITE_SWIMMER_GUY, 23, 25, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerSwimmermArmand, -1
	person_event SPRITE_CERULEAN_CAPE_MISTY, 12, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBeautyBridget, -1
	person_event SPRITE_CERULEAN_CAPE_MISTY, 21, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBeautyVeronica, -1
	person_event SPRITE_GENTLEMAN, 27, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerGentlemanCamus, -1
	person_event SPRITE_GENTLEMAN, 26, 45, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerGentlemanGeoffrey, -1
	person_event SPRITE_COOLTRAINER_F, 32, 21, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 5, TrainerGuitaristfMorgan, -1
	person_event SPRITE_LADY, 26, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerLadyJessica, -1
	person_event SPRITE_FISHER, 11, 36, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherLeroy, -1
	person_event SPRITE_BALL_CUT_FRUIT, 12, 35, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEBALL, PLAYEREVENT_ITEMBALL, SHELL_BELL, 1, EVENT_CERULEAN_CAPE_SHELL_BELL

const_value set 2
	const CERULEANCAPE_MISTY
	const CERULEANCAPE_MISTY_BOYFRIEND

UnknownScript_0x19eea0:
	showemote EMOTE_HEART, CERULEANCAPE_MISTY, 15
	pause 30
	showemote EMOTE_SHOCK, CERULEANCAPE_MISTY_BOYFRIEND, 10
	spriteface CERULEANCAPE_MISTY, DOWN
	applymovement CERULEANCAPE_MISTY_BOYFRIEND, MovementData_0x19efe8
	disappear CERULEANCAPE_MISTY_BOYFRIEND
	pause 15
	playmusic MUSIC_BEAUTY_ENCOUNTER
	spriteface CERULEANCAPE_MISTY, UP
	pause 10
	applymovement CERULEANCAPE_MISTY, MovementData_0x19efed
	showtext UnknownText_0x19f006
	spriteface PLAYER, DOWN
	applymovement CERULEANCAPE_MISTY, MovementData_0x19effa
	spriteface PLAYER, LEFT
	applymovement CERULEANCAPE_MISTY, MovementData_0x19f000
	disappear CERULEANCAPE_MISTY
	clearevent EVENT_TRAINERS_IN_CERULEAN_GYM
	dotrigger $0
	special RestartMapMusic
	end

UnknownScript_0x19eee0:
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
	spriteface PLAYER, LEFT
	applymovement CERULEANCAPE_MISTY, MovementData_0x19f000
	disappear CERULEANCAPE_MISTY
	clearevent EVENT_TRAINERS_IN_CERULEAN_GYM
	dotrigger $0
	variablesprite SPRITE_CERULEAN_CAPE_MISTY, SPRITE_BEAUTY
	special MapCallbackSprites_LoadUsedSpritesGFX
	special RestartMapMusic
	end

CooltrainerMScript_0x19efac:
	faceplayer
	opentext
	checkevent EVENT_BEAT_COOLTRAINERM_KEVIN
	iftrue UnknownScript_0x19efda
	checkevent EVENT_CLEARED_NUGGET_BRIDGE
	iftrue UnknownScript_0x19efc7
	writetext UnknownText_0x19f43b
	buttonsound
	verbosegiveitem NUGGET
	iffalse UnknownScript_0x19efde
	setevent EVENT_CLEARED_NUGGET_BRIDGE
UnknownScript_0x19efc7:
	writetext UnknownText_0x19f49d
	waitbutton
	closetext
	winlosstext UnknownText_0x19f4fd, 0
	loadtrainer COOLTRAINERM, KEVIN
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_KEVIN
	opentext
UnknownScript_0x19efda:
	writetext UnknownText_0x19f520
	waitbutton
UnknownScript_0x19efde:
	closetext
	end

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
	waitbutton
	closetext
	end

.SpokeAgain:
	writetext .AfterText2
	clearevent EVENT_SPOKE_TO_LADY_JESSICA
	waitbutton
	closetext
	end

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

CeruleanCapeHiddenPearlString:
	dwb EVENT_CERULEAN_CAPE_HIDDEN_PEARL_STRING, PEARL_STRING

CeruleanCapeHiddenBottleCap:
	dwb EVENT_CERULEAN_CAPE_HIDDEN_BOTTLE_CAP, BOTTLE_CAP

MovementData_0x19efe8:
	big_step_down
	step_end

MovementData_0x19efea:
	big_step_down
	big_step_down
	step_end

MovementData_0x19efed:
	step_up
	step_up
	step_up
	step_left
	step_left
	step_left
	step_end

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

UnknownText_0x19f43b:
	text "You took on one"
	line "more battle than"

	para "you expected, but"
	line "you won anyway."

	para "As promised, you"
	line "win a prize."
	done

UnknownText_0x19f49d:
	text "But after seeing"
	line "how you battle, I"

	para "want to see how"
	line "I'll fare."

	para "How about it? Let"
	line "me take you on."
	done

UnknownText_0x19f4fd:
	text "I've never had a"
	line "battle this good!"
	done

UnknownText_0x19f520:
	text "That was a great"
	line "battle!"

	para "You and your #-"
	line "mon are truly out-"
	cont "standing!"
	done

BillsHouseSignText:
	text "Sea Cottage"
	line "Bill's House"
	done
