RadioTower4F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  0,  0, RADIO_TOWER_5F, 1
	warp_event  9,  0, RADIO_TOWER_3F, 2
	warp_event 12,  0, RADIO_TOWER_5F, 2
	warp_event 17,  0, RADIO_TOWER_3F, 3

	db 0 ; coord events

	db 2 ; bg events
	bg_event  7,  0, SIGNPOST_JUMPTEXT, UnknownText_0x5effe
	bg_event 15,  0, SIGNPOST_JUMPTEXT, UnknownText_0x5f00d

	db 7 ; object events
	object_event  5,  6, SPRITE_ROCKET, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM10, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  6,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5ec12, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	object_event 14,  6, SPRITE_BUENA, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, MaryScript_0x5eb85, -1
	object_event 12,  7, SPRITE_MEOWTH, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEMON, MEOWTH, RadioTowerMeowthText, -1
	object_event 14,  1, SPRITE_PROTON, SPRITEMOVEDATA_STANDING_LEFT, 0, 2, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerProton1, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 12,  4, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerGruntF4, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  4,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerRocketScientistRich, EVENT_RADIO_TOWER_ROCKET_TAKEOVER

	const_def 1 ; object constants
	const RADIOTOWER4F_ROCKET

MaryScript_0x5eb85:
	faceplayer
	opentext
	checkevent EVENT_GOT_PINK_BOW_FROM_MARY
	iftrue UnknownScript_0x5ebac
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue UnknownScript_0x5eb99
	jumpopenedtext UnknownText_0x5ec68

UnknownScript_0x5eb99:
	writetext UnknownText_0x5ecab
	buttonsound
	verbosegiveitem PINK_BOW
	iffalse UnknownScript_0x5ebb0
	writetext UnknownText_0x5ecef
	waitbutton
	closetext
	setevent EVENT_GOT_PINK_BOW_FROM_MARY
	end

UnknownScript_0x5ebac:
	writetext UnknownText_0x5ed2c
	waitbutton
UnknownScript_0x5ebb0:
	endtext

TrainerGruntM10:
	trainer GRUNTM, 10, EVENT_BEAT_ROCKET_GRUNTM_10, GruntM10SeenText, GruntM10BeatenText, 0, GruntM10Script

GruntM10Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5ede2

TrainerProton1:
	trainer PROTON, PROTON1, EVENT_BEAT_PROTON_1, Proton1SeenText, Proton1BeatenText, 0, Proton1Script

Proton1Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5ee69

TrainerGruntF4:
	trainer GRUNTF, 4, EVENT_BEAT_ROCKET_GRUNTF_4, GruntF4SeenText, GruntF4BeatenText, 0, GruntF4Script

GruntF4Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5ef31

TrainerRocketScientistRich:
	trainer ROCKET_SCIENTIST, RICH, EVENT_BEAT_ROCKET_SCIENTIST_RICH, RocketScientistRichSeenText, RocketScientistRichBeatenText, 0, RocketScientistRichScript

RocketScientistRichScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5efcb

UnknownText_0x5ec12:
	text "I listened to the"
	line "radio while I was"
	cont "at the ruins."

	para "I heard a strange"
	line "broadcast there."
	done

UnknownText_0x5ec68:
	text "Mary: Why? Why do"
	line "I have to suffer"
	cont "through this?"

	para "Meowth, help me!"
	done

UnknownText_0x5ecab:
	text "Mary: Oh! You're"
	line "my little savior!"

	para "Will you take this"
	line "as my thanks?"
	done

UnknownText_0x5ecef:
	text "Mary: It's just"
	line "right for #mon"

	para "that know Fairy-"
	line "type moves."
	done

UnknownText_0x5ed2c:
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

UnknownText_0x5ede2:
	text "I don't believe"
	line "it! I was beaten!"
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

UnknownText_0x5ee69:
	text "You've earned my"
	line "respect, so here's"
	cont "some advice."

	para "It's not too late."
	line "You can still turn"
	cont "back."
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

UnknownText_0x5ef31:
	text "I love my"
	line "beautiful self!"

	para "Who cares about"
	line "#mon?"
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

UnknownText_0x5efcb:
	text "Do you honestly"
	line "believe you can"
	cont "stop Team Rocket?"
	done

UnknownText_0x5effe:
	text "4F Production"
	done

UnknownText_0x5f00d:
	text "4F Studio 2"
	done
