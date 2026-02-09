TrainerHouseB1F_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_TRAINERHOUSEB1F_ASK_BATTLE

	def_callbacks
	callback MAPCALLBACK_OBJECTS, TrainerHouseB1FCallback

	def_warp_events
	warp_event  9,  4, TRAINER_HOUSE_1F, 3

	def_coord_events
	coord_event  7,  3, SCENE_TRAINERHOUSEB1F_ASK_BATTLE, TrainerHouseReceptionistScript

	def_bg_events

	def_object_events
	object_event  6, 11, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  7,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

	object_const_def
	const TRAINERHOUSEB1F_OPPONENT

TrainerHouseB1FCallback:
	callasm .PickDailyTrainerHouseOpponent
	endcallback

.PickDailyTrainerHouseOpponent:
	ld a, [wDailyTrainerHouseOpponent]
	cp NUM_TRAINER_HOUSE_OPPONENTS + 1
	jr nc, .pick_opponent
	and a
	jr nz, .got_opponent
.pick_opponent
	ld a, NUM_TRAINER_HOUSE_OPPONENTS
	call RandomRange
	inc a
	ld [wDailyTrainerHouseOpponent], a
.got_opponent
	call .IsOpponentValid
	and a
	jr z, .pick_opponent
	call GetDailyTrainerHouseOpponent
	ld a, [hl]
	farjp LoadTrainerSpriteAsMapObject1

.IsOpponentValid:
	cp OPP_EN
	jr nz, .not_en
	; must have caught all three legendary birds to battle En
	farjp SpecialBirdsCheck
.not_en
	cp OPP_MADOKA
	jr nz, .not_madoka
	; must have caught all three legendary beasts to battle Madoka
	farjp SpecialBeastsCheck
.not_madoka
	ld a, TRUE
	ret

TrainerHouseReceptionistScript:
	turnobject PLAYER, UP
	opentext
	checkflag ENGINE_FOUGHT_IN_TRAINER_HALL_TODAY
	iftruefwd .FoughtTooManyTimes
	writetext TrainerHouseB1FIntroText
	promptbutton
	callasm .GetOpponentName
	writetext TrainerHouseB1FYourOpponentIsText
	promptbutton
	writetext TrainerHouseB1FAskWantToBattleText
	yesorno
	iffalsefwd .Declined
	setflag ENGINE_FOUGHT_IN_TRAINER_HALL_TODAY
	writetext TrainerHouseB1FGoRightInText
	waitbutton
	closetext
	applymovement PLAYER, Movement_EnterTrainerHouseBattleRoom
	showtext TrainerHouseB1FOpponentBeforeText
	winlosstext TrainerHouseB1FOpponentBeatenText, 0
	setlasttalked TRAINERHOUSEB1F_OPPONENT
	callasm .LoadOpponentTrainer
	startbattle
	reloadmapafterbattle
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

.GetOpponentName:
	; based on `gettrainername`
	call GetDailyTrainerHouseOpponent
	ld a, [hli]
	ld b, [hl]
	ld c, a
	farcall GetTrainerName
	ld hl, wStringBuffer3
	jmp CopyName2

.LoadOpponentTrainer:
	; based on `loadtrainer`
	ld a, (1 << 7) | 1
	ld [wBattleScriptFlags], a
	call GetDailyTrainerHouseOpponent
	ld a, [hli]
	ld [wOtherTrainerClass], a
	ld a, [hl]
	ld [wOtherTrainerID], a
	ret

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

TrainerHouseB1FOpponentBeatenText:
	text "I lost…"
	line "Darn…"
	done

TrainerHouseB1FOpponentBeforeText:
	text "I traveled out"
	line "here just so I"
	cont "could battle you."
	done

TrainerHouseB1FEarnedBattlePointText:
	text "<PLAYER> earned"
	line "1 BP!"
	done

GetDailyTrainerHouseOpponent:
	ld a, [wDailyTrainerHouseOpponent]
	dec a
	ld hl, DailyTrainerHouseOpponents
	ld bc, TRAINER_HOUSE_OPPONENT_SIZE
	rst AddNTimes
	ret

INCLUDE "data/events/trainer_house_opponents.asm"
