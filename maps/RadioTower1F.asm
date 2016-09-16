const_value set 2
	const RADIOTOWER1F_RECEPTIONIST
	const RADIOTOWER1F_LASS
	const RADIOTOWER1F_YOUNGSTER
	const RADIOTOWER1F_ROCKET
	const RADIOTOWER1F_FELICITY
	const RADIOTOWER1F_COOLTRAINER_F

RadioTower1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ReceptionistScript_0x5cd29:
	faceplayer
	opentext
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue UnknownScript_0x5cd37
	writetext UnknownText_0x5ce77
	waitbutton
	closetext
	end

UnknownScript_0x5cd37:
	writetext UnknownText_0x5ce81
	waitbutton
	closetext
	end

ReceptionistScript_0x5cd3d:
	faceplayer
	opentext
	writetext UnknownText_0x5ceba
	buttonsound
	special Special_CheckLuckyNumberShowFlag
	iffalse .skip
	special Special_ResetLuckyNumberShowFlag
.skip
	special Special_PrintTodaysLuckyNumber
	checkflag ENGINE_LUCKY_NUMBER_SHOW
	iftrue .GameOver
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
	if_equal 1, .FirstPlace
	if_equal 2, .SecondPlace
	if_equal 3, .ThirdPlace
	jump .NoPrize

.GameOver:
	writetext UnknownText_0x5cf7e
	waitbutton
	closetext
	end

.FirstPlace:
	writetext UnknownText_0x5cfb5
	playsound SFX_1ST_PLACE
	waitsfx
	buttonsound
	giveitem MASTER_BALL
	iffalse .BagFull
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	jump .GameOver

.SecondPlace:
	writetext UnknownText_0x5d023
	playsound SFX_2ND_PLACE
	waitsfx
	buttonsound
	giveitem EXP_SHARE
	iffalse .BagFull
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	jump .GameOver

.ThirdPlace:
	writetext UnknownText_0x5d076
	playsound SFX_3RD_PLACE
	waitsfx
	buttonsound
	giveitem PP_UP
	iffalse .BagFull
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	jump .GameOver

.NoPrize:
	writetext UnknownText_0x5d0c0
	waitbutton
	closetext
	end

.BagFull:
	writetext UnknownText_0x5d0e6
	waitbutton
	closetext
	end

CooltrainerFScript_0x5cdd5:
	faceplayer
	opentext
	checkflag ENGINE_RADIO_CARD
	iftrue UnknownScript_0x5ce2d
	writetext UnknownText_0x5d12d
	yesorno
	iffalse UnknownScript_0x5ce4b
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
	iffalse UnknownScript_0x5ce42
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
	scall UnknownScript_0x5ce3e
	writetext UnknownText_0x5d3c0
	buttonsound
	setflag ENGINE_RADIO_CARD
UnknownScript_0x5ce2d:
	writetext UnknownText_0x5d3e5
	waitbutton
	closetext
	end

RadioCardText:
	db "Radio Card@"

UnknownScript_0x5ce3e:
	jumpstd receiveitem
	end

UnknownScript_0x5ce42:
	playsound SFX_WRONG
	writetext UnknownText_0x5d409
	waitbutton
	closetext
	end

UnknownScript_0x5ce4b:
	writetext UnknownText_0x5d443
	waitbutton
	closetext
	end

LassScript_0x5ce51:
	jumptextfaceplayer UnknownText_0x5d476

YoungsterScript_0x5ce54:
	jumptextfaceplayer UnknownText_0x5d4ac

TrainerGruntM3:
	trainer EVENT_BEAT_ROCKET_GRUNTM_3, GRUNTM, 3, GruntM3SeenText, GruntM3BeatenText, 0, GruntM3Script

GruntM3Script:
	end_if_just_battled
	opentext
	writetext UnknownText_0x5d5a2
	waitbutton
	closetext
	end

MapRadioTower1FSignpost0Script:
	jumptext UnknownText_0x5d5e7

MapRadioTower1FSignpost1Script:
	jumptext UnknownText_0x5d631

MovementData_0x5ce71:
	step_right
	turn_head_up
	step_end

MovementData_0x5ce74:
	step_left
	turn_head_up
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

	para "I'm Felicity,"
	line "your attendant"
	cont "today."

	para "Want me to check"
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
	text $56
	line $56
	done

UnknownText_0x5cf7e:
	text "Please come back"
	line "next week for the"
	cont "next Lucky Number."
	done

UnknownText_0x5cfb5:
	text "Wow! You have a"
	line "perfect match of"
	cont "all five numbers!"

	para "We have a grand"
	line "prize winner!"

	para "You have won a"
	line "Master Ball!"
	done

UnknownText_0x5d023:
	text "Hey! You've"
	line "matched the last"
	cont "three numbers!"

	para "You've won second"
	line "prize, an Exp."
	cont "Share!"
	done

UnknownText_0x5d076:
	text "Ooh, you've"
	line "matched the last"
	cont "two numbers."

	para "You've won third"
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

	para "Is this statement"
	line "correct?"

	para "You can't buy any"
	line "Berries at a Mart."
	done

UnknownText_0x5d282:
	text "Bull's-eye!"
	line "Question 3:"

	para "Does HM01 contain"
	line "the move Flash?"
	done

UnknownText_0x5d2bc:
	text "So far so good!"
	line "Question 4:"

	para "Is Falkner the"
	line "Violet Gym Leader"

	para "who uses bird"
	line "#mon?"
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

UnknownText_0x5d5a2:
	text "You're too strong."

	para "Our plan could be"
	line "ruined. I must"
	cont "warn the others…"
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

RadioTower1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $2, 11, GOLDENROD_CITY
	warp_def $7, $3, 11, GOLDENROD_CITY
	warp_def $0, $f, 2, RADIO_TOWER_2F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 0, 3, SIGNPOST_READ, MapRadioTower1FSignpost0Script
	signpost 0, 13, SIGNPOST_READ, MapRadioTower1FSignpost1Script

.PersonEvents:
	db 6
	person_event SPRITE_RECEPTIONIST, 6, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ReceptionistScript_0x5cd29, -1
	person_event SPRITE_LASS, 4, 16, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LassScript_0x5ce51, EVENT_GOLDENROD_CITY_CIVILIANS
	person_event SPRITE_YOUNGSTER, 4, 15, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x5ce54, EVENT_GOLDENROD_CITY_CIVILIANS
	person_event SPRITE_ROCKET, 1, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM3, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_RECEPTIONIST, 6, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ReceptionistScript_0x5cd3d, EVENT_GOLDENROD_CITY_CIVILIANS
	person_event SPRITE_COOLTRAINER_F, 6, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x5cdd5, EVENT_GOLDENROD_CITY_CIVILIANS
