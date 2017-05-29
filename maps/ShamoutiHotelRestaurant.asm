const_value set 2
	const SHAMOUTIHOTELRESTAURANT_RECEPTIONIST

ShamoutiHotelRestaurant_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 0

.Trigger0:
	priorityjump ShamoutiHotelRestaurantChallengeScript
	end

.Trigger1:
	end

ShamoutiHotelRestaurantChallengeScript:
	applymovement PLAYER, ShamoutiHotelRestaurantStepUpMovement
	opentext
	checkflag ENGINE_SHAMOUTI_RESTAURANT_CHALLENGE
	iftrue .AlreadyAte
	writetext .GreetingText
	special PlaceMoneyTopRight
	yesorno
	iffalse .NeverMind
	checkmoney $0, 5000
	if_equal $2, .NotEnoughMoney
	setflag ENGINE_SHAMOUTI_RESTAURANT_CHALLENGE
	waitsfx
	playsound SFX_TRANSACTION
	takemoney $0, 5000
	special PlaceMoneyTopRight
	writetext ShamoutiHotelRestaurantReceptionistText
	waitbutton
	closetext
	applymovement PLAYER, ShamoutiHotelRestaurantStepLeftMovement
	dotrigger $1
	end

.AlreadyAte:
	writetext .AlreadyAteText
	jump ShamoutiHotelRestaurantLeaveScript

.NeverMind:
	writetext .NeverMindText
	jump ShamoutiHotelRestaurantLeaveScript

.NotEnoughMoney:
	writetext .NotEnoughMoneyText
	jump ShamoutiHotelRestaurantLeaveScript

.GreetingText:
	text "Welcome to the"
	line "Oasis Restaurant."

	para "Here you can par-"
	line "take, not just in"

	para "food, but in #-"
	line "mon battles."

	para "Every day we have"
	line "a new menu."

	para "The fee is ¥5000."
	line "Would you like to"
	cont "enter?"
	done

.AlreadyAteText:
	text "I'm so sorry, but"
	line "you already came"
	cont "here today."

	para "Please do visit"
	line "again tomorrow."
	done

.NeverMindText:
	text "I understand."
	line "Have a nice day!"
	done

.NotEnoughMoneyText:
	text "I'm so sorry, but"
	line "you don't have"
	cont "enough money."
	done

ShamoutiHotelRestaurantLeavingTrigger2:
	applymovement PLAYER, ShamoutiHotelRestaurantStepUpMovement
ShamoutiHotelRestaurantLeavingTrigger1:
	spriteface PLAYER, UP
	spriteface SHAMOUTIHOTELRESTAURANT_RECEPTIONIST, DOWN
	opentext
	writetext .LeavingText
	yesorno
	iffalse .Staying
	writetext .GoodbyeText
	jump ShamoutiHotelRestaurantLeaveScript

.Staying:
	writetext ShamoutiHotelRestaurantReceptionistText
	waitbutton
	closetext
	applymovement PLAYER, ShamoutiHotelRestaurantStepLeftMovement
	end

.LeavingText:
	text "Are you ready to"
	line "leave?"
	done

.GoodbyeText:
	text "Thank you for"
	line "coming."

	para "Please do visit"
	line "again tomorrow."
	done

ShamoutiHotelRestaurantLeaveScript:
	waitbutton
	closetext
	applymovement PLAYER, ShamoutiHotelRestaurantStepDownMovement
	special FadeOutPalettes
	playsound SFX_ENTER_DOOR
	waitsfx
	warp SHAMOUTI_HOTEL_1F, $e, $0
	end

ShamoutiHotelRestaurantReceptionistScript:
	jumptextfaceplayer ShamoutiHotelRestaurantReceptionistText

ShamoutiHotelRestaurantReceptionistText:
	text "Please enjoy a"
	line "meal and a battle."
	done

ShamoutiHotelRestaurantStepUpMovement:
	step_up
	step_end

ShamoutiHotelRestaurantStepLeftMovement:
	step_left
	step_end

ShamoutiHotelRestaurantStepDownMovement:
	step_down
	step_end

ShamoutiHotelRestaurant_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $10, 4, SHAMOUTI_HOTEL_1F
	warp_def $7, $11, 4, SHAMOUTI_HOTEL_1F

.XYTriggers:
	db 2
	xy_trigger 1, $6, $10, $0, ShamoutiHotelRestaurantLeavingTrigger1, $0, $0
	xy_trigger 1, $7, $10, $0, ShamoutiHotelRestaurantLeavingTrigger2, $0, $0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_RECEPTIONIST, 4, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, ShamoutiHotelRestaurantReceptionistScript, -1
