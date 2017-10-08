TrainerHouseB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TrainerHouseB1F_MapEventHeader:

.Warps: db 1
	warp_def 4, 9, 3, TRAINER_HOUSE_1F

.XYTriggers: db 1
	xy_trigger 0, 3, 7, TrainerHouseReceptionistScript

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_CHRIS, 11, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_TRAINER_HOUSE_CAL
	person_event SPRITE_KRIS, 11, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_TRAINER_HOUSE_CARRIE
	person_event SPRITE_RECEPTIONIST, 1, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1

const_value set 1
	const TRAINERHOUSEB1F_CAL
	const TRAINERHOUSEB1F_CARRIE

TrainerHouseReceptionistScript:
	spriteface PLAYER, UP
	opentext
	checkflag ENGINE_FOUGHT_IN_TRAINER_HALL_TODAY
	iftrue .FoughtTooManyTimes
	writetext TrainerHouseB1FIntroText
	buttonsound
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .GetCalName
	disappear TRAINERHOUSEB1F_CAL
	appear TRAINERHOUSEB1F_CARRIE
	trainertotext CARRIE, 1, $0
	jump .GotName
.GetCalName
	disappear TRAINERHOUSEB1F_CARRIE
	appear TRAINERHOUSEB1F_CAL
	trainertotext CAL, 1, $0
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
	showtext TrainerHouseB1FCalBeforeText
	winlosstext TrainerHouseB1FCalBeatenText, 0
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .LoadTrainerCal
	setlasttalked TRAINERHOUSEB1F_CARRIE
	loadtrainer CARRIE, 1
	jump .StartBattle
.LoadTrainerCal
	setlasttalked TRAINERHOUSEB1F_CAL
	loadtrainer CAL, 1
.StartBattle
	startbattle
	reloadmapafterbattle
.End:
	opentext
	checkcode VAR_BATTLEPOINTS
	if_equal 255, .MaxPoints
	addvar 1
	writevarcode VAR_BATTLEPOINTS
.MaxPoints:
	writetext TrainerHouseB1FEarnedBattlePointText
	closetext
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

TrainerHouseB1FEarnedBattlePointText:
	text "<PLAYER> earned"
	line "1 Battle Point!@"
	sound_item
	text_waitbutton
	db "@"
