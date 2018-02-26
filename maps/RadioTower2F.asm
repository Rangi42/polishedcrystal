RadioTower2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  0,  0, RADIO_TOWER_3F, 1
	warp_event 15,  0, RADIO_TOWER_1F, 3

	db 0 ; coord events

	db 3 ; bg events
	bg_event  3,  0, SIGNPOST_JUMPTEXT, UnknownText_0x5e426
	bg_event  5,  0, SIGNPOST_JUMPTEXT, UnknownText_0x5e430
	bg_event 13,  0, SIGNPOST_JUMPTEXT, UnknownText_0x5e463

	db 12 ; object events
	object_event 14,  5, SPRITE_BUENA, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, Buena, -1
	object_event  6,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5d924, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 17,  2, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, TeacherScript_0x5d701, -1
	object_event  1,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerGruntM4, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  7,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerGruntM5, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  4,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerGruntM6, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 10,  5, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerGruntF2, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  0,  1, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5d9cb, EVENT_RADIO_TOWER_BLACKBELT_BLOCKS_STAIRS
	object_event  1,  1, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5da44, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	object_event 12,  1, SPRITE_JIGGLYPUFF, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_POKEMON, JIGGLYPUFF, RadioTowerJigglypuffText, -1
	object_event 12,  7, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, ReceptionistScript_0x5d8ff, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event  3,  6, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, RadioTower2FRockerText, EVENT_GOLDENROD_CITY_CIVILIANS

	const_def 1 ; object constants
	const RADIOTOWER2F_BUENA

TeacherScript_0x5d701:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue_jumptextfaceplayer UnknownText_0x5d983
	thistextfaceplayer

	text "Lullabies on the"
	line "radio may make"
	cont "#mon sleep."
	done

GenericTrainerGruntM4:
	generictrainer GRUNTM, 4, EVENT_BEAT_ROCKET_GRUNTM_4, GruntM4SeenText, GruntM4BeatenText

	text "We won't let you"
	line "ruin our plans"
	cont "for our comeback!"
	done

GenericTrainerGruntM5:
	generictrainer GRUNTM, 5, EVENT_BEAT_ROCKET_GRUNTM_5, GruntM5SeenText, GruntM5BeatenText

	text "We're not always"
	line "evil. We just do"
	cont "whatever we like."
	done

GenericTrainerGruntM6:
	generictrainer GRUNTM, 6, EVENT_BEAT_ROCKET_GRUNTM_6, GruntM6SeenText, GruntM6BeatenText

	text "Our Executives are"
	line "trying to take"
	cont "this place over."

	para "They have some big"
	line "plan. I wonder"
	cont "what that is?"
	done

GenericTrainerGruntF2:
	generictrainer GRUNTF, 2, EVENT_BEAT_ROCKET_GRUNTF_2, GruntF2SeenText, GruntF2BeatenText

	text "You beat me, and"
	line "I won't forget it!"
	done

Buena:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue_jumptextfaceplayer UnknownText_0x5e0c2
	faceplayer
	opentext
	checkevent EVENT_MET_BUENA
	iffalse UnknownScript_0x5d800
	checkflag ENGINE_BUENAS_PASSWORD_2
	iftrue UnknownScript_0x5d82f
	checkcode VAR_HOUR
	ifless 18, UnknownScript_0x5d893
	checkflag ENGINE_BUENAS_PASSWORD
	iffalse UnknownScript_0x5d80a
	checkitem BLUE_CARD
	iffalse UnknownScript_0x5d86b
	checkcode VAR_BLUECARDBALANCE
	ifequal 30, UnknownScript_0x5d87f
	playmusic MUSIC_BUENAS_PASSWORD
	writetext UnknownText_0x5de35
	special AskRememberPassword
	iffalse UnknownScript_0x5d81e
	writetext UnknownText_0x5de84
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	checkcode VAR_FACING
	ifnotequal RIGHT, UnknownScript_0x5d7be
	applymovement PLAYER, MovementData_0x5d921
UnknownScript_0x5d7be:
	turnobject PLAYER, RIGHT
	showtext UnknownText_0x5dedd
	turnobject RADIOTOWER2F_BUENA, DOWN
	refreshscreen
	special SpecialBuenasPassword
	closetext
	iffalse UnknownScript_0x5d845
	showtext UnknownText_0x5dfc1
	checkcode VAR_BLUECARDBALANCE
	addvar $1
	writevarcode VAR_BLUECARDBALANCE
	waitsfx
	playsound SFX_TRANSACTION
	setflag ENGINE_BUENAS_PASSWORD_2
	pause 20
	turnobject RADIOTOWER2F_BUENA, RIGHT
	showtext UnknownText_0x5e054
	special Special_FadeOutMusic
	pause 20
	special RestartMapMusic
	checkcode VAR_BLUECARDBALANCE
	ifequal $1e, UnknownScript_0x5d8a4
	end

UnknownScript_0x5d800:
	writetext UnknownText_0x5dcf4
	buttonsound
	setevent EVENT_MET_BUENA
	verbosegiveitem BLUE_CARD
UnknownScript_0x5d80a:
	writetext UnknownText_0x5de10
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue UnknownScript_0x5d81a
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER
	iftrue UnknownScript_0x5d8cc
UnknownScript_0x5d81a:
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

UnknownScript_0x5d81e:
	writetext UnknownText_0x5df29
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	special Special_FadeOutMusic
	pause 20
	special RestartMapMusic
	end

UnknownScript_0x5d82f:
	writetext UnknownText_0x5df6c
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue UnknownScript_0x5d83f
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER
	iftrue UnknownScript_0x5d8cc
UnknownScript_0x5d83f:
	turnobject RADIOTOWER2F_BUENA, RIGHT
	pause 10
	end

UnknownScript_0x5d845:
	setflag ENGINE_BUENAS_PASSWORD_2
	showtext UnknownText_0x5e01c
	turnobject RADIOTOWER2F_BUENA, RIGHT
	pause 20
	showtext UnknownText_0x5e054
	turnobject RADIOTOWER2F_BUENA, RIGHT
	special Special_FadeOutMusic
	pause 20
	special RestartMapMusic
	end

UnknownScript_0x5d86b:
	writetext UnknownText_0x5e192
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue UnknownScript_0x5d87b
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER_NO_BLUE_CARD
	iftrue UnknownScript_0x5d8cc
UnknownScript_0x5d87b:
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

UnknownScript_0x5d87f:
	writetext UnknownText_0x5e0f1
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue UnknownScript_0x5d88f
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER_NO_BLUE_CARD
	iftrue UnknownScript_0x5d8cc
UnknownScript_0x5d88f:
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

UnknownScript_0x5d893:
	writetext UnknownText_0x5e131
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue UnknownScript_0x5d8a3
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER
	iftrue UnknownScript_0x5d8cc
UnknownScript_0x5d8a3:
	end

UnknownScript_0x5d8a4:
	checkcellnum PHONE_BUENA
	iftrue UnknownScript_0x5d8fe
	pause 20
	turnobject RADIOTOWER2F_BUENA, DOWN
	pause 15
	turnobject PLAYER, UP
	pause 15
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER_NO_BLUE_CARD
	iftrue UnknownScript_0x5d8cc
	showemote EMOTE_SHOCK, RADIOTOWER2F_BUENA, 15
	setevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER_NO_BLUE_CARD
	setevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER
	opentext
	writetext UnknownText_0x5e1ee
	jump UnknownScript_0x5d8d0

UnknownScript_0x5d8cc:
	opentext
	writetext UnknownText_0x5e2bf
UnknownScript_0x5d8d0:
	askforphonenumber PHONE_BUENA
	ifequal $1, UnknownScript_0x5d8f6
	ifequal $2, UnknownScript_0x5d8ed
	writetext UnknownText_0x5e2f3
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	buttonsound
	writetext UnknownText_0x5e310
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	addcellnum PHONE_BUENA
	end

UnknownScript_0x5d8ed:
	writetext UnknownText_0x5e33c
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

UnknownScript_0x5d8f6:
	writetext UnknownText_0x5e35e
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
UnknownScript_0x5d8fe:
	end

ReceptionistScript_0x5d8ff:
	checkitem BLUE_CARD
	iffalse_jumptextfaceplayer UnknownText_0x5e3d8
	pokemart MARTTYPE_BLUECARD, 0

MovementData_0x5d921:
	slow_step_down
	slow_step_right
	step_end

UnknownText_0x5d924:
	text "You can listen to"
	line "the radio any-"
	cont "where. Tune in!"
	done

RadioTower2FRockerText:
	text "I have a radio"
	line "interview to pro-"

	para "mote my latest"
	line "song."

	para "I've performed in"
	line "front of big"
	cont "crowds before,"

	para "but boy am I"
	line "nervous."
	done

UnknownText_0x5d983:
	text "Why would they"
	line "want to take over"
	cont "the Radio Tower?"
	done

RadioTowerJigglypuffText:
	text "Jigglypuff:"
	line "Jiggly…"
	done

UnknownText_0x5d9cb:
	text "Sorry. Authorized"
	line "personnel only"
	cont "beyond this point."

	para "It wasn't that way"
	line "before."

	para "There's something"
	line "wrong with the"
	cont "Director…"
	done

UnknownText_0x5da44:
	text "Feel free to look"
	line "around anywhere."

	para "The Director is"
	line "nice again, just"
	cont "as he was before."
	done

GruntM4SeenText:
	text "Three years ago,"
	line "Team Rocket was"
	cont "forced to disband."

	para "But we're making a"
	line "comeback here!"
	done

GruntM4BeatenText:
	text "Gwah! Don't get"
	line "cute!"
	done

GruntM5SeenText:
	text "We're Team Rocket,"
	line "the exploiters of"
	cont "#mon!"

	para "We love being"
	line "evil! Scared?"
	done

GruntM5BeatenText:
	text "You think you're a"
	line "hero?"
	done

GruntM6SeenText:
	text "Hey, hey! Keep out"
	line "of our way!"
	done

GruntM6BeatenText:
	text "Arggh. I give up."
	done

GruntF2SeenText:
	text "Hahaha!"

	para "How boring."
	line "It was far too"

	para "easy to take over"
	line "this place!"

	para "Come on, keep me"
	line "amused!"
	done

GruntF2BeatenText:
	text "Wh-who are you?"
	done

UnknownText_0x5dcf4:
	text "Buena: Hi! I'm"
	line "Buena!"

	para "Do you know about"
	line "a radio program"
	cont "called Password?"

	para "If you can tell me"
	line "the password from"

	para "the program, you"
	line "will earn points."

	para "Save up those"
	line "points and trade"

	para "them to that sweet"
	line "young lady over"

	para "there for some"
	line "choice prizes!"

	para "Here you go!"

	para "It's your very own"
	line "point card!"
	done

UnknownText_0x5de10:
	text "Buena: Tune in to"
	line "my Password Show!"
	done

UnknownText_0x5de35:
	text "Buena: Hi!"
	line "Did you tune in to"
	cont "my radio show?"

	para "Do you remember"
	line "today's password?"
	done

UnknownText_0x5de84:
	text "Buena: Oh, wow!"
	line "Thank you!"

	para "What was your name"
	line "again?"

	para "…<PLAYER>, OK!"

	para "Come on, <PLAYER>."
	line "Join the show."
	done

UnknownText_0x5dedd:
	text "Buena: Everyone"
	line "ready?"

	para "I want to hear you"
	line "shout out today's"

	para "password for"
	line "<PLAYER>!"
	done

UnknownText_0x5df29:
	text "Buena: Come back"
	line "after you listen"

	para "to my show, OK?"
	line "Catch ya later!"
	done

UnknownText_0x5df6c:
	text "Buena: Sorry…"

	para "You get just one"
	line "chance each day."

	para "Come back tomorrow"
	line "for another try!"
	done

UnknownText_0x5dfc1:
	text "Buena: YIPPEE!"
	line "That's right!"

	para "You did tune in!"
	line "I'm so happy!"

	para "You earned one"
	line "point! Congrats!"
	done

UnknownText_0x5e01c:
	text "Buena: Aww…"
	line "That's not it…"

	para "Did you forget the"
	line "password?"
	done

UnknownText_0x5e054:
	text "Buena: Yup! Our"
	line "contestant was"

	para "<PLAYER>."
	line "Thanks for coming!"

	para "I hope all you"
	line "listeners will"

	para "come too!"
	line "I'll be waiting!"
	done

UnknownText_0x5e0c2:
	text "Buena: Huh?"
	line "Today's password?"

	para "HELP, of course!"
	done

UnknownText_0x5e0f1:
	text "Buena: Your Blue"
	line "Card's full."

	para "Trade it in for a"
	line "fabulous prize!"
	done

UnknownText_0x5e131:
	text "Buena: Tune in to"
	line "Password every"

	para "night from six to"
	line "midnight!"

	para "Tune in, then drop"
	line "in for a visit!"
	done

UnknownText_0x5e192:
	text "Buena: Oh? You"
	line "forgot to bring"
	cont "your Blue Card?"

	para "I can't give you"
	line "points if you"
	cont "don't have it."
	done

UnknownText_0x5e1ee:
	text "Buena: Oh! Your"
	line "Blue Card reached"

	para "30 points today!"
	line "That's so wild!"

	para "Hmm… There isn't a"
	line "prize for hitting"
	cont "30 points, but…"

	para "You came by so"
	line "often, <PLAYER>."

	para "I'll make you a"
	line "special deal!"

	para "How would you like"
	line "my phone number?"
	done

UnknownText_0x5e2bf:
	text "Buena: <PLAYER>,"
	line "do you want to"

	para "register my phone"
	line "number?"
	done

UnknownText_0x5e2f3:
	text "<PLAYER> registered"
	line "Buena's number."
	done

UnknownText_0x5e310:
	text "Buena: I look"
	line "forward to hearing"
	cont "from you!"
	done

UnknownText_0x5e33c:
	text "Buena: Aww… It's a"
	line "special prize…"
	done

UnknownText_0x5e35e:
	text "Buena: <PLAYER>,"
	line "your phone list"

	para "has no room left"
	line "for me…"
	done

UnknownText_0x5e3d8:
	text "You can't trade in"
	line "points without"
	cont "your Blue Card."

	para "Don't forget your"
	line "Blue Card!"
	done

UnknownText_0x5e426:
	text "2F Sales"
	done

UnknownText_0x5e430:
	text "Prof.Oak's #mon"
	line "Talk"

	para "The Hottest Show"
	line "on the Air!"
	done

UnknownText_0x5e463:
	text "Anywhere, Anytime"
	line "#mon Radio"
	done
