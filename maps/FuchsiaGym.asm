FuchsiaGym_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  4, 17, FUCHSIA_CITY, 2
	warp_event  5, 17, FUCHSIA_CITY, 2

	db 0 ; coord events

	db 2 ; bg events
	bg_event  3, 15, SIGNPOST_READ, FuchsiaGymStatue
	bg_event  6, 15, SIGNPOST_READ, FuchsiaGymStatue

	db 6 ; object events
	object_event  5,  7, SPRITE_JANINE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, JanineScript_0x195db9, -1
	object_event  1, 10, SPRITE_FUCHSIA_GYM_1, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, FuchsiaGym1Script_0x195e1b, -1
	object_event  5, 11, SPRITE_FUCHSIA_GYM_2, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, FuchsiaGym2Script_0x195e55, -1
	object_event  9,  4, SPRITE_FUCHSIA_GYM_3, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, FuchsiaGym3Script_0x195e8f, -1
	object_event  4,  2, SPRITE_FUCHSIA_GYM_4, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, FuchsiaGym4Script_0x195ec9, -1
	object_event  7, 15, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, FuchsiaGymGuyScript, -1

	const_def 1 ; object constants
	const FUCHSIAGYM_JANINE
	const FUCHSIAGYM_FUCHSIA_GYM_1
	const FUCHSIAGYM_FUCHSIA_GYM_2
	const FUCHSIAGYM_FUCHSIA_GYM_3
	const FUCHSIAGYM_FUCHSIA_GYM_4

JanineScript_0x195db9:
	checkflag ENGINE_MARSHBADGE
	iftrue .FightDone
	applymovement FUCHSIAGYM_JANINE, MovementData_0x195f27
	showtextfaceplayer UnknownText_0x195f35
	winlosstext UnknownText_0x195fa1, 0
	loadtrainer JANINE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_JANINE
	setevent EVENT_BEAT_LASS_AMANDA
	setevent EVENT_BEAT_LASS_LINDA
	setevent EVENT_BEAT_PICNICKER_CINDY
	setevent EVENT_BEAT_CAMPER_BARRY
	variablesprite SPRITE_FUCHSIA_GYM_1, SPRITE_LASS
	variablesprite SPRITE_FUCHSIA_GYM_2, SPRITE_LASS
	variablesprite SPRITE_FUCHSIA_GYM_3, SPRITE_LASS
	variablesprite SPRITE_FUCHSIA_GYM_4, SPRITE_YOUNGSTER
	special MapCallbackSprites_LoadUsedSpritesGFX
	opentext
	writetext UnknownText_0x195feb
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_MARSHBADGE
	checkcode VAR_BADGES
	ifequal 9, .FirstBadge
	ifequal 10, .SecondBadge
	ifequal 12, .LyrasEgg
	jump UnknownScript_0x195e02
.FirstBadge:
	specialphonecall SPECIALCALL_FIRSTBADGE
	jump UnknownScript_0x195e02
.SecondBadge:
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	iftrue UnknownScript_0x195e02
	specialphonecall SPECIALCALL_SECONDBADGE
	jump UnknownScript_0x195e02
.LyrasEgg:
	specialphonecall SPECIALCALL_LYRASEGG
	jump UnknownScript_0x195e02
.FightDone:
	faceplayer
	opentext
UnknownScript_0x195e02:
	checkevent EVENT_GOT_TM66_POISON_JAB
	iftrue_jumpopenedtext UnknownText_0x196074
	writetext UnknownText_0x196002
	buttonsound
	verbosegivetmhm TM_POISON_JAB
	setevent EVENT_GOT_TM66_POISON_JAB
	thisopenedtext

	text "It's Poison Jab,"
	line "a powerful Poison-"

	para "type move that"
	line "may poison its"
	cont "victim."
	done

FuchsiaGym1Script_0x195e1b:
	checkevent EVENT_BEAT_LASS_AMANDA
	iftrue UnknownScript_0x195e2c
	applymovement FUCHSIAGYM_FUCHSIA_GYM_1, MovementData_0x195f27
	faceplayer
	variablesprite SPRITE_FUCHSIA_GYM_1, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
UnknownScript_0x195e2c:
	checkevent EVENT_BEAT_LASS_AMANDA
	iftrue_jumptextfaceplayer UnknownText_0x196139
	faceplayer
	showtext UnknownText_0x1960e6
	winlosstext UnknownText_0x196126, 0
	loadtrainer LASS, AMANDA
	startbattle
	iftrue UnknownScript_0x195e4a
	reloadmapafterbattle
	setevent EVENT_BEAT_LASS_AMANDA
	end

UnknownScript_0x195e4a:
	variablesprite SPRITE_FUCHSIA_GYM_1, SPRITE_JANINE
	reloadmapafterbattle
	end

FuchsiaGym2Script_0x195e55:
	checkevent EVENT_BEAT_LASS_LINDA
	iftrue UnknownScript_0x195e66
	applymovement FUCHSIAGYM_FUCHSIA_GYM_2, MovementData_0x195f27
	faceplayer
	variablesprite SPRITE_FUCHSIA_GYM_2, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
UnknownScript_0x195e66:
	checkevent EVENT_BEAT_LASS_LINDA
	iftrue_jumptextfaceplayer UnknownText_0x196199
	faceplayer
	showtext UnknownText_0x196166
	winlosstext UnknownText_0x19617b, 0
	loadtrainer LASS, LINDA
	startbattle
	iftrue UnknownScript_0x195e84
	reloadmapafterbattle
	setevent EVENT_BEAT_LASS_LINDA
	end

UnknownScript_0x195e84:
	variablesprite SPRITE_FUCHSIA_GYM_2, SPRITE_JANINE
	reloadmapafterbattle
	end

FuchsiaGym3Script_0x195e8f:
	checkevent EVENT_BEAT_PICNICKER_CINDY
	iftrue UnknownScript_0x195ea0
	applymovement FUCHSIAGYM_FUCHSIA_GYM_3, MovementData_0x195f27
	faceplayer
	variablesprite SPRITE_FUCHSIA_GYM_3, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
UnknownScript_0x195ea0:
	checkevent EVENT_BEAT_PICNICKER_CINDY
	iftrue_jumptextfaceplayer UnknownText_0x19620c
	faceplayer
	showtext UnknownText_0x1961bb
	winlosstext UnknownText_0x1961f1, 0
	loadtrainer PICNICKER, CINDY
	startbattle
	iftrue UnknownScript_0x195ebe
	reloadmapafterbattle
	setevent EVENT_BEAT_PICNICKER_CINDY
	end

UnknownScript_0x195ebe:
	variablesprite SPRITE_FUCHSIA_GYM_3, SPRITE_JANINE
	reloadmapafterbattle
	end

FuchsiaGym4Script_0x195ec9:
	checkevent EVENT_BEAT_CAMPER_BARRY
	iftrue UnknownScript_0x195eda
	applymovement FUCHSIAGYM_FUCHSIA_GYM_4, MovementData_0x195f27
	faceplayer
	variablesprite SPRITE_FUCHSIA_GYM_4, SPRITE_YOUNGSTER
	special MapCallbackSprites_LoadUsedSpritesGFX
UnknownScript_0x195eda:
	checkevent EVENT_BEAT_CAMPER_BARRY
	iftrue_jumptextfaceplayer UnknownText_0x19626b
	faceplayer
	showtext UnknownText_0x196228
	winlosstext UnknownText_0x19624a, 0
	loadtrainer CAMPER, BARRY
	startbattle
	iftrue UnknownScript_0x195ef8
	reloadmapafterbattle
	setevent EVENT_BEAT_CAMPER_BARRY
	end

UnknownScript_0x195ef8:
	variablesprite SPRITE_FUCHSIA_GYM_4, SPRITE_JANINE
	reloadmapafterbattle
	end

FuchsiaGymGuyScript:
	checkevent EVENT_BEAT_JANINE
	iftrue_jumptextfaceplayer FuchsiaGymGuyWinText
	jumptextfaceplayer FuchsiaGymGuyText

FuchsiaGymStatue:
	trainertotext JANINE, 1, $1
	checkflag ENGINE_MARSHBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	jumpstd gymstatue2

MovementData_0x195f27:
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	step_end

UnknownText_0x195f35:
	text "Fufufufu…"

	para "I'm sorry to dis-"
	line "appoint you…"

	para "I'm only joking!"

	para "I'm the real deal!"

	para "Janine of Fuchsia"
	line "Gym, that's me!"
	done

UnknownText_0x195fa1:
	text "Janine: You're a"
	line "tough one. You"
	cont "definitely won…"

if DEF(FAITHFUL)
	para "Here's the Soul"
else
	para "Here's the Marsh"
endc
	line "Badge. Take it."
	done

UnknownText_0x195feb:
	text "<PLAYER> received"
if DEF(FAITHFUL)
	line "the Soul Badge."
else
	line "the Marsh Badge."
endc
	done

UnknownText_0x196002:
	text "Janine: You're so"
	line "tough! I have a"
	cont "special gift!"
	done

UnknownText_0x196074:
	text "Janine: I'm going"
	line "to really apply"

	para "myself and improve"
	line "my skills."

	para "I want to become"
	line "better than both"
	cont "Father and you!"
	done

UnknownText_0x1960e6:
	text "Fufufu!"

	para "I'm Janine, the"
	line "Gym Leader!"

	para "No, I'm not!"
	line "Gotcha, sucker!"
	done

UnknownText_0x196126:
	text "I had you fooled…"
	done

UnknownText_0x196139:
	text "How will you dis-"
	line "tinguish our real"
	cont "Leader?"
	done

UnknownText_0x196166:
	text "Fooled you!"
	line "Hahaha!"
	done

UnknownText_0x19617b:
	text "Ooh… I lost…"
	line "You're not weak…"
	done

UnknownText_0x196199:
	text "Well? Wasn't my"
	line "disguise perfect?"
	done

UnknownText_0x1961bb:
	text "I'm Janine!"

	para "How did you know I"
	line "was real?"

	para "Let's battle!"
	done

UnknownText_0x1961f1:
	text "Darn it!"
	line "I wanted to win!"
	done

UnknownText_0x19620c:
	text "You must be"
	line "getting tired."
	done

UnknownText_0x196228:
	text "Wahahaha!"

	para "You betcha!"
	line "I'm Janine!"
	done

UnknownText_0x19624a:
	text "My disguise was"
	line "right on! Dang!"
	done

UnknownText_0x19626b:
	text "Hey, you. Was my"
	line "disguise cute or"
	cont "what, huh?"
	done

FuchsiaGymGuyText:
	text "Yo, Champ in"
	line "making!"

	para "Whoops! Take a"
	line "good look around"

	para "you. The trainers"
	line "all look like the"
	cont "Leader, Janine."

	para "Which of them is"
	line "the real Janine?"
	done

FuchsiaGymGuyWinText:
	text "That was a great"
	line "battle, trainer"
	cont "from Johto!"
	done
