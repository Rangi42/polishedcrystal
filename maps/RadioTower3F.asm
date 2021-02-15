RadioTower3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, CardKeyShutterCallback

	def_warp_events
	warp_event  0,  0, RADIO_TOWER_2F, 1
	warp_event  7,  0, RADIO_TOWER_4F, 2
	warp_event 17,  0, RADIO_TOWER_4F, 4

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_JUMPTEXT, RadioTower3FPersonnelSignText
	bg_event  9,  0, BGEVENT_JUMPTEXT, RadioTower3FPokemonMusicSignText
	bg_event 14,  2, BGEVENT_UP, MapRadioTower3FSignpost2Script

	def_object_events
	object_event  7,  4, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower3FSuperNerdText, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	object_event  3,  4, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower3FGymGuideScript, -1
	object_event 11,  3, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower3FCooltrainerFScript, -1
	object_event  5,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerGruntM7, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  6,  2, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM8, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 16,  6, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM9, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  9,  6, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerRocketScientistMarc, EVENT_RADIO_TOWER_ROCKET_TAKEOVER

CardKeyShutterCallback:
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue .Change
	return

.Change:
	changeblock 14, 2, $2a
	changeblock 14, 4, $1
	return

RadioTower3FGymGuideScript:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue_jumptextfaceplayer RadioTower3FGymGuideText
	jumptextfaceplayer RadioTower3FGymGuideText_Rockets

RadioTower3FCooltrainerFScript:
	checkevent EVENT_GOT_HEAT_ROCK_FROM_RADIO_TOWER
	iftrue_jumptextfaceplayer RadioTower3FCooltrainerFYouWereMarvelousText
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue UnknownScript_0x5e58a
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue_jumptextfaceplayer RadioTower3FCooltrainerFIsDirectorSafeText
	jumpthistextfaceplayer

	text "The Team Rocket"
	line "boss has locked"
	cont "himself in."

	para "But the Director"
	line "can open it."

	para "He's up on the"
	line "fifth floor."

	para "Please save him!"
	done

UnknownScript_0x5e58a:
	faceplayer
	opentext
	writetext RadioTower3FCooltrainerFYoureMyHeroText
	buttonsound
	verbosegiveitem HEAT_ROCK
	iffalse_endtext
	writetext RadioTower3FCooltrainerFItsSunnyDayText
	waitbutton
	closetext
	setevent EVENT_GOT_HEAT_ROCK_FROM_RADIO_TOWER
	end

GenericTrainerGruntM7:
	generictrainer GRUNTM, 7, EVENT_BEAT_ROCKET_GRUNTM_7, GruntM7SeenText, GruntM7BeatenText

	text "I failed in my"
	line "duties…"

	para "I'll be docked pay"
	line "for this…"
	done

GenericTrainerGruntM8:
	generictrainer GRUNTM, 8, EVENT_BEAT_ROCKET_GRUNTM_8, GruntM8SeenText, GruntM8BeatenText

	text "I feel lousy over"
	line "losing!"

	para "Darn it! I hate"
	line "useless #mon!"
	done

GenericTrainerGruntM9:
	generictrainer GRUNTM, 9, EVENT_BEAT_ROCKET_GRUNTM_9, GruntM9SeenText, GruntM9BeatenText

	text "What?! You made it"
	line "past our men in"
	cont "the Underground?"

	para "How could you?"
	done

GenericTrainerRocketScientistMarc:
	generictrainer ROCKET_SCIENTIST, MARC, EVENT_BEAT_ROCKET_SCIENTIST_MARC, RocketScientistMarcSeenText, RocketScientistMarcBeatenText

	text "Bwahahaha…"

	para "I can transmit as"
	line "strong a signal as"
	cont "I need from here."
	done

MapRadioTower3FSignpost2Script::
	opentext
	writetext RadioTower3FCardKeySlotText
	waitbutton
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue UnknownScript_0x5e603
	checkkeyitem CARD_KEY
	iftrue UnknownScript_0x5e605
UnknownScript_0x5e603:
	endtext

UnknownScript_0x5e605:
	writetext InsertedTheCardKeyText
	waitbutton
	setevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	playsound SFX_ENTER_DOOR
	changeblock 14, 2, $2a
	changeblock 14, 4, $1
	reloadmappart
	closetext
	waitsfx
	end

RadioTower3FSuperNerdText:
	text "We have recordings"
	line "of the cries of"

	para "all #mon that"
	line "have been found."

	para "We must have about"
	line "200 kinds."
	done

RadioTower3FGymGuideText_Rockets:
	text "To trainers, #-"
	line "mon are their"
	cont "beloved partners."

	para "It's terrible how"
	line "Team Rocket is"

	para "trying to control"
	line "#mon."
	done

RadioTower3FGymGuideText:
	text "We run 24 hours a"
	line "day to broadcast"

	para "entertaining pro-"
	line "grams."

	para "I'll do my best to"
	line "run around the"
	cont "clock too!"
	done

RadioTower3FCooltrainerFIsDirectorSafeText:
	text "Is the Director"
	line "safe?"
	done

RadioTower3FCooltrainerFYoureMyHeroText:
	text "Thank you!"
	line "You're my hero!"

	para "This is a token of"
	line "my appreciation."
	done

RadioTower3FCooltrainerFItsSunnyDayText:
	text "It's a Heat Rock."
	line "It makes the move"
	cont "Sunny Day last"
	cont "longer."
	done

RadioTower3FCooltrainerFYouWereMarvelousText:
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

GruntM8SeenText:
	text "It feels great"
	line "ordering #mon"
	cont "to commit crimes."
	done

GruntM8BeatenText:
	text "You're kidding!"
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

RocketScientistMarcSeenText:
	text "An unknown child"
	line "wandering here?"

	para "Who are you?"
	done

RocketScientistMarcBeatenText:
	text "Tch! I took you"
	line "too lightly!"
	done

RadioTower3FCardKeySlotText:
	text "It's the Card Key"
	line "slot."
	done

InsertedTheCardKeyText:
	text "<PLAYER> inserted"
	line "the Card Key."
	done

RadioTower3FPersonnelSignText:
	text "3F Personnel"
	done

RadioTower3FPokemonMusicSignText:
	text "#mon Music with"
	line "Host DJ Ben"
	done
