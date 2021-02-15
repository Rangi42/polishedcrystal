RadioTower4F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  0, RADIO_TOWER_5F, 1
	warp_event  9,  0, RADIO_TOWER_3F, 2
	warp_event 12,  0, RADIO_TOWER_5F, 2
	warp_event 17,  0, RADIO_TOWER_3F, 3

	def_coord_events

	def_bg_events
	bg_event  7,  0, BGEVENT_JUMPTEXT, RadioTower4FProductionSignText
	bg_event 15,  0, BGEVENT_JUMPTEXT, RadioTower4FStudio2SignText

	def_object_events
	object_event  5,  6, SPRITE_ROCKET, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM10, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  6,  4, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower4FFisherText, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	object_event 14,  6, SPRITE_BUENA, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower4FDJMaryScript, -1
	pokemon_event 12,  7, MEOWTH, -1, -1, PAL_NPC_RED, RadioTowerMeowthText, -1
	object_event 14,  1, SPRITE_PROTON, SPRITEMOVEDATA_STANDING_LEFT, 0, 2, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerProton1, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 12,  4, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerGruntF4, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  4,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerRocketScientistRich, EVENT_RADIO_TOWER_ROCKET_TAKEOVER

	object_const_def
	const RADIOTOWER4F_ROCKET

RadioTower4FDJMaryScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_PINK_BOW_FROM_MARY
	iftrue UnknownScript_0x5ebac
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue UnknownScript_0x5eb99
	jumpopenedtext RadioTower4FDJMaryText

UnknownScript_0x5eb99:
	writetext RadioTower4FDJMaryText_ClearedRockets
	buttonsound
	verbosegiveitem PINK_BOW
	iffalse UnknownScript_0x5ebb0
	writetext RadioTower4FDJMaryText_GivePinkBow
	waitbutton
	closetext
	setevent EVENT_GOT_PINK_BOW_FROM_MARY
	end

UnknownScript_0x5ebac:
	writetext RadioTower4FDJMaryText_After
	waitbutton
UnknownScript_0x5ebb0:
	endtext

GenericTrainerGruntM10:
	generictrainer GRUNTM, 10, EVENT_BEAT_ROCKET_GRUNTM_10, GruntM10SeenText, GruntM10BeatenText

	text "I don't believe"
	line "it! I was beaten!"
	done

GenericTrainerProton1:
	generictrainer PROTON, PROTON1, EVENT_BEAT_PROTON_1, Proton1SeenText, Proton1BeatenText

	text "You've earned my"
	line "respect, so here's"
	cont "some advice."

	para "It's not too late."
	line "You can still turn"
	cont "back."
	done

GenericTrainerGruntF4:
	generictrainer GRUNTF, 4, EVENT_BEAT_ROCKET_GRUNTF_4, GruntF4SeenText, GruntF4BeatenText

	text "I love my"
	line "beautiful self!"

	para "Who cares about"
	line "#mon?"
	done

GenericTrainerRocketScientistRich:
	generictrainer ROCKET_SCIENTIST, RICH, EVENT_BEAT_ROCKET_SCIENTIST_RICH, RocketScientistRichSeenText, RocketScientistRichBeatenText

	text "Do you honestly"
	line "believe you can"
	cont "stop Team Rocket?"
	done

RadioTower4FFisherText:
	text "I listened to the"
	line "radio while I was"
	cont "at the ruins."

	para "I heard a strange"
	line "broadcast there."
	done

RadioTower4FDJMaryText:
	text "Mary: Why? Why do"
	line "I have to suffer"
	cont "through this?"

	para "Meowth, help me!"
	done

RadioTower4FDJMaryText_ClearedRockets:
	text "Mary: Oh! You're"
	line "my little savior!"

	para "Will you take this"
	line "as my thanks?"
	done

RadioTower4FDJMaryText_GivePinkBow:
	text "Mary: It's just"
	line "right for #mon"

	para "that know Fairy-"
	line "type moves."
	done

RadioTower4FDJMaryText_After:
	text "Mary: Please tune"
	line "into me on Prof."

	para "Oak's #mon Talk"
	line "show."
	done

RadioTowerMeowthText:
	text "Meowth: Meowth…"
	done

GruntM10SeenText:
	text "You plan to rescue"
	line "the Director?"

	para "That won't be pos-"
	line "sible because I'm"
	cont "going to beat you!"
	done

GruntM10BeatenText:
	text "No! Unbelievable!"
	done

Proton1SeenText:
	text "Stop! I'm known as"
	line "the Team Rocket"
	cont "fortress!"

	para "You're not taking"
	line "another step!"
	done

Proton1BeatenText:
	text "The fortress came"
	line "down!"
	done

GruntF4SeenText:
	text "Don't I think"
	line "#mon are cute?"

	para "I'll think my"
	line "#mon are cute--"

	para "after they beat"
	line "yours!"
	done

GruntF4BeatenText:
	text "Oh, no! They're so"
	line "useless!"
	done

RocketScientistRichSeenText:
	text "Most excellent."

	para "This Radio Tower"
	line "will fulfill our"
	cont "grand design."
	done

RocketScientistRichBeatenText:
	text "Hmmm…"

	para "All grand plans"
	line "come with snags."
	done

RadioTower4FProductionSignText:
	text "4F Production"
	done

RadioTower4FStudio2SignText:
	text "4F Studio 2"
	done
