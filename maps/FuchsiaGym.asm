FuchsiaGym_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 17, FUCHSIA_CITY, 2
	warp_event  5, 17, FUCHSIA_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, FuchsiaGymStatue
	bg_event  6, 15, BGEVENT_READ, FuchsiaGymStatue

	def_object_events
	object_event  5,  7, SPRITE_JANINE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaGymJanineScript, -1
	object_event  1, 10, SPRITE_FUCHSIA_GYM_1, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, LassAmandaScript, -1
	object_event  5, 11, SPRITE_FUCHSIA_GYM_2, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, LassLindaScript, -1
	object_event  9,  4, SPRITE_FUCHSIA_GYM_3, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, PicnickerCindyScript, -1
	object_event  4,  2, SPRITE_FUCHSIA_GYM_4, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, CamperBarryScript, -1
	object_event  7, 15, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FuchsiaGymGuyScript, -1

	object_const_def
	const FUCHSIAGYM_JANINE
	const FUCHSIAGYM_FUCHSIA_GYM_1
	const FUCHSIAGYM_FUCHSIA_GYM_2
	const FUCHSIAGYM_FUCHSIA_GYM_3
	const FUCHSIAGYM_FUCHSIA_GYM_4

FuchsiaGymJanineScript:
	checkflag ENGINE_MARSHBADGE
	iftruefwd .FightDone
	applymovement FUCHSIAGYM_JANINE, Movement_NinjaSpin
	showtextfaceplayer JanineText_DisappointYou
	winlosstext JanineText_ToughOne, 0
	loadtrainer JANINE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_JANINE
	setevent EVENT_BEAT_LASS_AMANDA
	setevent EVENT_BEAT_LASS_LINDA
	setevent EVENT_BEAT_PICNICKER_CINDY
	setevent EVENT_BEAT_CAMPER_BARRY
	variablesprite SPRITE_FUCHSIA_GYM_1, SPRITE_CUTE_GIRL
	variablesprite SPRITE_FUCHSIA_GYM_2, SPRITE_CUTE_GIRL
	variablesprite SPRITE_FUCHSIA_GYM_3, SPRITE_CUTE_GIRL
	variablesprite SPRITE_FUCHSIA_GYM_4, SPRITE_SCHOOLBOY
	special RefreshSprites
	opentext
	givebadge MARSHBADGE, KANTO_REGION
	callstd kantopostgymevents
	sjumpfwd .AfterBattle
.FightDone:
	faceplayer
	opentext
.AfterBattle:
	checkevent EVENT_GOT_TM66_POISON_JAB
	iftrue_jumpopenedtext JanineText_ApplyMyself
	writetext JanineText_ToxicSpeech
	promptbutton
	verbosegivetmhm TM_POISON_JAB
	setevent EVENT_GOT_TM66_POISON_JAB
	jumpthisopenedtext

	text "It's Poison Jab,"
	line "a powerful Poison-"

	para "type move that"
	line "may poison its"
	cont "victim."
	done

LassAmandaScript:
	checkevent EVENT_BEAT_LASS_AMANDA
	iftruefwd .AmandaUnmasked
	applymovement FUCHSIAGYM_FUCHSIA_GYM_1, Movement_NinjaSpin
	faceplayer
	variablesprite SPRITE_FUCHSIA_GYM_1, SPRITE_LASS
	special RefreshSprites
.AmandaUnmasked:
	checkevent EVENT_BEAT_LASS_AMANDA
	iftrue_jumptextfaceplayer LassAmandaAfterText
	faceplayer
	showtext LassAmandaBeforeText
	winlosstext LassAmandaBeatenText, 0
	loadtrainer LASS, AMANDA
	startbattle
	iftruefwd .AmandaBecomesJanine
	reloadmapafterbattle
	setevent EVENT_BEAT_LASS_AMANDA
	end

.AmandaBecomesJanine:
	variablesprite SPRITE_FUCHSIA_GYM_1, SPRITE_JANINE
	reloadmapafterbattle
	end

LassLindaScript:
	checkevent EVENT_BEAT_LASS_LINDA
	iftruefwd .LindaUnmasked
	applymovement FUCHSIAGYM_FUCHSIA_GYM_2, Movement_NinjaSpin
	faceplayer
	variablesprite SPRITE_FUCHSIA_GYM_2, SPRITE_LASS
	special RefreshSprites
.LindaUnmasked:
	checkevent EVENT_BEAT_LASS_LINDA
	iftrue_jumptextfaceplayer LassLindaAfterText
	faceplayer
	showtext LassLindaBeforeText
	winlosstext LassLindaBeatenText, 0
	loadtrainer LASS, LINDA
	startbattle
	iftruefwd .LindaBecomesJanine
	reloadmapafterbattle
	setevent EVENT_BEAT_LASS_LINDA
	end

.LindaBecomesJanine:
	variablesprite SPRITE_FUCHSIA_GYM_2, SPRITE_JANINE
	reloadmapafterbattle
	end

PicnickerCindyScript:
	checkevent EVENT_BEAT_PICNICKER_CINDY
	iftruefwd .CindyUnmasked
	applymovement FUCHSIAGYM_FUCHSIA_GYM_3, Movement_NinjaSpin
	faceplayer
	variablesprite SPRITE_FUCHSIA_GYM_3, SPRITE_PICNICKER
	special RefreshSprites
.CindyUnmasked:
	checkevent EVENT_BEAT_PICNICKER_CINDY
	iftrue_jumptextfaceplayer PicnickerCindyAfterText
	faceplayer
	showtext PicnickerCindyBeforeText
	winlosstext PicnickerCindyBeatenText, 0
	loadtrainer PICNICKER, CINDY
	startbattle
	iftruefwd .CindyBecomesJanine
	reloadmapafterbattle
	setevent EVENT_BEAT_PICNICKER_CINDY
	end

.CindyBecomesJanine:
	variablesprite SPRITE_FUCHSIA_GYM_3, SPRITE_JANINE
	reloadmapafterbattle
	end

CamperBarryScript:
	checkevent EVENT_BEAT_CAMPER_BARRY
	iftruefwd .BarryUnmasked
	applymovement FUCHSIAGYM_FUCHSIA_GYM_4, Movement_NinjaSpin
	faceplayer
	variablesprite SPRITE_FUCHSIA_GYM_4, SPRITE_SCHOOLBOY
	special RefreshSprites
.BarryUnmasked:
	checkevent EVENT_BEAT_CAMPER_BARRY
	iftrue_jumptextfaceplayer CamperBarryAfterText
	faceplayer
	showtext CamperBarryBeforeText
	winlosstext CamperBarryBeatenText, 0
	loadtrainer CAMPER, BARRY
	startbattle
	iftruefwd .BarryBecomesJanine
	reloadmapafterbattle
	setevent EVENT_BEAT_CAMPER_BARRY
	end

.BarryBecomesJanine:
	variablesprite SPRITE_FUCHSIA_GYM_4, SPRITE_JANINE
	reloadmapafterbattle
	end

FuchsiaGymGuyScript:
	checkevent EVENT_BEAT_JANINE
	iftrue_jumptextfaceplayer FuchsiaGymGuyWinText
	jumptextfaceplayer FuchsiaGymGuyText

FuchsiaGymStatue:
	gettrainername JANINE, 1, STRING_BUFFER_4
	checkflag ENGINE_MARSHBADGE
	iftruefwd .Beaten
	jumpstd gymstatue1
.Beaten:
	jumpstd gymstatue2

Movement_NinjaSpin:
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

JanineText_DisappointYou:
	text "Fufufufu…"

	para "I'm sorry to dis-"
	line "appoint you…"

	para "I'm only joking!"

	para "I'm the real deal!"

	para "Janine of Fuchsia"
	line "Gym, that's me!"
	done

JanineText_ToughOne:
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

JanineText_ToxicSpeech:
	text "Janine: You're so"
	line "tough! I have a"
	cont "special gift!"
	done

JanineText_ApplyMyself:
	text "Janine: I'm going"
	line "to really apply"

	para "myself and improve"
	line "my skills."

	para "I want to become"
	line "better than both"
	cont "Father and you!"
	done

LassAmandaBeforeText:
	text "Fufufu!"

	para "I'm Janine, the"
	line "Gym Leader!"

	para "No, I'm not!"
	line "Gotcha, sucker!"
	done

LassAmandaBeatenText:
	text "I had you fooled…"
	done

LassAmandaAfterText:
	text "How will you dis-"
	line "tinguish our real"
	cont "Leader?"
	done

LassLindaBeforeText:
	text "Fooled you!"
	line "Hahaha!"
	done

LassLindaBeatenText:
	text "Ooh… I lost…"
	line "You're not weak…"
	done

LassLindaAfterText:
	text "Well? Wasn't my"
	line "disguise perfect?"
	done

PicnickerCindyBeforeText:
	text "I'm Janine!"

	para "How did you know I"
	line "was real?"

	para "Let's battle!"
	done

PicnickerCindyBeatenText:
	text "Darn it!"
	line "I wanted to win!"
	done

PicnickerCindyAfterText:
	text "You must be"
	line "getting tired."
	done

CamperBarryBeforeText:
	text "Wahahaha!"

	para "You betcha!"
	line "I'm Janine!"
	done

CamperBarryBeatenText:
	text "My disguise was"
	line "right on! Dang!"
	done

CamperBarryAfterText:
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
