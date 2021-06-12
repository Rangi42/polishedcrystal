ShamoutiHotelRestaurant_MapScriptHeader:
	def_scene_scripts
	scene_script ShamoutiHotelRestaurantTrigger0

	def_callbacks

	def_warp_events
	warp_event 16,  7, SHAMOUTI_HOTEL_1F, 4
	warp_event 17,  7, SHAMOUTI_HOTEL_1F, 4

	def_coord_events
	coord_event 16,  6, 1, ShamoutiHotelRestaurantLeavingTrigger1
	coord_event 16,  7, 1, ShamoutiHotelRestaurantLeavingTrigger2

	def_bg_events

	def_object_events
	object_event 16,  4, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotelRestaurantReceptionistText, -1

	object_const_def
	const SHAMOUTIHOTELRESTAURANT_RECEPTIONIST

ShamoutiHotelRestaurantTrigger0:
	sdefer ShamoutiHotelRestaurantChallengeScript
	end

ShamoutiHotelRestaurantChallengeScript:
	applyonemovement PLAYER, step_up
	opentext
	checkflag ENGINE_SHAMOUTI_RESTAURANT_CHALLENGE
	iftrue .AlreadyAte
	writetext .GreetingText
	special PlaceMoneyTopRight
	yesorno
	iffalse .NeverMind
	checkmoney $0, 5000
	ifequal $2, .NotEnoughMoney
	setflag ENGINE_SHAMOUTI_RESTAURANT_CHALLENGE
	waitsfx
	playsound SFX_TRANSACTION
	takemoney $0, 5000
	special PlaceMoneyTopRight
	writetext ShamoutiHotelRestaurantReceptionistText
	waitbutton
	closetext
	applyonemovement PLAYER, step_left
	setscene $1
	end

.AlreadyAte:
	writetext .AlreadyAteText
	sjump ShamoutiHotelRestaurantLeaveScript

.NeverMind:
	writetext .NeverMindText
	sjump ShamoutiHotelRestaurantLeaveScript

.NotEnoughMoney:
	writetext .NotEnoughMoneyText
	sjump ShamoutiHotelRestaurantLeaveScript

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
	applyonemovement PLAYER, step_up
ShamoutiHotelRestaurantLeavingTrigger1:
	turnobject PLAYER, UP
	turnobject SHAMOUTIHOTELRESTAURANT_RECEPTIONIST, DOWN
	opentext
	writetext .LeavingText
	yesorno
	iffalse .Staying
	writetext .GoodbyeText
	sjump ShamoutiHotelRestaurantLeaveScript

.Staying:
	writetext ShamoutiHotelRestaurantReceptionistText
	waitbutton
	closetext
	applyonemovement PLAYER, step_left
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
	applyonemovement PLAYER, step_down
	special FadeOutPalettes
	playsound SFX_ENTER_DOOR
	waitsfx
	warp SHAMOUTI_HOTEL_1F, 14, 0
	end

ShamoutiHotelRestaurantReceptionistText:
	text "Please enjoy a"
	line "meal and a battle."
	done
