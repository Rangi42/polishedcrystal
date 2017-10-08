DragonShrine_MapScriptHeader:

.MapTriggers: db 1
	dw DragonShrineTrigger0

.MapCallbacks: db 0

DragonShrine_MapEventHeader:

.Warps: db 2
	warp_def 9, 4, 2, DRAGONS_DEN_B1F
	warp_def 9, 5, 2, DRAGONS_DEN_B1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 4
	person_event SPRITE_ELDER, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ElderScript_0x18d1a5, EVENT_GAVE_KURT_APRICORNS
	person_event SPRITE_CLAIR, 8, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_DRAGON_SHRINE_CLAIR
	person_event SPRITE_ELDER, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ElderScript_0x18d205, EVENT_GAVE_KURT_APRICORNS
	person_event SPRITE_ELDER, 4, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ElderScript_0x18d20d, EVENT_GAVE_KURT_APRICORNS

const_value set 1
	const DRAGONSHRINE_ELDER1
	const DRAGONSHRINE_CLAIR

DragonShrineTrigger0:
	priorityjump DragonShrineTestScript
	end

DragonShrineTestScript:
	applymovement PLAYER, MovementData_0x18d2bf
	applyonemovement DRAGONSHRINE_ELDER1, slow_step_down
	opentext
	writetext UnknownText_0x18d2ea
	buttonsound
.Question1:
	setevent EVENT_RECEIVED_BALLS_FROM_KURT
	writetext UnknownText_0x18d3bc
	buttonsound
	loadmenudata MenuDataHeader_0x18d215
	verticalmenu
	closewindow
	if_equal $1, .RightAnswer
	if_equal $2, .WrongAnswer
	if_equal $3, .RightAnswer
	end

.Question2:
	setevent EVENT_DRAGON_SHRINE_QUESTION_2
	writetext UnknownText_0x18d3d3
	buttonsound
	loadmenudata MenuDataHeader_0x18d234
	verticalmenu
	closewindow
	if_equal $1, .RightAnswer
	if_equal $2, .RightAnswer
	if_equal $3, .WrongAnswer
.Question3:
	setevent EVENT_DRAGON_SHRINE_QUESTION_3
	writetext UnknownText_0x18d3f3
	buttonsound
	loadmenudata MenuDataHeader_0x18d258
	verticalmenu
	closewindow
	if_equal $1, .WrongAnswer
	if_equal $2, .RightAnswer
	if_equal $3, .RightAnswer
.Question4:
	setevent EVENT_DRAGON_SHRINE_QUESTION_4
	writetext UnknownText_0x18d420
	buttonsound
	loadmenudata MenuDataHeader_0x18d283
	verticalmenu
	closewindow
	if_equal $1, .RightAnswer
	if_equal $2, .WrongAnswer
	if_equal $3, .RightAnswer
.Question5:
	setevent EVENT_DRAGON_SHRINE_QUESTION_5
	writetext UnknownText_0x18d44a
	buttonsound
	loadmenudata MenuDataHeader_0x18d2a5
	verticalmenu
	closewindow
	if_equal $1, .WrongAnswer
	if_equal $2, .WrongAnswer
	if_equal $3, .RightAnswer
.RightAnswer:
	checkevent EVENT_DRAGON_SHRINE_QUESTION_5
	iftrue .PassedTheTest
	writetext UnknownText_0x18d82d
	buttonsound
	checkevent EVENT_DRAGON_SHRINE_QUESTION_4
	iftrue .Question5
	checkevent EVENT_DRAGON_SHRINE_QUESTION_3
	iftrue .Question4
	checkevent EVENT_DRAGON_SHRINE_QUESTION_2
	iftrue .Question3
	checkevent EVENT_RECEIVED_BALLS_FROM_KURT
	iftrue .Question2
.WrongAnswer:
	closetext
	spriteface DRAGONSHRINE_ELDER1, LEFT
	showtext UnknownText_0x18d7f6
	spriteface DRAGONSHRINE_ELDER1, DOWN
	showtext UnknownText_0x18d816
	setevent EVENT_ANSWERED_DRAGON_MASTER_QUIZ_WRONG
	opentext
	checkevent EVENT_DRAGON_SHRINE_QUESTION_5
	iftrue .Question5
	checkevent EVENT_DRAGON_SHRINE_QUESTION_4
	iftrue .Question4
	checkevent EVENT_DRAGON_SHRINE_QUESTION_3
	iftrue .Question3
	checkevent EVENT_DRAGON_SHRINE_QUESTION_2
	iftrue .Question2
	checkevent EVENT_RECEIVED_BALLS_FROM_KURT
	iftrue .Question1
.PassedTheTest:
	writetext UnknownText_0x18d47c
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_CLAIR
	appear DRAGONSHRINE_CLAIR
	waitsfx
	spriteface PLAYER, DOWN
	pause 30
	applymovement DRAGONSHRINE_CLAIR, MovementData_0x18d2d4
	spriteface DRAGONSHRINE_CLAIR, RIGHT
	spriteface PLAYER, LEFT
	spriteface DRAGONSHRINE_ELDER1, LEFT
	showtext UnknownText_0x18d916
	special Special_FadeOutMusic
	applymovement DRAGONSHRINE_CLAIR, MovementData_0x18d2da
	showtext UnknownText_0x18d974
	applymovement DRAGONSHRINE_CLAIR, MovementData_0x18d2dd
	showtext UnknownText_0x18d983
	applymovement DRAGONSHRINE_ELDER1, MovementData_0x18d2c9
	spriteface DRAGONSHRINE_CLAIR, UP
	showtext UnknownText_0x18d520
	showemote EMOTE_SHOCK, DRAGONSHRINE_CLAIR, 15
	showtext UnknownText_0x18d9ae
	applymovement DRAGONSHRINE_CLAIR, MovementData_0x18d2e0
	opentext
	writetext UnknownText_0x18d9bf
	waitbutton
	setflag ENGINE_RISINGBADGE
	playsound SFX_GET_BADGE
	waitsfx
	special RestartMapMusic
	specialphonecall SPECIALCALL_MASTERBALL
	dotrigger $1
	domaptrigger DRAGONS_DEN_B1F, $1
	writetext UnknownText_0x18d9f2
	buttonsound
	writetext UnknownText_0x18da0b
	waitbutton
	closetext
	applymovement DRAGONSHRINE_ELDER1, MovementData_0x18d2ce
	spriteface DRAGONSHRINE_CLAIR, UP
	applymovement DRAGONSHRINE_ELDER1, MovementData_0x18d2d1
	spriteface PLAYER, UP
	showtext UnknownText_0x18d5a3
	showtext UnknownText_0x18dab4
	applymovement DRAGONSHRINE_CLAIR, MovementData_0x18d2e3
	playsound SFX_ENTER_DOOR
	disappear DRAGONSHRINE_CLAIR
	waitsfx
	setevent EVENT_GAVE_KURT_APRICORNS
	end

ElderScript_0x18d1a5:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iftrue .DontGiveDratiniYet
	checkevent EVENT_JUST_RECEIVED_DRATINI
	iftrue .ReceivedDratini
	checkevent EVENT_GOT_DRATINI
	iffalse .GiveDratini
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iftrue .BeatRivalInMtMoon
	jumpopenedtext UnknownText_0x18d724

.GiveDratini:
	writetext UnknownText_0x18d604
	waitbutton
	checkcode VAR_PARTYCOUNT
	if_equal 6, .PartyFull
	writetext UnknownText_0x18d697
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke DRATINI, 15, SITRUS_BERRY
	writebyte ULTRA_BALL
	special SetLastPartyMonBall
	checkevent EVENT_ANSWERED_DRAGON_MASTER_QUIZ_WRONG
	iftrue .NoExtremeSpeed
	special TeachDratiniExtremeSpeed
.NoExtremeSpeed
	setevent EVENT_GOT_DRATINI
	setevent EVENT_JUST_RECEIVED_DRATINI
	jumpopenedtext UnknownText_0x18d6ca

.PartyFull:
	jumpopenedtext UnknownText_0x18d6ac

.BeatRivalInMtMoon:
	jumpopenedtext UnknownText_0x18d782

.DontGiveDratiniYet:
	jumpopenedtext UnknownText_0x18d5e5

.ReceivedDratini:
	jumpopenedtext UnknownText_0x18d6ca

ElderScript_0x18d205:
	faceplayer
	jumptext UnknownText_0x18d840

ElderScript_0x18d20d:
	faceplayer
	jumptext UnknownText_0x18d8b1

MenuDataHeader_0x18d215:
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

MenuDataHeader_0x18d234:
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

MenuDataHeader_0x18d258:
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

MenuDataHeader_0x18d283:
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

MenuDataHeader_0x18d2a5:
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

MovementData_0x18d2bf:
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_right
	slow_step_up
	slow_step_up
	slow_step_up
	step_end

MovementData_0x18d2c9:
	slow_step_left
	slow_step_left
	slow_step_left
	turn_head_down
	step_end

MovementData_0x18d2ce:
	slow_step_right
	slow_step_right
	step_end

MovementData_0x18d2d1:
	slow_step_right
	turn_head_down
	step_end

MovementData_0x18d2d4:
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	step_end

MovementData_0x18d2da:
	fix_facing
	big_step_left
	step_end

MovementData_0x18d2dd:
	slow_step_left
	remove_fixed_facing
	step_end

MovementData_0x18d2e0:
	slow_step_right
	slow_step_right
	step_end

MovementData_0x18d2e3:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

UnknownText_0x18d2ea:
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

UnknownText_0x18d3bc:
	text "What are #mon"
	line "to you?"
	done

UnknownText_0x18d3d3:
	text "What helps you to"
	line "win battles?"
	done

UnknownText_0x18d3f3:
	text "What kind of"
	line "trainer do you"
	cont "wish to battle?"
	done

UnknownText_0x18d420:
	text "What is most"
	line "important for"
	cont "raising #mon?"
	done

UnknownText_0x18d44a:
	text "Strong #mon."
	line "Weak #mon."

	para "Which is more"
	line "important?"
	done

UnknownText_0x18d47c:
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

UnknownText_0x18d520:
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

UnknownText_0x18d5a3:
	text "Clair…"

	para "Reflect upon what"
	line "it is that you"

	para "lack and this"
	line "child has."
	done

UnknownText_0x18d5e5:
	text "Come again, if you"
	line "so desire."
	done

UnknownText_0x18d604:
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

UnknownText_0x18d697:
	text "<PLAYER> received"
	line "Dratini!"
	done

UnknownText_0x18d6ac:
	text "Hm? Your #mon"
	line "party is full."
	done

UnknownText_0x18d6ca:
	text "Dragon #mon are"
	line "symbolic of our"
	cont "clan."

	para "You have shown"
	line "that you can be"

	para "entrusted with"
	line "one."
	done

UnknownText_0x18d724:
	text "Clair appears to"
	line "have learned an"

	para "invaluable lesson"
	line "from you."

	para "I thank you as her"
	line "grandfather."
	done

UnknownText_0x18d782:
	text "A boy close to"
	line "your age is in"
	cont "training here."

	para "He is much like"
	line "Clair when she was"

	para "younger. It is a"
	line "little worrisome…"
	done

UnknownText_0x18d7f6:
	text "Hah? I didn't"
	line "quite catch that…"
	done

UnknownText_0x18d816:
	text "What was it you"
	line "said?"
	done

UnknownText_0x18d82d:
	text "Oh, I understand…"
	done

UnknownText_0x18d840:
	text "It's been quite"
	line "some time since a"

	para "trainer has gained"
	line "our Master's rare"
	cont "approval."

	para "In fact, not since"
	line "Master Lance."
	done

UnknownText_0x18d8b1:
	text "You know young"
	line "Master Lance?"

	para "He looks so much"
	line "like our Master"
	cont "did in his youth."

	para "It's in their"
	line "blood."
	done

UnknownText_0x18d916:
	text "So how did it go?"

	para "I guess there's no"
	line "point in asking."

	para "You did fail?"

	para "………………………………"

	para "…What? You passed?"
	done

UnknownText_0x18d974:
	text "That can't be!"
	done

UnknownText_0x18d983:
	text "You're lying!"

	para "Even I haven't"
	line "been approved!"
	done

UnknownText_0x18d9ae:
	text "I-I understand…"
	done

UnknownText_0x18d9bf:
	text "Here, this is the"
	line "Rising Badge…"

	para "Hurry up! Take it!"
	done

UnknownText_0x18d9f2:
	text "<PLAYER> received"
	line "the Rising Badge."
	done

UnknownText_0x18da0b:
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

UnknownText_0x18dab4:
	text "………………………………"
	done
