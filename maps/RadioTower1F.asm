RadioTower1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  2,  7, GOLDENROD_CITY, 11
	warp_event  3,  7, GOLDENROD_CITY, 11
	warp_event 15,  0, RADIO_TOWER_2F, 2

	db 0 ; coord events

	db 2 ; bg events
	bg_event  3,  0, SIGNPOST_JUMPTEXT, UnknownText_0x5d5e7
	bg_event 13,  0, SIGNPOST_JUMPTEXT, UnknownText_0x5d631

	db 7 ; object events
	object_event  8,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, ReceptionistScript_0x5cd3d, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 14,  6, SPRITE_WHITNEY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, RadioTower1FWhitneyScript, EVENT_GOLDENROD_GYM_WHITNEY
	object_event  5,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, ReceptionistScript_0x5cd29, -1
	object_event 17,  5, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5d476, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 17,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5d4ac, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 14,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerGruntM3, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 12,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x5cdd5, EVENT_GOLDENROD_CITY_CIVILIANS

	const_def 1 ; object constants
	const RADIOTOWER1F_FELICITY
	const RADIOTOWER1F_WHITNEY

ReceptionistScript_0x5cd29:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue_jumptextfaceplayer UnknownText_0x5ce81
	jumptextfaceplayer UnknownText_0x5ce77

ReceptionistScript_0x5cd3d:
	faceplayer
	opentext
	writetext UnknownText_0x5ceba
	waitbutton
	checkevent EVENT_INTRODUCED_FELICITY
	iftrue .introduced
	writetext IntroduceFelicityText
	waitbutton
	setevent EVENT_INTRODUCED_FELICITY
.introduced
	writetext ExplainLuckyNumberShowText
	buttonsound
	special Special_CheckLuckyNumberShowFlag
	iffalse .skip
	special Special_ResetLuckyNumberShowFlag
.skip
	special Special_PrintTodaysLuckyNumber
	checkflag ENGINE_LUCKY_NUMBER_SHOW
	iftrue_jumpopenedtext UnknownText_0x5cf7e
	writetext UnknownText_0x5cf3a
	buttonsound
	closetext
	applymovement RADIOTOWER1F_FELICITY, MovementData_0x5ce71
	opentext
	writetext UnknownText_0x5cf5a
	buttonsound
	waitsfx
	writetext UnknownText_0x5cf79
	playsound SFX_DEX_FANFARE_20_49
	waitsfx
	buttonsound
	special Special_CheckForLuckyNumberWinners
	closetext
	applymovement RADIOTOWER1F_FELICITY, MovementData_0x5ce74
	opentext
	ifequal 1, .FirstPlace
	ifequal 2, .SecondPlace
	ifequal 3, .ThirdPlace
	ifequal 4, .FourthPlace
	jumpopenedtext UnknownText_0x5d0c0

.FirstPlace:
	writetext WonFirstPlaceText
	playsound SFX_1ST_PLACE
	waitsfx
	buttonsound
	giveitem MASTER_BALL
	iffalse_jumpopenedtext UnknownText_0x5d0e6
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	jumpopenedtext UnknownText_0x5cf7e

.SecondPlace:
	writetext WonSecondPlaceText
	playsound SFX_2ND_PLACE
	waitsfx
	buttonsound
	giveitem BOTTLE_CAP
	iffalse_jumpopenedtext UnknownText_0x5d0e6
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	jumpopenedtext UnknownText_0x5cf7e

.ThirdPlace:
	writetext WonThirdPlaceText
	playsound SFX_2ND_PLACE
	waitsfx
	buttonsound
	giveitem PP_MAX
	iffalse_jumpopenedtext UnknownText_0x5d0e6
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	jumpopenedtext UnknownText_0x5cf7e

.FourthPlace:
	writetext WonFourthPlaceText
	playsound SFX_3RD_PLACE
	waitsfx
	buttonsound
	giveitem PP_UP
	iffalse_jumpopenedtext UnknownText_0x5d0e6
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	thisopenedtext

UnknownText_0x5cf7e:
	text "Please come back"
	line "next week for the"
	cont "next Lucky Number."
	done

CooltrainerFScript_0x5cdd5:
	checkevent EVENT_GOLDENROD_GYM_WHITNEY
	iftrue_jumptextfaceplayer UnknownText_0x5d3e5
	faceplayer
	opentext
	writetext UnknownText_0x5d12d
	yesorno
	iffalse_jumpopenedtext UnknownText_0x5d443
	writetext UnknownText_0x5d1f2
	yesorno
	iffalse UnknownScript_0x5ce42
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext UnknownText_0x5d231
	yesorno
	iffalse UnknownScript_0x5ce42
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext UnknownText_0x5d282
	yesorno
	iftrue UnknownScript_0x5ce42
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext UnknownText_0x5d2bc
	yesorno
	iftrue UnknownScript_0x5ce42
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext UnknownText_0x5d30e
	yesorno
	iftrue UnknownScript_0x5ce42
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext UnknownText_0x5d37b
	buttonsound
	stringtotext RadioCardText, $1
	callstd receiveitem
	writetext UnknownText_0x5d3c0
	buttonsound
	setflag ENGINE_RADIO_CARD
	writetext UnknownText_0x5d3e5
	waitbutton
	closetext
	showemote EMOTE_SHOCK, RADIOTOWER1F_WHITNEY, 15
	applymovement RADIOTOWER1F_WHITNEY, RadioTower1FWhitneyApproachesMovementData
	turnobject PLAYER, RIGHT
	showtext RadioTower1FWhitney2Text
	applymovement RADIOTOWER1F_WHITNEY, RadioTower1FWhitneyLeaves1MovementData
	turnobject PLAYER, LEFT
	applymovement RADIOTOWER1F_WHITNEY, RadioTower1FWhitneyLeaves2MovementData
	disappear RADIOTOWER1F_WHITNEY
	end

RadioCardText:
	db "Radio Card@"

UnknownScript_0x5ce42:
	playsound SFX_WRONG
	jumpopenedtext UnknownText_0x5d409

GenericTrainerGruntM3:
	generictrainer GRUNTM, 3, EVENT_BEAT_ROCKET_GRUNTM_3, GruntM3SeenText, GruntM3BeatenText

	text "You're too strong."

	para "Our plan could be"
	line "ruined. I must"
	cont "warn the others…"
	done

RadioTower1FWhitneyScript:
	showtextfaceplayer RadioTower1FWhitney1Text
	turnobject RADIOTOWER1F_WHITNEY, LEFT
	end

MovementData_0x5ce71:
	step_right
	turn_head_up
	step_end

MovementData_0x5ce74:
	step_left
	turn_head_up
	step_end

RadioTower1FWhitneyApproachesMovementData:
	step_up
	step_up
	step_left
	step_end

RadioTower1FWhitneyLeaves1MovementData:
	step_up
	step_left
	step_left
	step_end

RadioTower1FWhitneyLeaves2MovementData:
	step_left
	step_left
	step_left
	step_left
	step_end

UnknownText_0x5ce77:
	text "Welcome!"
	done

UnknownText_0x5ce81:
	text "Hello. I'm sorry,"
	line "but we're not"
	cont "offering any tours"
	cont "today."
	done

UnknownText_0x5ceba:
	text "Hi, are you here"
	line "for the Lucky Num-"
	cont "ber Show?"
	done

IntroduceFelicityText:
	text "I'm Felicity,"
	line "your attendant"
	cont "today."
	done

ExplainLuckyNumberShowText:
	text "Want me to check"
	line "the ID numbers of"
	cont "your #mon?"

	para "If you get lucky,"
	line "you win a prize."
	done

UnknownText_0x5cf3a:
	text "This week's ID"
	line "number is @"
	text_from_ram StringBuffer3
	text "."
	done

UnknownText_0x5cf5a:
	text "Let's see if you"
	line "have a match."
	done

UnknownText_0x5cf79:
	text "……"
	line "……"
	done

WonFirstPlaceText:
	text "Wow! You have a"
	line "perfect match of"
	cont "all five numbers!"

	para "We have a grand"
	line "prize winner!"

	para "You have won a"
	line "Master Ball!"
	done

WonSecondPlaceText:
	text "Hey! You've"
	line "matched the last"
	cont "four numbers!"

	para "You've won second"
	line "prize, a rare"
	cont "Bottle Cap!"
	done

WonThirdPlaceText:
	text "Hey! You've"
	line "matched the last"
	cont "three numbers!"

	para "You've won third"
	line "prize, a PP Max!"
	done

WonFourthPlaceText:
	text "Ooh, you've"
	line "matched the last"
	cont "two numbers."

	para "You've won fourth"
	line "prize, a PP Up."
	done

UnknownText_0x5d0c0:
	text "Nope, none of your"
	line "ID numbers match."
	done

UnknownText_0x5d0e6:
	text "You've got no room"
	line "for your prize."

	para "Make room and come"
	line "back right away."
	done

UnknownText_0x5d12d:
	text "We have a special"
	line "quiz campaign on"
	cont "right now."

	para "Answer five ques-"
	line "tions correctly to"
	cont "win a Radio Card."

	para "Slide it into your"
	line "#gear to play"

	para "the radio anytime,"
	line "anywhere."

	para "Would you like to"
	line "take the quiz?"
	done

UnknownText_0x5d1f2:
	text "Question 1:"

	para "Is there a #mon"
	line "that appears only"
	cont "in the morning?"
	done

UnknownText_0x5d231:
	text "Correct!"
	line "Question 2:"

	para "Nidorina can only"
	line "be female. True?"
	done

UnknownText_0x5d282:
	text "Bull's-eye!"
	line "Question 3:"

	para "Can Magikarp learn"
	line "any moves via TM?"
	done

UnknownText_0x5d2bc:
	text "So far so good!"
	line "Question 4:"

	para "Does Kurt, the"
	line "# Ball creator,"

	para "use apricots as"
	line "ingredients?"
	done

UnknownText_0x5d30e:
	text "Wow! Right again!"
	line "Here's the final"
	cont "question:"

	para "Do Goldenrod Game"
	line "Corner's slots"

	para "have Charmander"
	line "on their reels?"
	done

UnknownText_0x5d37b:
	text "Bingo! You got it!"
	line "Congratulations!"

	para "Here's your prize,"
	line "a Radio Card!"
	done

UnknownText_0x5d3c0:
	text "<PLAYER>'s #gear"
	line "can now double as"
	cont "a radio!"
	done

UnknownText_0x5d3e5:
	text "Please tune in to"
	line "our radio shows."
	done

UnknownText_0x5d409:
	text "Oh, dear."
	line "Sorry, but you"

	para "got it wrong."
	line "Please try again!"
	done

UnknownText_0x5d443:
	text "Oh. I see. Please"
	line "see me if you"
	cont "change your mind."
	done

UnknownText_0x5d476:
	text "Ben is a fabulous"
	line "DJ."

	para "His sweet voice"
	line "makes me melt!"
	done

UnknownText_0x5d4ac:
	text "I love Mary, from"
	line "#mon Talk."

	para "I only know what"
	line "she sounds like,"
	cont "though."
	done

GruntM3SeenText:
	text "We've finally"
	line "taken over the"
	cont "Radio Tower!"

	para "Now everyone will"
	line "get to experience"

	para "the true terror of"
	line "Team Rocket!"

	para "We'll show you"
	line "how scary we are!"
	done

GruntM3BeatenText:
	text "Too strong! We"
	line "must watch you…"
	done

RadioTower1FWhitney1Text:
	text "Hi! I'm Whitney!"

	para "I heard about the"
	line "quiz to win a"
	cont "Radio Card,"

	para "so I came here"
	line "to get one…"

	para "But this quiz is"
	line "so hard!"
	done

RadioTower1FWhitney2Text:
	text "Whitney: Wow, you"
	line "did it!"

	para "I thought the"
	line "fourth answer"
	cont "was apricots…"

	para "Oops! I should get"
	line "back to the Gym!"
	done

UnknownText_0x5d5e7:
	text "1F Reception"
	line "2F Sales"

	para "3F Personnel"
	line "4F Production"

	para "5F Director's"
	line "   Office"
	done

UnknownText_0x5d631:
	text "Lucky Channel!"

	para "Win with #mon"
	line "ID numbers!"

	para "Trade your #mon"
	line "to collect differ-"
	cont "ent ID numbers!"
	done
