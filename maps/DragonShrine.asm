DragonShrine_MapScriptHeader:
	def_scene_scripts
	scene_script DragonShrineTrigger0

	def_callbacks

	def_warp_events
	warp_event  4,  9, DRAGONS_DEN_B1F, 2
	warp_event  5,  9, DRAGONS_DEN_B1F, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, DragonShrineElder1Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  4,  8, SPRITE_CLAIR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_DRAGON_SHRINE_CLAIR
	object_event  2,  4, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, DragonShrineElder2Text, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  7,  4, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, DragonShrineElder3Text, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

	object_const_def
	const DRAGONSHRINE_ELDER1
	const DRAGONSHRINE_CLAIR

DragonShrineTrigger0:
	priorityjump DragonShrineTestScript
	end

DragonShrineTestScript:
	applymovement PLAYER, DragonShrinePlayerWalkInMovement
	applyonemovement DRAGONSHRINE_ELDER1, slow_step_down
	opentext
	writetext DragonShrineElderGreetingText
	buttonsound
.Question1:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	writetext DragonShrineQuestion1Text
	buttonsound
	loadmenu DragonShrineQuestion1_MenuHeader
	verticalmenu
	closewindow
	ifequal $1, .RightAnswer
	ifequal $2, .WrongAnswer
	ifequal $3, .RightAnswer
	end

.Question2:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	writetext DragonShrineQuestion2Text
	buttonsound
	loadmenu DragonShrineQuestion2_MenuHeader
	verticalmenu
	closewindow
	ifequal $1, .RightAnswer
	ifequal $2, .RightAnswer
	ifequal $3, .WrongAnswer
.Question3:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	writetext DragonShrineQuestion3Text
	buttonsound
	loadmenu DragonShrineQuestion3_MenuHeader
	verticalmenu
	closewindow
	ifequal $1, .WrongAnswer
	ifequal $2, .RightAnswer
	ifequal $3, .RightAnswer
.Question4:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	writetext DragonShrineQuestion4Text
	buttonsound
	loadmenu DragonShrineQuestion4_MenuHeader
	verticalmenu
	closewindow
	ifequal $1, .RightAnswer
	ifequal $2, .WrongAnswer
	ifequal $3, .RightAnswer
.Question5:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	writetext DragonShrineQuestion5Text
	buttonsound
	loadmenu DragonShrineQuestion5_MenuHeader
	verticalmenu
	closewindow
	ifequal $1, .WrongAnswer
	ifequal $2, .WrongAnswer
	ifequal $3, .RightAnswer
.RightAnswer:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	iftrue .PassedTheTest
	writetext DragonShrineRightAnswerText
	buttonsound
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	iftrue .Question5
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	iftrue .Question4
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue .Question3
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .Question2
.WrongAnswer:
	closetext
	turnobject DRAGONSHRINE_ELDER1, LEFT
	showtext DragonShrineWrongAnswerText1
	turnobject DRAGONSHRINE_ELDER1, DOWN
	showtext DragonShrineWrongAnswerText2
	setevent EVENT_ANSWERED_DRAGON_MASTER_QUIZ_WRONG
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	iftrue .Question5
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	iftrue .Question4
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	iftrue .Question3
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue .Question2
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .Question1
.PassedTheTest:
	writetext DragonShrinePassedTestText
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_CLAIR
	appear DRAGONSHRINE_CLAIR
	waitsfx
	turnobject PLAYER, DOWN
	pause 30
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairWalkInMovement
	turnobject DRAGONSHRINE_CLAIR, RIGHT
	turnobject PLAYER, LEFT
	turnobject DRAGONSHRINE_ELDER1, LEFT
	showtext DragonShrineClairYouPassedText
	special Special_FadeOutMusic
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairBigStepLeftMovement
	showtext DragonShrineClairThatCantBeText
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairSlowStepLeftMovement
	showtext DragonShrineClairYoureLyingText
	applymovement DRAGONSHRINE_ELDER1, DragonShrineElderWalkToClairMovement
	turnobject DRAGONSHRINE_CLAIR, UP
	showtext DragonShrineMustIInformLanceText
	showemote EMOTE_SHOCK, DRAGONSHRINE_CLAIR, 15
	showtext DragonShrineIUnderstandText
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairTwoSlowStepsRightMovement
	opentext
	writetext DragonShrineHereRisingBadgeText
	waitbutton
	setflag ENGINE_RISINGBADGE
	playsound SFX_GET_BADGE
	waitsfx
	special RestartMapMusic
	specialphonecall SPECIALCALL_MASTERBALL
	setscene $1
	setmapscene DRAGONS_DEN_B1F, $1
	writetext DragonShrinePlayerReceivedRisingBadgeText
	buttonsound
	writetext DragonShrineRisingBadgeExplanationText
	waitbutton
	closetext
	applymovement DRAGONSHRINE_ELDER1, DragonShrineElderWalkAway1Movement
	turnobject DRAGONSHRINE_CLAIR, UP
	applymovement DRAGONSHRINE_ELDER1, DragonShrineElderWalkAway2Movement
	turnobject PLAYER, UP
	showtext DragonShrineElderScoldsClairText
	showtext DragonShrineSpeechlessText
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairWalkOutMovement
	playsound SFX_ENTER_DOOR
	disappear DRAGONSHRINE_CLAIR
	waitsfx
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	end

DragonShrineElder1Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue_jumptextfaceplayer DragonShrineComeAgainText
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_7
	iftrue_jumptextfaceplayer DragonShrineSymbolicDragonText
	checkevent EVENT_GOT_DRATINI
	iffalse .GiveDratini
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iftrue_jumptextfaceplayer DragonShrineSilverIsInTrainingText
	jumptextfaceplayer DragonShrineClairsGrandfatherText

.GiveDratini:
	faceplayer
	opentext
	writetext DragonShrineTakeThisDratiniText
	waitbutton
	checkcode VAR_PARTYCOUNT
	ifequal 6, .PartyFull
	writetext DragonShrinePlayerReceivedDratiniText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke DRATINI, NO_FORM, 15, SITRUS_BERRY
	writebyte ULTRA_BALL
	special SetLastPartyMonBall
	checkevent EVENT_ANSWERED_DRAGON_MASTER_QUIZ_WRONG
	iftrue .NoExtremeSpeed
	special TeachDratiniExtremeSpeed
.NoExtremeSpeed
	setevent EVENT_GOT_DRATINI
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_7
	jumpopenedtext DragonShrineSymbolicDragonText

.PartyFull:
	jumpopenedtext DragonShrinePartyFullText

DragonShrineQuestion1_MenuHeader:
	db $40 ; flags
	db 04, 08 ; start coords
	db 11, 19 ; end coords
	dw MenuData2_0x18d21d
	db 1 ; default option

MenuData2_0x18d21d:
	db $81 ; flags
	db 3 ; items
	db "Ally@"
	db "Underling@"
	db "Friend@"

DragonShrineQuestion2_MenuHeader:
	db $40 ; flags
	db 04, 09 ; start coords
	db 11, 19 ; end coords
	dw MenuData2_0x18d23c
	db 1 ; default option

MenuData2_0x18d23c:
	db $81 ; flags
	db 3 ; items
	db "Strategy@"
	db "Training@"
	db "Cheating@"

DragonShrineQuestion3_MenuHeader:
	db $40 ; flags
	db 04, 05 ; start coords
	db 11, 19 ; end coords
	dw MenuData2_0x18d260
	db 1 ; default option

MenuData2_0x18d260:
	db $81 ; flags
	db 3 ; items
	db "Weak person@"
	db "Tough person@"
	db "Anybody@"

DragonShrineQuestion4_MenuHeader:
	db $40 ; flags
	db 04, 08 ; start coords
	db 11, 19 ; end coords
	dw MenuData2_0x18d28b
	db 1 ; default option

MenuData2_0x18d28b:
	db $81 ; flags
	db 3 ; items
	db "Love@"
	db "Violence@"
	db "Knowledge@"

DragonShrineQuestion5_MenuHeader:
	db $40 ; flags
	db 04, 11 ; start coords
	db 11, 19 ; end coords
	dw MenuData2_0x18d2ad
	db 1 ; default option

MenuData2_0x18d2ad:
	db $81 ; flags
	db 3 ; items
	db "Strong@"
	db "Weak@"
	db "Both@"

DragonShrinePlayerWalkInMovement:
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_right
	slow_step_up
	slow_step_up
	slow_step_up
	step_end

DragonShrineElderWalkToClairMovement:
	slow_step_left
	slow_step_left
	slow_step_left
	turn_head_down
	step_end

DragonShrineElderWalkAway1Movement:
	slow_step_right
	slow_step_right
	step_end

DragonShrineElderWalkAway2Movement:
	slow_step_right
	turn_head_down
	step_end

DragonShrineClairWalkInMovement:
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	step_end

DragonShrineClairBigStepLeftMovement:
	fix_facing
	run_step_left
	step_end

DragonShrineClairSlowStepLeftMovement:
	slow_step_left
	remove_fixed_facing
	step_end

DragonShrineClairTwoSlowStepsRightMovement:
	slow_step_right
	slow_step_right
	step_end

DragonShrineClairWalkOutMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

DragonShrineElderGreetingText:
	text "Hm… Good to see"
	line "you here."

	para "No need to explain"
	line "why you came."

	para "Clair sent you"
	line "here, didn't she?"

	para "That girl is a"
	line "handful…"

	para "I am sorry, but I"
	line "must test you."

	para "Not to worry, you"
	line "are to answer only"
	cont "a few questions."

	para "Ready?"
	done

DragonShrineQuestion1Text:
	text "What are #mon"
	line "to you?"
	done

DragonShrineQuestion2Text:
	text "What helps you to"
	line "win battles?"
	done

DragonShrineQuestion3Text:
	text "What kind of"
	line "trainer do you"
	cont "wish to battle?"
	done

DragonShrineQuestion4Text:
	text "What is most"
	line "important for"
	cont "raising #mon?"
	done

DragonShrineQuestion5Text:
	text "Strong #mon."
	line "Weak #mon."

	para "Which is more"
	line "important?"
	done

DragonShrinePassedTestText:
	text "Hm… I see…"

	para "You care deeply"
	line "for #mon."

	para "Very commendable."

	para "That conviction is"
	line "what is important!"

	para "<PLAYER>, don't"
	line "lose that belief."

	para "It will see you"
	line "through at the"
	cont "#mon League."
	done

DragonShrineMustIInformLanceText:
	text "Clair!"

	para "This child is"
	line "impeccable, in"
	cont "skill and spirit!"

	para "Admit defeat and"
	line "confer the Rising"
	cont "Badge!"

	para "…Or must I inform"
	line "Lance of this?"
	done

DragonShrineElderScoldsClairText:
	text "Clair…"

	para "Reflect upon what"
	line "it is that you"

	para "lack and this"
	line "child has."
	done

DragonShrineComeAgainText:
	text "Come again, if you"
	line "so desire."
	done

DragonShrineTakeThisDratiniText:
	text "Hm… Good to see"
	line "you here."

	para "Your arrival is"
	line "most fortunate."

	para "I have something"
	line "for you."

	para "Take this Dratini"
	line "as proof that I"

	para "have recognized"
	line "your worth."
	done

DragonShrinePlayerReceivedDratiniText:
	text "<PLAYER> received"
	line "Dratini!"
	done

DragonShrinePartyFullText:
	text "Hm? Your #mon"
	line "party is full."
	done

DragonShrineSymbolicDragonText:
	text "Dragon #mon are"
	line "symbolic of our"
	cont "clan."

	para "You have shown"
	line "that you can be"

	para "entrusted with"
	line "one."
	done

DragonShrineClairsGrandfatherText:
	text "Clair appears to"
	line "have learned an"

	para "invaluable lesson"
	line "from you."

	para "I thank you as her"
	line "grandfather."
	done

DragonShrineSilverIsInTrainingText:
	text "A boy close to"
	line "your age is in"
	cont "training here."

	para "He is much like"
	line "Clair when she was"

	para "younger. It is a"
	line "little worrisome…"
	done

DragonShrineWrongAnswerText1:
	text "Hah? I didn't"
	line "quite catch that…"
	done

DragonShrineWrongAnswerText2:
	text "What was it you"
	line "said?"
	done

DragonShrineRightAnswerText:
	text "Oh, I understand…"
	done

DragonShrineElder2Text:
	text "It's been quite"
	line "some time since a"

	para "trainer has gained"
	line "our Master's rare"
	cont "approval."

	para "In fact, not since"
	line "Master Lance."
	done

DragonShrineElder3Text:
	text "You know young"
	line "Master Lance?"

	para "He looks so much"
	line "like our Master"
	cont "did in his youth."

	para "It's in their"
	line "blood."
	done

DragonShrineClairYouPassedText:
	text "So how did it go?"

	para "I guess there's no"
	line "point in asking."

	para "You did fail?"

	para "………………………………"

	para "…What? You passed?"
	done

DragonShrineClairThatCantBeText:
	text "That can't be!"
	done

DragonShrineClairYoureLyingText:
	text "You're lying!"

	para "Even I haven't"
	line "been approved!"
	done

DragonShrineIUnderstandText:
	text "I-I understand…"
	done

DragonShrineHereRisingBadgeText:
	text "Here, this is the"
	line "Rising Badge…"

	para "Hurry up! Take it!"
	done

DragonShrinePlayerReceivedRisingBadgeText:
	text "<PLAYER> received"
	line "the Rising Badge."
	done

DragonShrineRisingBadgeExplanationText:
	text "The Rising Badge"
	line "will enable your"

	para "#mon to use the"
	line "move for climbing"
	cont "waterfalls."

	para "Also, all #mon"
	line "will recognize you"

	para "as a trainer and"
	line "obey your every"

	para "command without"
	line "question."
	done

DragonShrineSpeechlessText:
	text "………………………………"
	done
