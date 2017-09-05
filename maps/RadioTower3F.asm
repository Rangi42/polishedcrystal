RadioTower3F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, CardKeyShutterCallback

RadioTower3F_MapEventHeader:

.Warps: db 3
	warp_def 0, 0, 1, RADIO_TOWER_2F
	warp_def 0, 7, 2, RADIO_TOWER_4F
	warp_def 0, 17, 4, RADIO_TOWER_4F

.XYTriggers: db 0

.Signposts: db 3
	signpost 0, 3, SIGNPOST_JUMPTEXT, UnknownText_0x5ead6
	signpost 0, 9, SIGNPOST_JUMPTEXT, UnknownText_0x5eae4
	signpost 2, 14, SIGNPOST_UP, MapRadioTower3FSignpost2Script

.PersonEvents: db 7
	person_event SPRITE_SUPER_NERD, 4, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5e621, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	person_event SPRITE_GYM_GUY, 4, 3, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GymGuyScript_0x5e556, -1
	person_event SPRITE_COOLTRAINER_F, 3, 11, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x5e56a, -1
	person_event SPRITE_ROCKET, 1, 5, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 2, TrainerGruntM7, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 2, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM8, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 6, 16, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM9, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_SCIENTIST, 6, 9, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerRocketScientistMarc, EVENT_RADIO_TOWER_ROCKET_TAKEOVER

CardKeyShutterCallback:
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue .Change
	return

.Change:
	changeblock 14, 2, $2a
	changeblock 14, 4, $1
	return

GymGuyScript_0x5e556:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue_jumptextfaceplayer UnknownText_0x5e6eb
	jumptextfaceplayer UnknownText_0x5e682

CooltrainerFScript_0x5e56a:
	faceplayer
	opentext
	checkevent EVENT_GOT_HEAT_ROCK_FROM_RADIO_TOWER
	iftrue UnknownScript_0x5e59d
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue UnknownScript_0x5e58a
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue UnknownScript_0x5e584
	jumpopenedtext UnknownText_0x5e754

UnknownScript_0x5e584:
	jumpopenedtext UnknownText_0x5e7cb

UnknownScript_0x5e58a:
	writetext UnknownText_0x5e7e2
	buttonsound
	verbosegiveitem HEAT_ROCK
	writetext UnknownText_0x5e821
	waitbutton
	closetext
	setevent EVENT_GOT_HEAT_ROCK_FROM_RADIO_TOWER
	end

UnknownScript_0x5e59d:
	jumpopenedtext UnknownText_0x5e85c

TrainerGruntM7:
	trainer EVENT_BEAT_ROCKET_GRUNTM_7, GRUNTM, 7, GruntM7SeenText, GruntM7BeatenText, 0, GruntM7Script

GruntM7Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5e8d0

TrainerGruntM8:
	trainer EVENT_BEAT_ROCKET_GRUNTM_8, GRUNTM, 8, GruntM8SeenText, GruntM8BeatenText, 0, GruntM8Script

GruntM8Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5e944

TrainerGruntM9:
	trainer EVENT_BEAT_ROCKET_GRUNTM_9, GRUNTM, 9, GruntM9SeenText, GruntM9BeatenText, 0, GruntM9Script

GruntM9Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5e9d0

TrainerRocketScientistMarc:
	trainer EVENT_BEAT_ROCKET_SCIENTIST_MARC, ROCKET_SCIENTIST, MARC, RocketScientistMarcSeenText, RocketScientistMarcBeatenText, 0, RocketScientistMarcScript

RocketScientistMarcScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5ea61

MapRadioTower3FSignpost2Script::
	opentext
	writetext UnknownText_0x5eaa4
	waitbutton
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue UnknownScript_0x5e603
	checkitem CARD_KEY
	iftrue UnknownScript_0x5e605
UnknownScript_0x5e603:
	endtext

UnknownScript_0x5e605:
	writetext UnknownText_0x5eabc
	waitbutton
	setevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	playsound SFX_ENTER_DOOR
	changeblock 14, 2, $2a
	changeblock 14, 4, $1
	reloadmappart
	closetext
	waitsfx
	end

UnknownText_0x5e621:
	text "We have recordings"
	line "of the cries of"

	para "all #mon that"
	line "have been found."

	para "We must have about"
	line "200 kinds."
	done

UnknownText_0x5e682:
	text "To trainers, #-"
	line "mon are their"
	cont "beloved partners."

	para "It's terrible how"
	line "Team Rocket is"

	para "trying to control"
	line "#mon."
	done

UnknownText_0x5e6eb:
	text "We run 24 hours a"
	line "day to broadcast"

	para "entertaining pro-"
	line "grams."

	para "I'll do my best to"
	line "run around the"
	cont "clock too!"
	done

UnknownText_0x5e754:
	text "The Team Rocket"
	line "boss has locked"
	cont "himself in."

	para "But the Director"
	line "can open it."

	para "He's up on the"
	line "fifth floor."

	para "Please save him!"
	done

UnknownText_0x5e7cb:
	text "Is the Director"
	line "safe?"
	done

UnknownText_0x5e7e2:
	text "Thank you!"
	line "You're my hero!"

	para "This is a token of"
	line "my appreciation."
	done

UnknownText_0x5e821:
	text "It's a Heat Rock."
	line "It makes the move"
	cont "Sunny Day last"
	cont "longer."
	done

UnknownText_0x5e85c:
	text "You were simply"
	line "marvelous!"
	done

GruntM7SeenText:
	text "I've been given"
	line "strict orders."

	para "I'm to crush any-"
	line "one who challenges"
	cont "Team Rocket!"
	done

GruntM7BeatenText:
	text "What?!"
	done

UnknownText_0x5e8d0:
	text "I failed in my"
	line "duties…"

	para "I'll be docked pay"
	line "for this…"
	done

GruntM8SeenText:
	text "It feels great"
	line "ordering #mon"
	cont "to commit crimes."
	done

GruntM8BeatenText:
	text "You're kidding!"
	done

UnknownText_0x5e944:
	text "I feel lousy over"
	line "losing!"

	para "Darn it! I hate"
	line "useless #mon!"
	done

GruntM9SeenText:
	text "Why did the shut-"
	line "ter open? Did you"

	para "have something to"
	line "do with this?"
	done

GruntM9BeatenText:
	text "I'm done for!"
	done

UnknownText_0x5e9d0:
	text "What?! You made it"
	line "past our men in"
	cont "the Underground?"

	para "How could you?"
	done

RocketScientistMarcSeenText:
	text "An unknown child"
	line "wandering here?"

	para "Who are you?"
	done

RocketScientistMarcBeatenText:
	text "Tch! I took you"
	line "too lightly!"
	done

UnknownText_0x5ea61:
	text "Bwahahaha…"

	para "I can transmit as"
	line "strong a signal as"
	cont "I need from here."
	done

UnknownText_0x5eaa4:
	text "It's the Card Key"
	line "slot."
	done

UnknownText_0x5eabc:
	text "<PLAYER> inserted"
	line "the Card Key."
	done

UnknownText_0x5ead6:
	text "3F Personnel"
	done

UnknownText_0x5eae4:
	text "#mon Music with"
	line "Host DJ Ben"
	done
