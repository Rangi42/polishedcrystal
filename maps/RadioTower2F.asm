RadioTower2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  0, RADIO_TOWER_3F, 1
	warp_event 15,  0, RADIO_TOWER_1F, 3

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_JUMPTEXT, RadioTower2FSalesSignText
	bg_event  5,  0, BGEVENT_JUMPTEXT, RadioTower2FOaksPKMNTalkSignText
	bg_event 13,  0, BGEVENT_JUMPTEXT, RadioTower2FPokemonRadioSignText

	def_object_events
	object_event 14,  5, SPRITE_BUENA, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Buena, -1
	object_event  6,  6, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower2FSuperNerdText, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 17,  2, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower2FTeacherScript, -1
	object_event  1,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM4, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  7,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM5, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  4,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerGruntM6, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 10,  5, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntF2, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  0,  1, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower2FBlackBelt1Text, EVENT_RADIO_TOWER_BLACKBELT_BLOCKS_STAIRS
	object_event  1,  1, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower2FBlackBelt2Text, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	pokemon_event 12,  1, JIGGLYPUFF, -1, -1, PAL_NPC_RED, RadioTowerJigglypuffText, -1
	object_event 12,  7, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTowerBuenaPrizeReceptionist, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event  3,  6, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower2FRockerText, EVENT_GOLDENROD_CITY_CIVILIANS

	object_const_def
	const RADIOTOWER2F_BUENA

RadioTower2FTeacherScript:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue_jumptextfaceplayer RadioTower2FTeacherText_Rockets
	jumpthistextfaceplayer

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
	iftrue_jumptextfaceplayer RadioTower2FBuenaPasswordIsHelpText
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
	checkkeyitem BLUE_CARD
	iffalse UnknownScript_0x5d86b
	checkcode VAR_BLUECARDBALANCE
	ifequal 30, UnknownScript_0x5d87f
	playmusic MUSIC_BUENAS_PASSWORD
	writetext RadioTower2FBuenaDoYouKnowPasswordText
	special AskRememberPassword
	iffalse UnknownScript_0x5d81e
	writetext RadioTower2FBuenaJoinTheShowText
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	checkcode VAR_FACING
	ifnotequal RIGHT, UnknownScript_0x5d7be
	applymovement PLAYER, RadioTower2FPlayerWalksToMicrophoneMovement
UnknownScript_0x5d7be:
	turnobject PLAYER, RIGHT
	showtext RadioTower2FBuenaEveryoneSayPasswordText
	turnobject RADIOTOWER2F_BUENA, DOWN
	refreshscreen
	special SpecialBuenasPassword
	closetext
	iffalse UnknownScript_0x5d845
	showtext RadioTower2FBuenaCorrectAnswerText
	checkcode VAR_BLUECARDBALANCE
	addvar $1
	writevarcode VAR_BLUECARDBALANCE
	waitsfx
	playsound SFX_TRANSACTION
	setflag ENGINE_BUENAS_PASSWORD_2
	pause 20
	turnobject RADIOTOWER2F_BUENA, RIGHT
	showtext RadioTower2FBuenaThanksForComingText
	special Special_FadeOutMusic
	pause 20
	special RestartMapMusic
	checkcode VAR_BLUECARDBALANCE
	ifequal $1e, UnknownScript_0x5d8a4
	end

UnknownScript_0x5d800:
	writetext RadioTower2FBuenaShowIntroductionText
	buttonsound
	setevent EVENT_MET_BUENA
	verbosegivekeyitem BLUE_CARD
UnknownScript_0x5d80a:
	writetext RadioTower2FBuenaTuneInToMyShowText
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
	writetext RadioTower2FBuenaComeBackAfterListeningText
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	special Special_FadeOutMusic
	pause 20
	special RestartMapMusic
	end

UnknownScript_0x5d82f:
	writetext RadioTower2FBuenaAlreadyPlayedText
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
	showtext RadioTower2FBuenaDidYouForgetText
	turnobject RADIOTOWER2F_BUENA, RIGHT
	pause 20
	showtext RadioTower2FBuenaThanksForComingText
	turnobject RADIOTOWER2F_BUENA, RIGHT
	special Special_FadeOutMusic
	pause 20
	special RestartMapMusic
	end

UnknownScript_0x5d86b:
	writetext RadioTower2FBuenaNoBlueCardText
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
	writetext RadioTower2FBuenaCardIsFullText
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
	writetext RadioTower2FBuenaTuneInAfterSixText
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
	writetext RadioTower2FBuenaOfferPhoneNumberText
	jump UnknownScript_0x5d8d0

UnknownScript_0x5d8cc:
	opentext
	writetext RadioTower2FBuenaOfferNumberAgainText
UnknownScript_0x5d8d0:
	askforphonenumber PHONE_BUENA
	ifequal $1, UnknownScript_0x5d8f6
	ifequal $2, UnknownScript_0x5d8ed
	writetext RadioTower2FRegisteredBuenasNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	buttonsound
	writetext RadioTower2FBuenaCallMeText
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	addcellnum PHONE_BUENA
	end

UnknownScript_0x5d8ed:
	writetext RadioTower2FBuenaSadRejectedText
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

UnknownScript_0x5d8f6:
	writetext RadioTower2FBuenaYourPhoneIsFullText
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
UnknownScript_0x5d8fe:
	end

RadioTowerBuenaPrizeReceptionist:
	checkkeyitem BLUE_CARD
	iffalse_jumptextfaceplayer RadioTower2FBuenaReceptionistNoCardText
	pokemart MARTTYPE_BLUECARD, 0

RadioTower2FPlayerWalksToMicrophoneMovement:
	slow_step_down
	slow_step_right
	step_end

RadioTower2FSuperNerdText:
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

RadioTower2FTeacherText_Rockets:
	text "Why would they"
	line "want to take over"
	cont "the Radio Tower?"
	done

RadioTowerJigglypuffText:
	text "Jigglypuff:"
	line "Jiggly…"
	done

RadioTower2FBlackBelt1Text:
	text "Sorry. Authorized"
	line "personnel only"
	cont "beyond this point."

	para "It wasn't that way"
	line "before."

	para "There's something"
	line "wrong with the"
	cont "Director…"
	done

RadioTower2FBlackBelt2Text:
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

RadioTower2FBuenaShowIntroductionText:
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

RadioTower2FBuenaTuneInToMyShowText:
	text "Buena: Tune in to"
	line "my Password Show!"
	done

RadioTower2FBuenaDoYouKnowPasswordText:
	text "Buena: Hi!"
	line "Did you tune in to"
	cont "my radio show?"

	para "Do you remember"
	line "today's password?"
	done

RadioTower2FBuenaJoinTheShowText:
	text "Buena: Oh, wow!"
	line "Thank you!"

	para "What was your name"
	line "again?"

	para "…<PLAYER>, OK!"

	para "Come on, <PLAYER>."
	line "Join the show."
	done

RadioTower2FBuenaEveryoneSayPasswordText:
	text "Buena: Everyone"
	line "ready?"

	para "I want to hear you"
	line "shout out today's"

	para "password for"
	line "<PLAYER>!"
	done

RadioTower2FBuenaComeBackAfterListeningText:
	text "Buena: Come back"
	line "after you listen"

	para "to my show, OK?"
	line "Catch ya later!"
	done

RadioTower2FBuenaAlreadyPlayedText:
	text "Buena: Sorry…"

	para "You get just one"
	line "chance each day."

	para "Come back tomorrow"
	line "for another try!"
	done

RadioTower2FBuenaCorrectAnswerText:
	text "Buena: YIPPEE!"
	line "That's right!"

	para "You did tune in!"
	line "I'm so happy!"

	para "You earned one"
	line "point! Congrats!"
	done

RadioTower2FBuenaDidYouForgetText:
	text "Buena: Aww…"
	line "That's not it…"

	para "Did you forget the"
	line "password?"
	done

RadioTower2FBuenaThanksForComingText:
	text "Buena: Yup! Our"
	line "contestant was"

	para "<PLAYER>."
	line "Thanks for coming!"

	para "I hope all you"
	line "listeners will"

	para "come too!"
	line "I'll be waiting!"
	done

RadioTower2FBuenaPasswordIsHelpText:
	text "Buena: Huh?"
	line "Today's password?"

	para "HELP, of course!"
	done

RadioTower2FBuenaCardIsFullText:
	text "Buena: Your Blue"
	line "Card's full."

	para "Trade it in for a"
	line "fabulous prize!"
	done

RadioTower2FBuenaTuneInAfterSixText:
	text "Buena: Tune in to"
	line "Password every"

	assert EVE_HOUR == 12 + 5
	para "night from five"
	line "to midnight!"

	para "Tune in, then drop"
	line "in for a visit!"
	done

RadioTower2FBuenaNoBlueCardText:
	text "Buena: Oh? You"
	line "forgot to bring"
	cont "your Blue Card?"

	para "I can't give you"
	line "points if you"
	cont "don't have it."
	done

RadioTower2FBuenaOfferPhoneNumberText:
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

RadioTower2FBuenaOfferNumberAgainText:
	text "Buena: <PLAYER>,"
	line "do you want to"

	para "register my phone"
	line "number?"
	done

RadioTower2FRegisteredBuenasNumberText:
	text "<PLAYER> registered"
	line "Buena's number."
	done

RadioTower2FBuenaCallMeText:
	text "Buena: I look"
	line "forward to hearing"
	cont "from you!"
	done

RadioTower2FBuenaSadRejectedText:
	text "Buena: Aww… It's a"
	line "special prize…"
	done

RadioTower2FBuenaYourPhoneIsFullText:
	text "Buena: <PLAYER>,"
	line "your phone list"

	para "has no room left"
	line "for me…"
	done

RadioTower2FBuenaReceptionistNoCardText:
	text "You can't trade in"
	line "points without"
	cont "your Blue Card."

	para "Don't forget your"
	line "Blue Card!"
	done

RadioTower2FSalesSignText:
	text "2F Sales"
	done

RadioTower2FOaksPKMNTalkSignText:
	text "Prof.Oak's #mon"
	line "Talk"

	para "The Hottest Show"
	line "on the Air!"
	done

RadioTower2FPokemonRadioSignText:
	text "Anywhere, Anytime"
	line "#mon Radio"
	done
