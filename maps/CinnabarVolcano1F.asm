CinnabarVolcano1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_STONETABLE, CinnabarVolcano1FBouldersFall

	def_warp_events
	warp_event 13, 25, CINNABAR_ISLAND, 2
	warp_event  5, 13, CINNABAR_VOLCANO_B1F, 1
	warp_event 14, 20, CINNABAR_VOLCANO_B1F, 2
	warp_event 25, 19, CINNABAR_VOLCANO_B1F, 3
	warp_event 22,  8, CINNABAR_VOLCANO_B1F, 4
	warp_event  8, 21, CINNABAR_VOLCANO_B1F, 8
	warp_event 20, 19, CINNABAR_VOLCANO_B1F, 9
	warp_event 18,  9, CINNABAR_VOLCANO_B1F, 10
	warp_event 10,  7, CINNABAR_VOLCANO_B1F, 11
	warp_event 15,  3, CINNABAR_VOLCANO_B1F, 12

	def_coord_events

	def_bg_events
	bg_event 13,  1, BGEVENT_ITEM + FULL_RESTORE, EVENT_CINNABAR_VOLCANO_1F_HIDDEN_FULL_RESTORE

	def_object_events
	object_event  4,  9, SPRITE_BUCK, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CinnabarVolcano1FBuckScript, EVENT_CINNABAR_VOLCANO_BUCK
	strengthboulder_event  6, 16, EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_1
	strengthboulder_event 15, 22, EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_2
	strengthboulder_event 19,  4, EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_3
	strengthboulder_event  5,  4, EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_4
	strengthboulder_event 23, 16
	object_event  2, 19, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerScientistOskar, -1
	object_event 17, 24, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSuperNerdLuis, -1
	smashrock_event  5, 18
	smashrock_event 11, 21
	smashrock_event 35, 23
	smashrock_event 19, 11
	smashrock_event 25, 12
	smashrock_event 13, 2
	smashrock_event  8, 4

	object_const_def
	const CINNABARVOLCANO1F_BUCK
	const CINNABARVOLCANO1F_BOULDER1
	const CINNABARVOLCANO1F_BOULDER2
	const CINNABARVOLCANO1F_BOULDER3
	const CINNABARVOLCANO1F_BOULDER4

CinnabarVolcano1FBouldersFall:
	usestonetable .BoulderTable
	return

.BoulderTable:
	stonetable 6, CINNABARVOLCANO1F_BOULDER1, .Disappear1
	stonetable 7, CINNABARVOLCANO1F_BOULDER2, .Disappear2
	stonetable 8, CINNABARVOLCANO1F_BOULDER3, .Disappear3
	stonetable 9, CINNABARVOLCANO1F_BOULDER4, .Disappear4
	db -1 ; end

.Disappear1:
	disappear CINNABARVOLCANO1F_BOULDER1
	jump .Fall

.Disappear2:
	disappear CINNABARVOLCANO1F_BOULDER2
	jump .Fall

.Disappear3:
	disappear CINNABARVOLCANO1F_BOULDER3
	jump .Fall

.Disappear4:
	disappear CINNABARVOLCANO1F_BOULDER4
	jump .Fall

.Fall:
	pause 30
	scall .FX
	jumptext CinnabarVolcano1FBoulderFellText

.FX:
	playsound SFX_STRENGTH
	earthquake 80
	end

CinnabarVolcano1FBuckScript:
	faceplayer
	checkevent EVENT_BEAT_BUCK
	iftrue .Beaten
	opentext
	writetext .ChallengeText
	yesorno
	iffalse_jumpopenedtext .NoText
	writetext .YesText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked CINNABARVOLCANO1F_BUCK
	loadtrainer BUCK, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BUCK
.Beaten
	opentext
	writetext .ItemText
	buttonsound
	verbosegiveitem POWER_BELT
	iffalse_endtext
	writetext .GoodbyeText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear CINNABARVOLCANO1F_BUCK
	pause 15
	special Special_FadeInQuickly
	clearevent EVENT_BATTLE_TOWER_BUCK
	end

.ChallengeText:
	text "Howdy! I'm Buck."
	line "And you're…"
	cont "<PLAYER>?"

	para "Don't tell me"
	line "you're hunting for"
	cont "treasure too?"

	para "Stark Mountain"
	line "back home has"

	para "treasure deep in-"
	line "side, so I'm sure"
	cont "this volcano does"
	cont "too!"

	para "That's why I'm here."

	para "So, <PLAYER>, what"
	line "do you say we bat-"
	cont "tle for it?"
	done

.YesText:
	text "OK! I'm telling you"
	line "right now. I'm ser-"
	cont "iously tough."
	done

.NoText:
	text "I'll keep asking"
	line "until you say"
	cont "“Yes!”"
	done

.BeatenText:
	text "Heeheehee!"
	line "So hot, you!"
	done

.ItemText:
	text "Fweh! Too much!"

	para "This volcano's"
	line "treasure isn't for"
	cont "me…"

	para "But, hey, <PLAYER>!"
	line "You're an amazing"
	cont "trainer!"

	para "You should like"
	line "this!"
	done

.GoodbyeText:
	text "I guess I'll better"
	line "my team at the"
	cont "Battle Tower."

	para "Be seeing you,"
	line "<PLAYER>!"
	cont "Bye-bye!"
	done

GenericTrainerScientistOskar:
	generictrainer SCIENTIST, OSKAR, EVENT_BEAT_SCIENTIST_OSKAR, ScientistOskarSeenText, ScientistOskarBeatenText

	text "It's important to"
	line "study natural"
	cont "disasters so we"

	para "can prepare for"
	line "the next one."
	done

GenericTrainerSuperNerdLuis:
	generictrainer SUPER_NERD, LUIS, EVENT_BEAT_SUPER_NERD_LUIS, SuperNerdLuisSeenText, SuperNerdLuisBeatenText

	text "It's so thrilling"
	line "to be inside a"
	cont "volcano!"

	para "But scary at the"
	line "same time."
	done

ScientistOskarSeenText:
	text "I'm studying the"
	line "volcano to learn"
	cont "why it erupted."
	done

ScientistOskarBeatenText:
	text "Better luck next"
	line "time!"
	done

SuperNerdLuisSeenText:
	text "Did you know that"
	line "magma is only"

	para "called lava once"
	line "it reaches the"

	para "surface through"
	line "a volcano vent?"
	done

SuperNerdLuisBeatenText:
	text "You just taught"
	line "me…"
	done

CinnabarVolcano1FBoulderFellText:
	text "The boulder fell"
	line "through!"
	done
