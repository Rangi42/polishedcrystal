RadioTower1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 11
	warp_event  3,  7, GOLDENROD_CITY, 11
	warp_event 15,  0, RADIO_TOWER_2F, 2

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_JUMPTEXT, RadioTower1FDirectoryText
	bg_event 13,  0, BGEVENT_JUMPTEXT, RadioTower1FLuckyChannelSignText

	def_object_events
	object_event  8,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RadioTower1FLuckyNumberManScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 14,  6, SPRITE_WHITNEY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RadioTower1FWhitneyScript, EVENT_GOLDENROD_GYM_WHITNEY
	object_event  5,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower1FReceptionistScript, -1
	object_event 17,  5, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower1FLassText, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 17,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower1FYoungsterText, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 14,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM3, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 12,  6, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower1FRadioCardWomanScript, EVENT_GOLDENROD_CITY_CIVILIANS

	object_const_def
	const RADIOTOWER1F_FELICITY
	const RADIOTOWER1F_WHITNEY

RadioTower1FReceptionistScript:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue_jumptextfaceplayer RadioTower1FReceptionistNoToursText
	jumptextfaceplayer RadioTower1FReceptionistWelcomeText

RadioTower1FLuckyNumberManScript:
	faceplayer
	opentext
	writetext RadioTower1FLuckyNumberManAskToPlayText
	waitbutton
	checkevent EVENT_INTRODUCED_FELICITY
	iftrue .introduced
	writetext IntroduceFelicityText
	waitbutton
	setevent EVENT_INTRODUCED_FELICITY
.introduced
	writetext ExplainLuckyNumberShowText
	promptbutton
	special Special_CheckLuckyNumberShowFlag
	iffalse .skip
	special Special_ResetLuckyNumberShowFlag
.skip
	special Special_PrintTodaysLuckyNumber
	checkflag ENGINE_LUCKY_NUMBER_SHOW
	iftrue_jumpopenedtext RadioTower1FLuckyNumberManComeAgainText
	writetext RadioTower1FLuckyNumberManThisWeeksIdIsText
	promptbutton
	closetext
	applymovement RADIOTOWER1F_FELICITY, RadioTower1FLuckyNumberManGoToPCMovement
	opentext
	writetext RadioTower1FLuckyNumberManCheckIfMatchText
	promptbutton
	waitsfx
	writetext RadioTower1FLuckyNumberManDotDotDotText
	playsound SFX_DEX_FANFARE_20_49
	waitsfx
	promptbutton
	special Special_CheckForLuckyNumberWinners
	closetext
	applymovement RADIOTOWER1F_FELICITY, RadioTower1FLuckyNumberManReturnToPlayerMovement
	opentext
	ifequal 5, .FirstPlace
	ifequal 4, .SecondPlace
	ifequal 3, .ThirdPlace
	ifequal 2, .FourthPlace
	ifequal 1, .FifthPlace
	jumpopenedtext RadioTower1FLuckyNumberManNoneOfYourIDNumbersMatchText

.FirstPlace:
	writetext WonFirstPlaceText
	playsound SFX_1ST_PLACE
	waitsfx
	promptbutton
	giveitem MASTER_BALL
	iffalse_jumpopenedtext RadioTower1FLuckyNumberManNoRoomForYourPrizeText
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	jumpopenedtext RadioTower1FLuckyNumberManComeAgainText

.SecondPlace:
	writetext WonSecondPlaceText
	playsound SFX_2ND_PLACE
	waitsfx
	promptbutton
	giveitem BOTTLE_CAP
	iffalse_jumpopenedtext RadioTower1FLuckyNumberManNoRoomForYourPrizeText
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	jumpopenedtext RadioTower1FLuckyNumberManComeAgainText

.ThirdPlace:
	writetext WonThirdPlaceText
	playsound SFX_2ND_PLACE
	waitsfx
	promptbutton
	giveitem PP_MAX
	iffalse_jumpopenedtext RadioTower1FLuckyNumberManNoRoomForYourPrizeText
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	jumpopenedtext RadioTower1FLuckyNumberManComeAgainText

.FourthPlace:
	writetext WonFourthPlaceText
	playsound SFX_3RD_PLACE
	waitsfx
	promptbutton
	giveitem PP_UP
	iffalse_jumpopenedtext RadioTower1FLuckyNumberManNoRoomForYourPrizeText
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	jumpopenedtext RadioTower1FLuckyNumberManComeAgainText

.FifthPlace:
	writetext WonFifthPlaceText
	playsound SFX_3RD_PLACE
	waitsfx
	promptbutton
	giveitem RARE_CANDY
	iffalse_jumpopenedtext RadioTower1FLuckyNumberManComeAgainText
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	jumpthisopenedtext

RadioTower1FLuckyNumberManComeAgainText:
	text "Please come back"
	line "next week for the"
	cont "next Lucky Number."
	done

RadioTower1FRadioCardWomanScript:
	checkevent EVENT_GOLDENROD_GYM_WHITNEY
	iftrue_jumptextfaceplayer RadioTower1FRadioCardWomanTuneInText
	faceplayer
	opentext
	writetext RadioTower1FRadioCardWomanOfferQuizText
	yesorno
	iffalse_jumpopenedtext RadioTower1FRadioCardWomanNotTakingQuizText
	writetext RadioTower1FRadioCardWomanQuestion1Text
	yesorno
	iffalse .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion2Text
	yesorno
	iffalse .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion3Text
	yesorno
	iftrue .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion4Text
	yesorno
	iftrue .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion5Text
	yesorno
	iftrue .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanYouWinText
	promptbutton
	getstring .RadioCardText, $1
	callstd receiveitem
	writetext RadioTower1FPokegearIsARadioText
	promptbutton
	setflag ENGINE_RADIO_CARD
	writetext RadioTower1FRadioCardWomanTuneInText
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

.RadioCardText:
	db "Radio Card@"

.WrongAnswer:
	playsound SFX_WRONG
	jumpthisopenedtext

	text "Oh, dear."
	line "Sorry, but you"

	para "got it wrong."
	line "Please try again!"
	done

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

RadioTower1FLuckyNumberManGoToPCMovement:
	step_right
	turn_head_up
	step_end

RadioTower1FLuckyNumberManReturnToPlayerMovement:
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

RadioTower1FReceptionistWelcomeText:
	text "Welcome!"
	done

RadioTower1FReceptionistNoToursText:
	text "Hello. I'm sorry,"
	line "but we're not"
	cont "offering any tours"
	cont "today."
	done

RadioTower1FLuckyNumberManAskToPlayText:
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

RadioTower1FLuckyNumberManThisWeeksIdIsText:
	text "This week's ID"
	line "number is "
	text_ram wStringBuffer3
	text "."
	done

RadioTower1FLuckyNumberManCheckIfMatchText:
	text "Let's see if you"
	line "have a match."
	done

RadioTower1FLuckyNumberManDotDotDotText:
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

WonFifthPlaceText:
	text "Ooh, you've"
	line "matched the last"
	cont "number."

	para "You've won fifth"
	line "prize, a"
	cont "Rare Candy."
	done

RadioTower1FLuckyNumberManNoneOfYourIDNumbersMatchText:
	text "Nope, none of your"
	line "ID numbers match."
	done

RadioTower1FLuckyNumberManNoRoomForYourPrizeText:
	text "You've got no room"
	line "for your prize."

	para "Make room and come"
	line "back right away."
	done

RadioTower1FRadioCardWomanOfferQuizText:
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

RadioTower1FRadioCardWomanQuestion1Text:
	text "Question 1:"

	para "Is there a #mon"
	line "that appears only"
	cont "in the morning?"
	done

RadioTower1FRadioCardWomanQuestion2Text:
	text "Correct!"
	line "Question 2:"

	para "Nidorina can only"
	line "be female. True?"
	done

RadioTower1FRadioCardWomanQuestion3Text:
	text "Bull's-eye!"
	line "Question 3:"

	para "Can Magikarp learn"
	line "any moves via TM?"
	done

RadioTower1FRadioCardWomanQuestion4Text:
	text "So far so good!"
	line "Question 4:"

	para "Does Kurt, the"
	line "# Ball creator,"

	para "use apricots as"
	line "ingredients?"
	done

RadioTower1FRadioCardWomanQuestion5Text:
	text "Wow! Right again!"
	line "Here's the final"
	cont "question:"

	para "Do Goldenrod Game"
	line "Corner's slots"

	para "have Charmander"
	line "on their reels?"
	done

RadioTower1FRadioCardWomanYouWinText:
	text "Bingo! You got it!"
	line "Congratulations!"

	para "Here's your prize,"
	line "a Radio Card!"
	done

RadioTower1FPokegearIsARadioText:
	text "<PLAYER>'s #gear"
	line "can now double as"
	cont "a radio!"
	done

RadioTower1FRadioCardWomanTuneInText:
	text "Please tune in to"
	line "our radio shows."
	done

RadioTower1FRadioCardWomanNotTakingQuizText:
	text "Oh. I see. Please"
	line "see me if you"
	cont "change your mind."
	done

RadioTower1FLassText:
	text "Ben is a fabulous"
	line "DJ."

	para "His sweet voice"
	line "makes me melt!"
	done

RadioTower1FYoungsterText:
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

RadioTower1FDirectoryText:
	text "1F Reception"
	line "2F Sales"

	para "3F Personnel"
	line "4F Production"

	para "5F Director's"
	line "   Office"
	done

RadioTower1FLuckyChannelSignText:
	text "Lucky Channel!"

	para "Win with #mon"
	line "ID numbers!"

	para "Trade your #mon"
	line "to collect differ-"
	cont "ent ID numbers!"
	done
