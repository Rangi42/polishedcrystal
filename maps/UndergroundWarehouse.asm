UndergroundWarehouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, UndergroundWarehouseResetSwitches

UndergroundWarehouse_MapEventHeader:

.Warps: db 3
	warp_def 12, 2, 2, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES
	warp_def 12, 3, 3, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES
	warp_def 2, 17, 1, GOLDENROD_DEPT_STORE_B1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 7
	person_event SPRITE_ROCKET, 8, 9, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM24, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 15, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM14, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 3, 14, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerGruntM15, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_GENTLEMAN, 8, 12, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GentlemanScript_0x7d9bf, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	itemball_event 15, 18, MAX_ETHER, 1, EVENT_UNDERGROUND_WAREHOUSE_MAX_ETHER
	tmhmball_event 9, 13, TM_X_SCISSOR, EVENT_UNDERGROUND_WAREHOUSE_TM_X_SCISSOR
	itemball_event 1, 2, ULTRA_BALL, 1, EVENT_UNDERGROUND_WAREHOUSE_ULTRA_BALL

UndergroundWarehouseResetSwitches:
	clearevent EVENT_SWITCH_1
	clearevent EVENT_SWITCH_2
	clearevent EVENT_SWITCH_3
	clearevent EVENT_EMERGENCY_SWITCH
	clearevent EVENT_SWITCH_4
	clearevent EVENT_SWITCH_5
	clearevent EVENT_SWITCH_6
	clearevent EVENT_SWITCH_7
	clearevent EVENT_SWITCH_8
	clearevent EVENT_SWITCH_9
	clearevent EVENT_SWITCH_10
	clearevent EVENT_SWITCH_11
	clearevent EVENT_SWITCH_12
	clearevent EVENT_SWITCH_13
	clearevent EVENT_SWITCH_14
	writebyte $0
	copyvartobyte UndergroundSwitchPositions
	return

TrainerGruntM24:
	trainer EVENT_BEAT_ROCKET_GRUNTM_24, GRUNTM, 24, GruntM24SeenText, GruntM24BeatenText, 0, GruntM24Script

GruntM24Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7da48

TrainerGruntM14:
	trainer EVENT_BEAT_ROCKET_GRUNTM_14, GRUNTM, 14, GruntM14SeenText, GruntM14BeatenText, 0, GruntM14Script

GruntM14Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7db01

TrainerGruntM15:
	trainer EVENT_BEAT_ROCKET_GRUNTM_15, GRUNTM, 15, GruntM15SeenText, GruntM15BeatenText, 0, GruntM15Script

GruntM15Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7db8e

GentlemanScript_0x7d9bf:
	checkevent EVENT_RECEIVED_CARD_KEY
	iftrue_jumptextfaceplayer UnknownText_0x7dc8d
	faceplayer
	opentext
	writetext UnknownText_0x7dbc6
	buttonsound
	verbosegiveitem CARD_KEY
	setevent EVENT_RECEIVED_CARD_KEY
	setevent EVENT_WAREHOUSE_LAYOUT_1
	clearevent EVENT_WAREHOUSE_LAYOUT_2
	clearevent EVENT_WAREHOUSE_LAYOUT_3
	writetext UnknownText_0x7dc5b
	buttonsound
	jumpopenedtext UnknownText_0x7dc8d

GruntM24SeenText:
	text "How did you get"
	line "this far?"

	para "I guess it can't"
	line "be helped. I'll"
	cont "dispose of you."
	done

GruntM24BeatenText:
	text "I got disposed of…"
	done

UnknownText_0x7da48:
	text "Team Rocket will"
	line "keep going, wait-"
	cont "ing for the return"
	cont "of Giovanni."

	para "We'll do whatever"
	line "it takes."
	done

GruntM14SeenText:
	text "You're not going"
	line "any farther!"

	para "I don't show mercy"
	line "to my enemies, not"
	cont "even brats!"
	done

GruntM14BeatenText:
	text "Blast it!"
	done

UnknownText_0x7db01:
	text "I lost…"

	para "Please forgive me,"
	line "Giovanni!"
	done

GruntM15SeenText:
	text "Hyuck-hyuck-hyuck!"
	line "I remember you!"

	para "You got me good"
	line "at our hideout!"
	done

GruntM15BeatenText:
	text "Hyuck-hyuck-hyuck!"
	line "So, that's how?"
	done

UnknownText_0x7db8e:
	text "Hyuck-hyuck-hyuck!"
	line "That was a blast!"
	cont "I'll remember you!"
	done

UnknownText_0x7dbc6:
	text "Director: Who?"
	line "What? You came to"
	cont "rescue me?"

	para "Thank you!"

	para "The Radio Tower!"

	para "What's happening"
	line "there?"

	para "Taken over by Team"
	line "Rocket?"

	para "Here. Take this"
	line "Card Key."
	done

UnknownText_0x7dc5b:
	text "Director: Use that"
	line "to open the shut-"
	cont "ters on 3F."
	done

UnknownText_0x7dc8d:
	text "I'm begging you to"
	line "help."

	para "There's no telling"
	line "what they'll do if"

	para "they control the"
	line "transmitter."

	para "They may even be"
	line "able to control"

	para "#mon using a"
	line "special signal!"

	para "You're the only"
	line "one I can call on."

	para "Please save the"
	line "Radio Tower…"

	para "And all the #-"
	line "mon nationwide!"
	done
