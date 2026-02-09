OlivinePort_MapScriptHeader:
	def_scene_scripts
	scene_script OlivinePortAskEnterShipScene, SCENE_OLIVINEPORT_ASK_ENTER_SHIP
	scene_script OlivinePortLeaveShipScene, SCENE_OLIVINEPORT_LEAVE_SHIP

	def_callbacks

	def_warp_events
	warp_event 14,  4, OLIVINE_CITY, 9
	warp_event 15,  4, OLIVINE_CITY, 10
	warp_event  7, 15, FAST_SHIP_1F, 1

	def_coord_events
	coord_event  7,  7, SCENE_OLIVINEPORT_ASK_ENTER_SHIP, OlivinePortWalkUpToShipScript

	def_bg_events
	bg_event  1, 14, BGEVENT_ITEM + PROTEIN, EVENT_OLIVINE_PORT_HIDDEN_PROTEIN

	def_object_events
	object_event  7, 15, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortSailorAtGangwayScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	object_event  7,  7, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivinePortSailorBeforeHOFText, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	object_event  4,  6, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OlivinePortFishingGuru1Script, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	object_event 13,  6, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, OlivinePortFishingGuru2Script, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	object_event  6,  7, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortSailorAfterHOFScript, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	object_event  4,  7, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortYoungsterScript, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	object_event 11,  7, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortCooltrainerFScript, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	keyitemball_event 16, 14, GO_GOGGLES, EVENT_OLIVINE_PORT_GO_GOGGLES

	object_const_def
	const OLIVINEPORT_SAILOR1
	const OLIVINEPORT_SAILOR3

OlivinePortLeaveShipScene:
	sdefer OlivinePortLeaveShipScript
OlivinePortAskEnterShipScene:
	end

OlivinePortLeaveShipScript:
	applyonemovement PLAYER, step_up
	appear OLIVINEPORT_SAILOR1
	setscene SCENE_OLIVINEPORT_ASK_ENTER_SHIP
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	blackoutmod OLIVINE_CITY
	end

OlivinePortSailorAtGangwayScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftruefwd OlivinePortAlreadyRodeScript
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
	iffalsefwd .FirstTime
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
.FirstTime:
	clearevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	appear OLIVINEPORT_SAILOR1
	setmapscene FAST_SHIP_1F, SCENE_FASTSHIP1F_ENTER_SHIP
	warp FAST_SHIP_1F, 25, 1
	end

OlivinePortAlreadyRodeScript:
	jumpopenedtext OlivinePortCantBoardText

OlivinePortWalkUpToShipScript:
	turnobject OLIVINEPORT_SAILOR3, RIGHT
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftruefwd .skip
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftruefwd .skip
	turnobject PLAYER, LEFT
	opentext
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iffalsefwd .FirstTime
	readvar VAR_WEEKDAY
	ifequalfwd SUNDAY, .NextShipMonday
	ifequalfwd SATURDAY, .NextShipMonday
	ifequalfwd TUESDAY, .NextShipFriday
	ifequalfwd WEDNESDAY, .NextShipFriday
	ifequalfwd THURSDAY, .NextShipFriday
.FirstTime:
	writetext OlivinePortAskBoardText
	yesorno
	iffalsefwd OlivinePortNotRidingMoveAwayScript
	writetext OlivinePortAskTicketText
	promptbutton
	checkkeyitem S_S_TICKET
	iffalsefwd .NoTicket
	writetext OlivinePortFlashTicketText
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	applymovement PLAYER, OlivinePortApproachFastShipFirstTimeMovement
	sjump OlivinePortSailorAtGangwayScript

.NoTicket:
	writetext OlivinePortNoTicketText
	waitbutton
	closetext
	applymovement PLAYER, OlivinePortCannotEnterFastShipMovement
	end

.NextShipMonday:
	writetext OlivinePortMondayShipText
	waitbutton
	closetext
	applymovement PLAYER, OlivinePortCannotEnterFastShipMovement
	end

.NextShipFriday:
	writetext OlivinePortFridayShipText
	waitbutton
	closetext
	applymovement PLAYER, OlivinePortCannotEnterFastShipMovement
	end

.skip:
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
	iffalsefwd .FirstTime
	readvar VAR_WEEKDAY
	ifequalfwd SUNDAY, .NextShipMonday
	ifequalfwd SATURDAY, .NextShipMonday
	ifequalfwd TUESDAY, .NextShipFriday
	ifequalfwd WEDNESDAY, .NextShipFriday
	ifequalfwd THURSDAY, .NextShipFriday
.FirstTime:
	writetext OlivinePortAskBoardText
	yesorno
	iffalse OlivinePortNotRidingScript
	writetext OlivinePortAskTicketText
	promptbutton
	checkkeyitem S_S_TICKET
	iffalsefwd .NoTicket
	writetext OlivinePortFlashTicketText
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	readvar VAR_FACING
	ifequalfwd RIGHT, .Right
	applymovement PLAYER, OlivinePortApproachFastShipAfterHOFMovement
	sjump OlivinePortSailorAtGangwayScript

.Right:
	applymovement PLAYER, OlivinePortApproachFastShipAfterHOFRightMovement
	sjump OlivinePortSailorAtGangwayScript

.NoTicket:
	jumpopenedtext OlivinePortNoTicketText

.NextShipMonday:
	jumpopenedtext OlivinePortMondayShipText

.NextShipFriday:
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
