VermilionPort_MapScriptHeader:
	def_scene_scripts
	scene_script VermilionPortTrigger0
	scene_script VermilionPortTrigger1

	def_callbacks

	def_warp_events
	warp_event  8,  4, VERMILION_CITY, 8
	warp_event  7, 17, FAST_SHIP_1F, 1
	warp_event  9,  4, VERMILION_CITY, 9

	def_coord_events
	coord_event  7, 11, 0, VermilionPortWalkUpToShipScript

	def_bg_events
	bg_event 27, 13, BGEVENT_ITEM + IRON, EVENT_VERMILION_PORT_HIDDEN_IRON

	def_object_events
	object_event  7, 17, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortSailorAtGangwayScript, EVENT_VERMILION_PORT_SAILOR_AT_GANGWAY
	object_event  6, 11, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortSailorScript, -1
	object_event 11, 11, SPRITE_POKEMANIAC, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionPortSuperNerdText, -1

	object_const_def
	const VERMILIONPORT_SAILOR1
	const VERMILIONPORT_SAILOR2

VermilionPortTrigger1:
	sdefer UnknownScript_0x74da6
VermilionPortTrigger0:
	end

UnknownScript_0x74da6:
	applyonemovement PLAYER, step_up
	appear VERMILIONPORT_SAILOR1
	setscene $0
	setevent EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_1
	setevent EVENT_FAST_SHIP_CABINS_SE_SSE_GENTLEMAN
	setevent EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	clearevent EVENT_OLIVINE_PORT_PASSAGE_POKEFAN_M
	setevent EVENT_FAST_SHIP_FIRST_TIME
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	blackoutmod VERMILION_CITY
	end

VermilionPortSailorAtGangwayScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue VermilionPortAlreadyRodeScript
	writetext VermilionPortDepartingText
	waitbutton
	closetext
	turnobject VERMILIONPORT_SAILOR1, DOWN
	pause 10
	playsound SFX_EXIT_BUILDING
	disappear VERMILIONPORT_SAILOR1
	waitsfx
	applyonemovement PLAYER, step_down
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	setevent EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	clearevent EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	clearevent EVENT_BEAT_POKEMANIAC_ETHAN
	clearevent EVENT_BEAT_BURGLAR_COREY
	clearevent EVENT_BEAT_BUG_CATCHER_KEN
	clearevent EVENT_BEAT_GUITARISTM_CLYDE
	clearevent EVENT_BEAT_POKEFANM_JEREMY
	clearevent EVENT_BEAT_POKEFANF_GEORGIA
	clearevent EVENT_BEAT_SAILOR_KENNETH
	clearevent EVENT_BEAT_TEACHER_SHIRLEY
	clearevent EVENT_BEAT_SCHOOLBOY_NATE
	clearevent EVENT_BEAT_SCHOOLBOY_RICKY
	setevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	appear VERMILIONPORT_SAILOR1
	setmapscene FAST_SHIP_1F, $1
	warp FAST_SHIP_1F, 25, 1
	end

VermilionPortAlreadyRodeScript:
	jumpopenedtext VermilionPortCantBoardText

VermilionPortWalkUpToShipScript:
	turnobject VERMILIONPORT_SAILOR2, RIGHT
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue UnknownScript_0x74e86
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue UnknownScript_0x74e86
	turnobject PLAYER, LEFT
	opentext
	readvar VAR_WEEKDAY
	ifequal MONDAY, UnknownScript_0x74e72
	ifequal TUESDAY, UnknownScript_0x74e72
	ifequal THURSDAY, UnknownScript_0x74e7c
	ifequal FRIDAY, UnknownScript_0x74e7c
	ifequal SATURDAY, UnknownScript_0x74e7c
	writetext VermilionPortAskBoardingText
	yesorno
	iffalse VermilionPortNotRidingMoveAwayScript
	writetext VermilionPortAskTicketText
	promptbutton
	checkkeyitem S_S_TICKET
	iffalse UnknownScript_0x74e68
	writetext VermilionPortSSTicketText
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	applymovement PLAYER, VermilionPortApproachFastShipMovement
	sjump VermilionPortSailorAtGangwayScript

UnknownScript_0x74e68:
	writetext VermilionPortNoTicketText
	waitbutton
	closetext
	applymovement PLAYER, VermilionPortCannotEnterFastShipMovement
	end

UnknownScript_0x74e72:
	writetext VermilionPortSailMondayText
	waitbutton
	closetext
	applymovement PLAYER, VermilionPortCannotEnterFastShipMovement
	end

UnknownScript_0x74e7c:
	writetext VermilionPortSailSundayText
	waitbutton
	closetext
	applymovement PLAYER, VermilionPortCannotEnterFastShipMovement
	end

UnknownScript_0x74e86:
	end

VermilionPortNotRidingScript:
	jumpopenedtext VermilionPortComeAgainText

VermilionPortNotRidingMoveAwayScript:
	writetext VermilionPortComeAgainText
	waitbutton
	closetext
	applymovement PLAYER, VermilionPortCannotEnterFastShipMovement
	end

VermilionPortSailorScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue VermilionPortAlreadyRodeScript
	readvar VAR_WEEKDAY
	ifequal MONDAY, UnknownScript_0x74eda
	ifequal TUESDAY, UnknownScript_0x74eda
	ifequal THURSDAY, UnknownScript_0x74ee0
	ifequal FRIDAY, UnknownScript_0x74ee0
	ifequal SATURDAY, UnknownScript_0x74ee0
	writetext VermilionPortAskBoardingText
	yesorno
	iffalse VermilionPortNotRidingScript
	writetext VermilionPortAskTicketText
	promptbutton
	checkkeyitem S_S_TICKET
	iffalse UnknownScript_0x74ed4
	writetext VermilionPortSSTicketText
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	applymovement PLAYER, VermilionPortApproachFastShipRightMovement
	sjump VermilionPortSailorAtGangwayScript

UnknownScript_0x74ed4:
	jumpopenedtext VermilionPortNoTicketText

UnknownScript_0x74eda:
	jumpopenedtext VermilionPortSailMondayText

UnknownScript_0x74ee0:
	jumpopenedtext VermilionPortSailSundayText

VermilionPortCannotEnterFastShipMovement:
	step_right
	turn_head_left
	step_end

VermilionPortApproachFastShipMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

VermilionPortApproachFastShipRightMovement:
	step_right
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

VermilionPortDepartingText:
	text "We're departing"
	line "soon. Please get"
	cont "on board."
	done

VermilionPortCantBoardText:
	text "Sorry. You can't"
	line "board now."
	done

VermilionPortAskBoardingText:
	text "Welcome to Fast"
	line "Ship S.S.Aqua."

	para "Will you be board-"
	line "ing today?"
	done

VermilionPortAskTicketText:
	text "May I see your"
	line "S.S.Ticket?"
	done

VermilionPortComeAgainText:
	text "We hope to see you"
	line "again!"
	done

VermilionPortSSTicketText:
	text "<PLAYER> flashed"
	line "the S.S.Ticket."

	para "That's it."
	line "Thank you!"
	done

VermilionPortNoTicketText:
	text "<PLAYER> tried to"
	line "show the S.S."
	cont "Ticket…"

	para "…But no Ticket!"

	para "Sorry!"
	line "You may board only"

	para "if you have an"
	line "S.S.Ticket."
	done

VermilionPortSailMondayText:
	text "The Fast Ship will"
	line "sail on Wednesday."
	done

VermilionPortSailSundayText:
	text "The Fast Ship will"
	line "sail next Sunday."
	done

VermilionPortSuperNerdText:
	text "You came from"
	line "Johto?"

	para "I hear many rare"
	line "#mon live over"
	cont "there."
	done
