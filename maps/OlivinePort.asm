OlivinePort_MapScriptHeader:
	def_scene_scripts
	scene_script OlivinePortTrigger0
	scene_script OlivinePortTrigger1

	def_callbacks

	def_warp_events
	warp_event 11,  7, OLIVINE_PORT_PASSAGE, 5
	warp_event  7, 23, FAST_SHIP_1F, 1

	def_coord_events
	coord_event  7, 15, 0, OlivinePortWalkUpToShipScript

	def_bg_events
	bg_event  1, 22, BGEVENT_ITEM + PROTEIN, EVENT_OLIVINE_PORT_HIDDEN_PROTEIN

	def_object_events
	object_event  7, 23, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortSailorAtGangwayScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	object_event  7, 15, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivinePortSailorBeforeHOFText, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	object_event  4, 14, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OlivinePortFishingGuru1Script, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	object_event 13, 14, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OlivinePortFishingGuru2Script, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	object_event  6, 15, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortSailorAfterHOFScript, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	object_event  4, 15, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortYoungsterScript, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	object_event 11, 15, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortCooltrainerFScript, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME

	object_const_def
	const OLIVINEPORT_SAILOR1
	const OLIVINEPORT_SAILOR3

OlivinePortTrigger1:
	priorityjump UnknownScript_0x748b1
OlivinePortTrigger0:
	end

UnknownScript_0x748b1:
	applyonemovement PLAYER, step_up
	appear OLIVINEPORT_SAILOR1
	setscene $0
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	blackoutmod OLIVINE_CITY
	end

OlivinePortSailorAtGangwayScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue OlivinePortAlreadyRodeScript
	writetext OlivinePortSailorGetOnBoardText
	waitbutton
	closetext
	turnobject OLIVINEPORT_SAILOR1, DOWN
	pause 10
	playsound SFX_EXIT_BUILDING
	disappear OLIVINEPORT_SAILOR1
	waitsfx
	applyonemovement PLAYER, step_down
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iffalse UnknownScript_0x7490a
	clearevent EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	setevent EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	clearevent EVENT_BEAT_COOLTRAINERM_SEAN
	clearevent EVENT_BEAT_COOLTRAINERF_CAROL
	clearevent EVENT_BEAT_GENTLEMAN_EDWARD
	clearevent EVENT_BEAT_BEAUTY_CASSIE
	clearevent EVENT_BEAT_PSYCHIC_RODNEY
	clearevent EVENT_BEAT_SUPER_NERD_SHAWN
	clearevent EVENT_BEAT_SAILOR_GARRETT
	clearevent EVENT_BEAT_FISHER_JONAH
	clearevent EVENT_BEAT_BLACKBELT_WAI
	clearevent EVENT_BEAT_RICH_BOY_WINSTON
UnknownScript_0x7490a:
	clearevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	appear OLIVINEPORT_SAILOR1
	setmapscene FAST_SHIP_1F, $1
	warp FAST_SHIP_1F, 25, 1
	end

OlivinePortAlreadyRodeScript:
	jumpopenedtext OlivinePortCantBoardText

OlivinePortWalkUpToShipScript:
	turnobject OLIVINEPORT_SAILOR3, RIGHT
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue UnknownScript_0x7498b
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue UnknownScript_0x7498b
	turnobject PLAYER, LEFT
	opentext
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iffalse UnknownScript_0x7494e
	checkcode VAR_WEEKDAY
	ifequal SUNDAY, UnknownScript_0x74977
	ifequal SATURDAY, UnknownScript_0x74977
	ifequal TUESDAY, UnknownScript_0x74981
	ifequal WEDNESDAY, UnknownScript_0x74981
	ifequal THURSDAY, UnknownScript_0x74981
UnknownScript_0x7494e:
	writetext OlivinePortAskBoardText
	yesorno
	iffalse OlivinePortNotRidingMoveAwayScript
	writetext OlivinePortAskTicketText
	buttonsound
	checkkeyitem S_S_TICKET
	iffalse UnknownScript_0x7496d
	writetext OlivinePortFlashTicketText
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	applymovement PLAYER, OlivinePortApproachFastShipFirstTimeMovement
	jump OlivinePortSailorAtGangwayScript

UnknownScript_0x7496d:
	writetext OlivinePortNoTicketText
	waitbutton
	closetext
	applymovement PLAYER, OlivinePortCannotEnterFastShipMovement
	end

UnknownScript_0x74977:
	writetext OlivinePortMondayShipText
	waitbutton
	closetext
	applymovement PLAYER, OlivinePortCannotEnterFastShipMovement
	end

UnknownScript_0x74981:
	writetext OlivinePortFridayShipText
	waitbutton
	closetext
	applymovement PLAYER, OlivinePortCannotEnterFastShipMovement
	end

UnknownScript_0x7498b:
	end

OlivinePortNotRidingScript:
	jumpopenedtext OlivinePortComeAgainText

OlivinePortNotRidingMoveAwayScript:
	writetext OlivinePortComeAgainText
	waitbutton
	closetext
	applymovement PLAYER, OlivinePortCannotEnterFastShipMovement
	end

OlivinePortSailorAfterHOFScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue OlivinePortAlreadyRodeScript
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iffalse UnknownScript_0x749c0
	checkcode VAR_WEEKDAY
	ifequal SUNDAY, UnknownScript_0x749f2
	ifequal SATURDAY, UnknownScript_0x749f2
	ifequal TUESDAY, UnknownScript_0x749f8
	ifequal WEDNESDAY, UnknownScript_0x749f8
	ifequal THURSDAY, UnknownScript_0x749f8
UnknownScript_0x749c0:
	writetext OlivinePortAskBoardText
	yesorno
	iffalse OlivinePortNotRidingScript
	writetext OlivinePortAskTicketText
	buttonsound
	checkkeyitem S_S_TICKET
	iffalse UnknownScript_0x749ec
	writetext OlivinePortFlashTicketText
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	checkcode VAR_FACING
	ifequal RIGHT, UnknownScript_0x749e5
	applymovement PLAYER, OlivinePortApproachFastShipAfterHOFMovement
	jump OlivinePortSailorAtGangwayScript

UnknownScript_0x749e5:
	applymovement PLAYER, OlivinePortApproachFastShipAfterHOFRightMovement
	jump OlivinePortSailorAtGangwayScript

UnknownScript_0x749ec:
	jumpopenedtext OlivinePortNoTicketText

UnknownScript_0x749f2:
	jumpopenedtext OlivinePortMondayShipText

UnknownScript_0x749f8:
	jumpopenedtext OlivinePortFridayShipText

OlivinePortFishingGuru1Script:
	showtextfaceplayer OlivinePortFishingGuru1Text
	turnobject LAST_TALKED, UP
	end

OlivinePortFishingGuru2Script:
	showtextfaceplayer OlivinePortFishingGuru2Text
	turnobject LAST_TALKED, UP
	end

OlivinePortYoungsterScript:
	showtextfaceplayer OlivinePortYoungsterText
	turnobject LAST_TALKED, DOWN
	end

OlivinePortCooltrainerFScript:
	showtextfaceplayer OlivinePortCooltrainerFText
	turnobject LAST_TALKED, DOWN
	end

OlivinePortCannotEnterFastShipMovement:
	step_right
	turn_head_left
	step_end

OlivinePortApproachFastShipFirstTimeMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

OlivinePortApproachFastShipAfterHOFMovement:
	step_right
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

OlivinePortApproachFastShipAfterHOFRightMovement:
	step_up
	step_right
	step_right
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

OlivinePortSailorGetOnBoardText:
	text "We're departing"
	line "soon. Please get"
	cont "on board."
	done

OlivinePortCantBoardText:
	text "Sorry. You can't"
	line "board now."
	done

OlivinePortAskBoardText:
	text "Welcome to Fast"
	line "Ship S.S.Aqua."

	para "Will you be board-"
	line "ing today?"
	done

OlivinePortAskTicketText:
	text "May I see your"
	line "S.S.Ticket?"
	done

OlivinePortComeAgainText:
	text "We hope to see you"
	line "again!"
	done

OlivinePortFlashTicketText:
	text "<PLAYER> flashed"
	line "the S.S.Ticket."

	para "That's it."
	line "Thank you!"
	done

OlivinePortNoTicketText:
	text "<PLAYER> tried to"
	line "show the S.S."
	cont "Ticket…"

	para "…But no Ticket!"

	para "Sorry!"
	line "You may board only"

	para "if you have an"
	line "S.S.Ticket."
	done

OlivinePortMondayShipText:
	text "The Fast Ship will"
	line "sail next Monday."
	done

OlivinePortFridayShipText:
	text "The Fast Ship will"
	line "sail next Friday."
	done

OlivinePortFishingGuru1Text:
	text "Shellder are easy"
	line "to catch here."

	para "They're kind of"
	line "rare elsewhere."
	done

OlivinePortFishingGuru2Text:
	text "How many Rods do"
	line "you have?"

	para "Different Rods"
	line "catch different"
	cont "#mon."
	done

OlivinePortYoungsterText:
	text "S.S.Aqua uses jets"
	line "to skim over the"
	cont "waves!"
	done

OlivinePortCooltrainerFText:
	text "There are lots of"
	line "#mon in Kanto."

	para "I wish I could go…"
	done

OlivinePortSailorBeforeHOFText:
	text "We don't want you"
	line "to fall into the"

	para "sea, so you're not"
	line "allowed in."
	done
