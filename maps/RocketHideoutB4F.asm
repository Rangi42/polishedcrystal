RocketHideoutB4F_MapScriptHeader:
	def_scene_scripts
	scene_script RocketHideoutB4FMeetLeadersScene
	scene_script RocketHideoutB4FMetLeadersScene

	def_callbacks
	callback MAPCALLBACK_OBJECTS, RocketHideoutB4FLiftKeyScript
	callback MAPCALLBACK_TILES, RocketHideoutB4FDoorScript

	def_warp_events
	warp_event 11, 10, ROCKET_HIDEOUT_B3F, 2
	warp_event 16, 15, ROCKET_HIDEOUT_ELEVATOR, 1
	warp_event 17, 15, ROCKET_HIDEOUT_ELEVATOR, 1

	def_coord_events
	coord_event 16, 11, 0, RocketHideoutB4FMeetLeadersLeftScript
	coord_event 17, 11, 0, RocketHideoutB4FMeetLeadersRightScript

	def_bg_events
	bg_event 17,  1, BGEVENT_ITEM + MAX_POTION, EVENT_ROCKET_HIDEOUT_B4F_HIDDEN_MAX_POTION

	def_object_events
	object_event 17,  3, SPRITE_CANDELA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, RocketHideoutB4FCandelaScript, -1
	object_event 16,  6, SPRITE_SPARK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, RocketHideoutB4FSparkScript, -1
	object_event 19,  6, SPRITE_BLANCHE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, RocketHideoutB4FBlancheScript, -1
	object_event  3,  2, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketHideoutB4FYoungsterRoryScript, -1
	object_event 15, 12, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, RocketHideoutB4FTeacherSerena, -1
	object_event 18, 12, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, RocketHideoutB4FSuperNerdTheo, -1
	keyitemball_event 2,  2, LIFT_KEY, EVENT_PICKED_UP_LIFT_KEY_FROM_ROCKET_HIDEOUT_B4F
	itemball_event 1,  4, X_SP_ATK,    1, EVENT_PICKED_UP_X_SP_ATK_FROM_ROCKET_HIDEOUT_B4F
	itemball_event 2, 12, PP_UP,        1, EVENT_PICKED_UP_PP_UP_FROM_ROCKET_HIDEOUT_B4F
	itemball_event 4, 20, DUBIOUS_DISC, 1, EVENT_PICKED_UP_DUBIOUS_DISC_FROM_ROCKET_HIDEOUT_B4F

	object_const_def
	const ROCKETHIDEOUTB4F_CANDELA
	const ROCKETHIDEOUTB4F_SPARK
	const ROCKETHIDEOUTB4F_BLANCHE
	const ROCKETHIDEOUTB4F_YOUNGSTER_RORY
	const ROCKETHIDEOUTB4F_TEACHER_SERENA
	const ROCKETHIDEOUTB4F_SUPER_NERD_THEO
	const ROCKETHIDEOUTB4F_LIFT_KEY

RocketHideoutB4FDoorScript:
	checkevent EVENT_BEAT_TEACHER_SERENA
	iftruefwd .beat_serena
	changeblock 16, 10, $69
	endcallback
.beat_serena
	checkevent EVENT_BEAT_SUPER_NERD_THEO
	iftruefwd .beat_theo
	changeblock 16, 10, $69
	endcallback
.beat_theo
	changeblock 16, 10, $13
	endcallback

RocketHideoutB4FLiftKeyScript:
	checkevent EVENT_BEAT_YOUNGSTER_RORY
	iftruefwd .beat_rory
	disappear ROCKETHIDEOUTB4F_LIFT_KEY
	endcallback
.beat_rory
	appear ROCKETHIDEOUTB4F_LIFT_KEY
	endcallback

RocketHideoutB4FMeetLeadersLeftScript:
	checktime (1 << EVE) | (1 << NITE)
	iffalse TooEarly
	applymovement PLAYER, .MovePlayerUp
	sjumpfwd RocketHideoutB4FMeetLeadersScript

.MovePlayerUp:
	step_up
	step_up
	step_up
	step_up
	step_right
	turn_head_up
	step_end

RocketHideoutB4FMeetLeadersRightScript:
	checktime (1 << EVE) | (1 << NITE)
	iffalse TooEarly
	applymovement PLAYER, .MovePlayerUp
	sjumpfwd RocketHideoutB4FMeetLeadersScript

.MovePlayerUp:
	step_up
	step_up
	step_up
	step_up
	step_end

RocketHideoutB4FMeetLeadersScript:
	showtext .CandelaIntro1Text
	turnobject ROCKETHIDEOUTB4F_SPARK, RIGHT
	showtext .BlancheIntro1Text
	turnobject ROCKETHIDEOUTB4F_BLANCHE, LEFT
	turnobject ROCKETHIDEOUTB4F_SPARK, UP
	pause 20
	turnobject ROCKETHIDEOUTB4F_SPARK, RIGHT
	showtext .SparkIntro1Text
	turnobject ROCKETHIDEOUTB4F_SPARK, UP
	turnobject ROCKETHIDEOUTB4F_BLANCHE, UP
	showtext .CandelaIntro2Text
	turnobject ROCKETHIDEOUTB4F_SPARK, RIGHT
	showtext .BlancheIntro2Text
	turnobject ROCKETHIDEOUTB4F_BLANCHE, LEFT
	turnobject ROCKETHIDEOUTB4F_SPARK, UP
	showtext .SparkIntro2Text
	turnobject ROCKETHIDEOUTB4F_SPARK, DOWN
	showtext .SparkIntro3Text
	turnobject ROCKETHIDEOUTB4F_BLANCHE, DOWN
	showtext .CandelaIntro3Text
	setscene $1
	end


.CandelaIntro1Text:
	text "Candela: I'm tell-"
	line "ing you, raw power"
	cont "wins every time!"

	para "Training should be"
	line "tough, like a"
	cont "battle!"
	done

.BlancheIntro1Text:
	text "Blanche: Strength"
	line "is pointless with-"
	cont "out strategy."

	para "Smart planning"
	line "wins, every time."
	done

.SparkIntro1Text:
	text "Spark: Both of you"
	line "are missing the"
	cont "point!"

	para "Instinct is key-"
	line "trust your gut!"
	done

.CandelaIntro2Text:
	text "Candela: Instinct?"
	line "That's just guess-"
	cont "work!"

	para "Real trainers rely"
	line "on strength!"
	done

.BlancheIntro2Text:
	text "Blanche: Candela,"
	line "Spark, this isn't"
	cont "the time!"

	para "What about the"
	line "big tree project?"
	done

.SparkIntro2Text:
	text "Spark: Right! The"
	line "big cherry tree-"
	done

.SparkIntro3Text:
	text "Wait, who's that?"
	done

.CandelaIntro3Text:
	text "Candela: Looks"
	line "like this one has"
	cont "has power!"

	para "Since you made it"
	line "this far, let's"
	cont "battle!"

	para "If you win, we'll"
	line "let you in on our"
	cont "big project!"
	done

RocketHideoutB4FMeetLeadersScene:
RocketHideoutB4FMetLeadersScene:
TooEarly:
	end


RocketHideoutB4FSparkScript:
	faceplayer
	opentext
	writetext .GreetingText
	yesorno
	iffalsefwd .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer SPARK_T, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_SPARK
	showtext .AfterText1
	verbosegiveitem MALIGN_LURE
	showtext .AfterText2
	end

.Refused:
	jumpopenedtext .RefusedText

.GreetingText:
	text "Spark: Hey! Ready"
	line "to trust your gut?"
	cont "In a battle?"
	done

.SeenText:
	text "Sweet! Let's see"
	line "how far your inst-"
	cont "inct takes you!"
	done

.BeatenText:
	text "Whoa, you totally"
	line "nailed it!"

	para "Guess your gut"
	line "was right!"
	done

.AfterText1:
	text "Spark: Here's the"
	line "Malign Lure."
	done

.AfterText2:
	text "It draws bold"
	line "energy."

	para "It's my way of"
	line "sparking some"
	cont "creativity!"

	para "Use it boldly!"
	done

.RefusedText:
	text "Aw, bummer!"
	line "Don't let fear"
	cont "hold you back!"

	para "Come back when"
	line "you're feeling it."
	done

RocketHideoutB4FCandelaScript:
	faceplayer
	opentext
	writetext .GreetingText
	yesorno
	iffalsefwd .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer CANDELA, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CANDELA
	showtext .AfterText1
	verbosegiveitem HARSH_LURE
	showtext .AfterText2
	end

.Refused:
	jumpopenedtext .RefusedText

.GreetingText:
	text "Candela: Ready to"
	line "text your strength?"
	done

.SeenText:
	text "That's the spirit!"
	line "Show me your"
	cont "power!"
	done

.BeatenText:
	text "Alright, you've"
	line "proven your"
	cont "strength today."

	para "I'll admit defeat."
	done

.AfterText1:
	text "Candela: Here's the"
	line "Harsh Lure."
	done

.AfterText2:
	text "Candela: it draws"
	line "fierce power."

	para "This is my contri-"
	line "bution to our"
	cont "project."
	
	para "Use it wisely."
	done

.RefusedText:
	text "No? Guess your"
	line "not ready yet."

	para "Come back when you"
	line "have more fire!"
	done

RocketHideoutB4FBlancheScript:
	faceplayer
	opentext
	writetext .GreetingText
	yesorno
	iffalsefwd .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer BLANCHE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BLANCHE
	showtext .AfterText1
	verbosegiveitem POTENT_LURE
	showtext .AfterText2
	end

.Refused:
	jumpopenedtext .RefusedText

.GreetingText:
	text "Blanche: Do you"
	line "value strategy?"

	para "Shall we test"
	line "your tactics?"
	done

.SeenText:
	text "Very well, let's"
	line "see your"
	cont "technique!"
	done

.BeatenText:
	text "A well-executed"
	line "plan, indeed."

	para "You've bested me."
	done

.AfterText1:
	text "Blanche: This is"
	line "the Potent Lure."
	done

.AfterText2:
	text "It amplifies"
	line "precision."

	para "It's my contri-"
	line "bution to ensuring"
	cont "our success."

	para "Use it carefully."
	done

.RefusedText:
	text "Hmm, not"
	line "feeling confident?"

	para "Return when you're"
	line "ready to think"
	cont "ahead."
	done

RocketHideoutB4FYoungsterRoryScript:
	faceplayer
	checkevent EVENT_BEAT_YOUNGSTER_RORY
	iftruefwd .AfterBattle
	opentext
	writetext .GreetingText
	closetext
	winlosstext .BeatenText, 0
	loadtrainer YOUNGSTER, RORY2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_YOUNGSTER_RORY
	readvar VAR_FACING
	ifnotequal RIGHT, .NotLeftOfRory
	moveobject ROCKETHIDEOUTB4F_LIFT_KEY, 4, 2
.NotLeftOfRory
	appear ROCKETHIDEOUTB4F_LIFT_KEY
.AfterBattle
	opentext
	writetext .AfterText
	closetext
	end

.GreetingText
	text "Team Valor is…"

	para "Wait--no!"

	para "I mean, I think"
	line "I'm lost!"
	done

.BeatenText:
	text "Which way was"
	line "the elevator?"
	done

.AfterText:
	text "Aww, I dropped"
	line "the lift key!"

	para "Candela is going"
	line "to be so mad!"
	done

RocketHideoutB4FTeacherSerena:
	trainer TEACHER, SERENA, EVENT_BEAT_TEACHER_SERENA, .SeenText, .AfterText, 0, .Script

.Script
	checkevent EVENT_BEAT_TEACHER_SERENA
	iftruefwd .AfterScript
	jumpthistextfaceplayer

.AfterScript
	checkevent EVENT_BEAT_SUPER_NERD_THEO
	iftruefwd .OpenDoorScript
	endifjustbattled
	jumptextfaceplayer .AfterText
	end

.OpenDoorScript
	changeblock 16, 10, $0d
	endifjustbattled
	jumptextfaceplayer .AfterText
	end

.AfterText
	text "The leaders are"
	line "only here at"
	cont "night."

	para "They work at"
	line "the university"
	cont "during the day."
	done

.SeenText:
	text "Let me see if you"
	line "are smart enough"
	
	para "to take on the"
	line "leaders!"
	done

.BeatenText:
	text "Class dismissed!"
	done

RocketHideoutB4FSuperNerdTheo:
	trainer SUPER_NERD, THEO2, EVENT_BEAT_SUPER_NERD_THEO, .SeenText, .AfterText, 0, .Script

.Script
	checkevent EVENT_BEAT_SUPER_NERD_THEO
	iftruefwd .AfterScript
	jumpthistextfaceplayer

.AfterScript
	checkevent EVENT_BEAT_TEACHER_SERENA
	iftruefwd .OpenDoorScript
	endifjustbattled
	jumptextfaceplayer .AfterText
	end

.OpenDoorScript
	changeblock 16, 10, $0d
	endifjustbattled
	jumptextfaceplayer .AfterText
	end

.AfterText
	text "The leaders argue"
	line "a lot, but they"
	cont "are good friends."
	done

.SeenText:
	text "You here to chal-"
	line "lenge the leaders?"

	para "You need to beat"
	line "me first!"
	done

.BeatenText:
	text "I choked!"
	done
