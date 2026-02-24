GoldenrodUndergroundWarehouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, GoldenrodUndergroundWarehouseResetSwitches

	def_warp_events
	warp_event  2, 12, GOLDENROD_UNDERGROUND_SWITCH_ROOM, 2
	warp_event  3, 12, GOLDENROD_UNDERGROUND_SWITCH_ROOM, 3
	warp_event 17,  2, GOLDENROD_DEPT_STORE_B1F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  8, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM24, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  8, 15, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM14, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 14,  3, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerGruntM15, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 12,  8, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodUndergroundWarehouseDirectorScript, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	itemball_event 18, 15, MAX_ETHER, 1, EVENT_GOLDENROD_UNDERGROUND_WAREHOUSE_MAX_ETHER
	tmhmball_event 13,  9, TM_X_SCISSOR, EVENT_GOLDENROD_UNDERGROUND_WAREHOUSE_TM_X_SCISSOR
	itemball_event  2,  1, ULTRA_BALL, 1, EVENT_GOLDENROD_UNDERGROUND_WAREHOUSE_ULTRA_BALL

GoldenrodUndergroundWarehouseResetSwitches:
	clearevent EVENT_SWITCH_1
	clearevent EVENT_SWITCH_2
	clearevent EVENT_SWITCH_3
	clearevent EVENT_EMERGENCY_SWITCH
	clearevent EVENT_DOOR_1_OPEN
	clearevent EVENT_DOOR_2_OPEN
	clearevent EVENT_DOOR_3_OPEN
	clearevent EVENT_DOOR_4_OPEN
	clearevent EVENT_DOOR_5_OPEN
	clearevent EVENT_DOOR_6_OPEN
	clearevent EVENT_DOOR_7_OPEN
	clearevent EVENT_DOOR_8_OPEN
	clearevent EVENT_DOOR_9_OPEN
	clearevent EVENT_DOOR_10_OPEN
	clearevent EVENT_DOOR_11_OPEN
	setval $0
	writemem wUndergroundSwitchPositions
	endcallback

GenericTrainerGruntM24:
	generictrainer GRUNTM, 24, EVENT_BEAT_ROCKET_GRUNTM_24, GruntM24SeenText, GruntM24BeatenText

	text "Team Rocket will"
	line "keep going, wait-"
	cont "ing for the return"
	cont "of Giovanni."

	para "We'll do whatever"
	line "it takes."
	done

GenericTrainerGruntM14:
	generictrainer GRUNTM, 14, EVENT_BEAT_ROCKET_GRUNTM_14, GruntM14SeenText, GruntM14BeatenText

	text "I lost…"

	para "Please forgive me,"
	line "Giovanni!"
	done

GenericTrainerGruntM15:
	generictrainer GRUNTM, 15, EVENT_BEAT_ROCKET_GRUNTM_15, GruntM15SeenText, GruntM15BeatenText

	text "Hyuck-hyuck-hyuck!"
	line "That was a blast!"
	cont "I'll remember you!"
	done

GoldenrodUndergroundWarehouseDirectorScript:
	checkevent EVENT_RECEIVED_CARD_KEY
	iftrue_jumptextfaceplayer DirectorAfterText
	faceplayer
	opentext
	writetext DirectorIntroText
	promptbutton
	verbosegivekeyitem CARD_KEY
	setevent EVENT_RECEIVED_CARD_KEY
	setevent EVENT_GOLDENROD_DEPT_STORE_B1F_LAYOUT_1
	clearevent EVENT_GOLDENROD_DEPT_STORE_B1F_LAYOUT_2
	clearevent EVENT_GOLDENROD_DEPT_STORE_B1F_LAYOUT_3
	writetext DirectorCardKeyText
	promptbutton
	jumpopenedtext DirectorAfterText

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

DirectorIntroText:
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

DirectorCardKeyText:
	text "Director: Use that"
	line "to open the shut-"
	cont "ters on 3F."
	done

DirectorAfterText:
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
