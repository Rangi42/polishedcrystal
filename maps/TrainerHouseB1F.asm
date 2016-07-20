const_value set 2
	const TRAINERHOUSEB1F_RECEPTIONIST1
	const TRAINERHOUSEB1F_RECEPTIONIST2
	const TRAINERHOUSEB1F_CHRIS
	const TRAINERHOUSEB1F_COOLTRAINERM1
	const TRAINERHOUSEB1F_COOLTRAINERM2
	const TRAINERHOUSEB1F_COOLTRAINERF1
	const TRAINERHOUSEB1F_COOLTRAINERF2
	const TRAINERHOUSEB1F_COOLTRAINERF3

TrainerHouseB1F_MapScriptHeader:
.MapTriggers:
	db 1

	; triggers
	dw Trigger0, 0

.MapCallbacks:
	db 0

Trigger0:
	end

TrainerHouseReceptionist1Script:
	spriteface PLAYER, UP
	opentext
	checkflag ENGINE_FOUGHT_IN_TRAINER_HALL_TODAY
	iftrue .FoughtTooManyTimes
	writetext TrainerHouseB1FIntroText
	buttonsound
	special SpecialTrainerHouse
	iffalse .GetCal3Name
	trainertotext CAL, CAL2, $0
	jump .GotName

.GetCal3Name:
	trainertotext CAL, CAL1, $0
.GotName:
	writetext TrainerHouseB1FYourOpponentIsText
	buttonsound
	writetext TrainerHouseB1FAskWantToBattleText
	yesorno
	iffalse .Declined
	setflag ENGINE_FOUGHT_IN_TRAINER_HALL_TODAY
	writetext TrainerHouseB1FGoRightInText
	waitbutton
	closetext
	applymovement PLAYER, Movement_EnterTrainerHouseBattleRoom
	opentext
	writetext TrainerHouseB1FCalBeforeText
	waitbutton
	closetext
	special SpecialTrainerHouse
	iffalse .NoSpecialBattle
	winlosstext TrainerHouseB1FCalBeatenText, 0
	setlasttalked TRAINERHOUSEB1F_CHRIS
	loadtrainer CAL, CAL2
	startbattle
	reloadmapafterbattle
	iffalse .End
.NoSpecialBattle:
	winlosstext TrainerHouseB1FCalBeatenText, 0
	setlasttalked TRAINERHOUSEB1F_CHRIS
	loadtrainer CAL, CAL1
	startbattle
	reloadmapafterbattle
.End:
	applymovement PLAYER, Movement_ExitTrainerHouseBattleRoom
	end

.Declined:
	writetext TrainerHouseB1FPleaseComeAgainText
	waitbutton
	closetext
	applymovement PLAYER, Movement_TrainerHouseTurnBack
	end

.FoughtTooManyTimes:
	writetext TrainerHouseB1FSecondChallengeDeniedText
	waitbutton
	closetext
	applymovement PLAYER, Movement_TrainerHouseTurnBack
	end

Movement_EnterTrainerHouseBattleRoom:
	step_left
	step_left
	step_left
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_left
	turn_head_right
	step_end

Movement_ExitTrainerHouseBattleRoom:
	step_up
	step_up
	step_up
	step_right
	step_up
	step_up
	step_up
	step_up
	step_up
	step_right
	step_right
	step_right
	step_right
	step_end

Movement_TrainerHouseTurnBack:
	step_right
	turn_head_left
	step_end

TrainerHouseReceptionist2Script:
	opentext
	writetext TrainerHouseReceptionist2SignpostText
	waitbutton
	checkevent EVENT_BEAT_COOLTRAINERM_ABDUL
	iffalse .Challenge
	checkevent EVENT_BEAT_COOLTRAINERM_ELAN
	iffalse .Challenge
	checkevent EVENT_BEAT_COOLTRAINERF_SALMA
	iffalse .Challenge
	checkevent EVENT_BEAT_COOLTRAINERF_BONITA
	iffalse .Challenge
	checkevent EVENT_BEAT_COOLTRAINERF_IDA
	iffalse .Challenge
	checkevent EVENT_GOT_TRAINER_HOUSE_REWARD
	iftrue .Finished
	writetext TrainerHouseReceptionist2CongratulationsText
	waitbutton
	verbosegiveitem NUGGET
	iffalse .Finished
	setevent EVENT_GOT_TRAINER_HOUSE_REWARD
	jump .Finished
.Challenge
	writetext TrainerHouseReceptionist2ChallengeText
	waitbutton
.Finished
	closetext
	end

TrainerCooltrainermAbdul:
	trainer EVENT_BEAT_COOLTRAINERM_ABDUL, COOLTRAINERM, ABDUL, CooltrainermAbdulSeenText, CooltrainermAbdulBeatenText, 0, CooltrainermAbdulScript

CooltrainermAbdulScript:
	end_if_just_battled
	opentext
	writetext CooltrainermAbdulAfterText
	waitbutton
	closetext
	end

TrainerCooltrainermElan:
	trainer EVENT_BEAT_COOLTRAINERM_ELAN, COOLTRAINERM, ELAN, CooltrainermElanSeenText, CooltrainermElanBeatenText, 0, CooltrainermElanScript

CooltrainermElanScript:
	end_if_just_battled
	opentext
	writetext CooltrainermElanAfterText
	waitbutton
	closetext
	end

TrainerCooltrainerfSalma:
	trainer EVENT_BEAT_COOLTRAINERF_SALMA, COOLTRAINERF, SALMA, CooltrainerfSalmaSeenText, CooltrainerfSalmaBeatenText, 0, CooltrainerfSalmaScript

CooltrainerfSalmaScript:
	end_if_just_battled
	opentext
	writetext CooltrainerfSalmaAfterText
	waitbutton
	closetext
	end

TrainerCooltrainerfBonita:
	trainer EVENT_BEAT_COOLTRAINERF_BONITA, COOLTRAINERF, BONITA, CooltrainerfBonitaSeenText, CooltrainerfBonitaBeatenText, 0, CooltrainerfBonitaScript

CooltrainerfBonitaScript:
	end_if_just_battled
	opentext
	writetext CooltrainerfBonitaAfterText
	waitbutton
	closetext
	end

TrainerCooltrainerfIda:
	trainer EVENT_BEAT_COOLTRAINERF_IDA, COOLTRAINERF, IDA, CooltrainerfIdaSeenText, CooltrainerfIdaBeatenText, 0, CooltrainerfIdaScript

CooltrainerfIdaScript:
	end_if_just_battled
	opentext
	writetext CooltrainerfIdaAfterText
	waitbutton
	closetext
	end

TrainerHouseB1FIntroText:
	text "Hi. Welcome to our"
	line "Training Hall."

	para "You may battle a"
	line "trainer once per"
	cont "day."
	done

TrainerHouseB1FYourOpponentIsText:
	text_from_ram StringBuffer3
	text " is your"
	line "opponent today."
	done

TrainerHouseB1FAskWantToBattleText:
	text "Would you like to"
	line "battle?"
	done

TrainerHouseB1FGoRightInText:
	text "Please go right"
	line "through."

	para "You may begin"
	line "right away."
	done

TrainerHouseB1FPleaseComeAgainText:
	text "Sorry. Only those"
	line "trainers who will"

	para "be battling are"
	line "allowed to go in."
	done

TrainerHouseB1FSecondChallengeDeniedText:
	text "I'm sorry."
	line "This would be your"

	para "second time today."
	line "You're permitted"

	para "to enter just once"
	line "a day."
	done

TrainerHouseB1FCalBeatenText:
	text "I lost…"
	line "Darn…"
	done

TrainerHouseB1FCalBeforeText:
	text "I traveled out"
	line "here just so I"
	cont "could battle you."
	done

TrainerHouseReceptionist2SignpostText:
	text "Hi. Welcome to our"
	line "Training Hall."

	para "The all-day arena"
	line "is to your right."
	done

TrainerHouseReceptionist2ChallengeText:
	text "See how well you"
	line "do against some"
	cont "top trainers!"
	done

TrainerHouseReceptionist2CongratulationsText:
	text "Congratulations!"
	line "Here's a prize for"
	cont "your exellent"
	cont "battling."
	done

CooltrainermAbdulSeenText:
	text "Fight me and see"
	line "how good I am!"
	done

CooltrainermAbdulBeatenText:
	text "I was deceived!"
	done

CooltrainermAbdulAfterText:
	text "Me, I should be"
	line "a pretty good"
	cont "practice partner…"
	done

CooltrainermElanSeenText:
	text "Let's get this"
	line "fight started!"
	done

CooltrainermElanBeatenText:
	text "Well, this is"
	line "surprising."
	done

CooltrainermElanAfterText:
	text "You're stronger"
	line "than I expected!"
	done

CooltrainerfSalmaSeenText:
	text "What do you think?"

	para "Isn't Viridian's"
	line "Trainer House"
	cont "wonderful?"
	done

CooltrainerfSalmaBeatenText:
	text "Whatever!"
	done

CooltrainerfSalmaAfterText:
	text "There are many ci-"
	line "ties in the world,"
	cont "but I really like"
	cont "this one!"
	done

CooltrainerfBonitaSeenText:
	text "Looking around the"
	line "room, aren't you"
	cont "impressed by all"
	cont "the cool trainers?"
	done

CooltrainerfBonitaBeatenText:
	text "All of my #mon"
	line "are fainting…"
	done

CooltrainerfBonitaAfterText:
	text "Looks like you've"
	line "still got some"
	cont "energy left."
	done

CooltrainerfIdaSeenText:
	text "All right, come"
	line "on and battle!"
	done

CooltrainerfIdaBeatenText:
	text "Wow. You're really"
	line "something."
	done

CooltrainerfIdaAfterText:
	text "If all you have"
	line "is strength, you"
	cont "won't do well."

	para "Strategy is also"
	line "important!"
	done

TrainerHouseB1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $4, $9, 3, TRAINER_HOUSE_1F

.XYTriggers:
	db 1
	xy_trigger 0, $3, $7, $0, TrainerHouseReceptionist1Script, $0, $0

.Signposts:
	db 1
	signpost 2, 12, SIGNPOST_READ, TrainerHouseReceptionist2Script

.PersonEvents:
	db 8
	person_event SPRITE_RECEPTIONIST, 1, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_RECEPTIONIST, 1, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_CHRIS, 11, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_COOLTRAINER_M, 9, 12, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 0, TrainerCooltrainermAbdul, -1
	person_event SPRITE_COOLTRAINER_M, 13, 15, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 0, TrainerCooltrainermElan, -1
	person_event SPRITE_COOLTRAINER_F, 9, 15, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 0, TrainerCooltrainerfSalma, -1
	person_event SPRITE_COOLTRAINER_F, 11, 17, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 0, TrainerCooltrainerfBonita, -1
	person_event SPRITE_COOLTRAINER_F, 13, 13, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 0, TrainerCooltrainerfIda, -1
