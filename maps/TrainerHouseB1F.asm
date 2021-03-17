TrainerHouseB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, TrainerHouseB1FCallback

	def_warp_events
	warp_event  9,  4, TRAINER_HOUSE_1F, 3

	def_coord_events
	coord_event  7,  3, 0, TrainerHouseReceptionistScript

	def_bg_events

	def_object_events
	object_event  6, 11, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TRAINER_HOUSE_CAL
	object_event  6, 11, SPRITE_KRIS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TRAINER_HOUSE_CARRIE
	object_event  7,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

	object_const_def
	const TRAINERHOUSEB1F_CAL
	const TRAINERHOUSEB1F_CARRIE

TrainerHouseB1FCallback:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Cal
	disappear TRAINERHOUSEB1F_CAL
	appear TRAINERHOUSEB1F_CARRIE
	sjump .Done
.Cal:
	disappear TRAINERHOUSEB1F_CARRIE
	appear TRAINERHOUSEB1F_CAL
.Done:
	endcallback

TrainerHouseReceptionistScript:
	turnobject PLAYER, UP
	opentext
	checkflag ENGINE_FOUGHT_IN_TRAINER_HALL_TODAY
	iftrue .FoughtTooManyTimes
	writetext TrainerHouseB1FIntroText
	promptbutton
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .GetCalName
	gettrainername CARRIE, 1, $0
	sjump .GotName
.GetCalName
	gettrainername CAL, 1, $0
.GotName:
	writetext TrainerHouseB1FYourOpponentIsText
	promptbutton
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
	sjump .StartBattle
.LoadTrainerCal
	setlasttalked TRAINERHOUSEB1F_CAL
	loadtrainer CAL, 1
.StartBattle
	startbattle
	reloadmapafterbattle
.End:
	givebp 1
	opentext
	writetext TrainerHouseB1FEarnedBattlePointText
	specialsound
	waitbutton
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
	text_ram wStringBuffer3
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
	line "1 Battle Point!"
	done
