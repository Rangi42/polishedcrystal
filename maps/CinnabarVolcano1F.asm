CinnabarVolcano1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_CMDQUEUE, CinnabarVolcano1FBouldersFall

CinnabarVolcano1F_MapEventHeader:

.Warps: db 10
	warp_def 25, 13, 2, CINNABAR_ISLAND
	warp_def 13, 5, 1, CINNABAR_VOLCANO_B1F
	warp_def 20, 14, 2, CINNABAR_VOLCANO_B1F
	warp_def 19, 25, 3, CINNABAR_VOLCANO_B1F
	warp_def 8, 22, 4, CINNABAR_VOLCANO_B1F
	warp_def 21, 8, 8, CINNABAR_VOLCANO_B1F
	warp_def 19, 20, 9, CINNABAR_VOLCANO_B1F
	warp_def 9, 18, 10, CINNABAR_VOLCANO_B1F
	warp_def 7, 10, 11, CINNABAR_VOLCANO_B1F
	warp_def 3, 15, 12, CINNABAR_VOLCANO_B1F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 13, SIGNPOST_ITEM + FULL_RESTORE, EVENT_CINNABAR_VOLCANO_1F_HIDDEN_FULL_RESTORE

.PersonEvents: db 15
	person_event SPRITE_BUCK, 9, 4, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FBuckScript, EVENT_CINNABAR_VOLCANO_BUCK
	strengthboulder_event 16, 6, EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_1
	strengthboulder_event 22, 15, EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_2
	strengthboulder_event 4, 19, EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_3
	strengthboulder_event 4, 5, EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_4
	strengthboulder_event 16, 23
	person_event SPRITE_SCIENTIST, 19, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerScientistOskar, -1
	person_event SPRITE_SUPER_NERD, 24, 17, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerSuperNerdLuis, -1
	smashrock_event 18, 5
	smashrock_event 21, 11
	smashrock_event 23, 35
	smashrock_event 11, 19
	smashrock_event 12, 25
	smashrock_event 2, 13
	smashrock_event 4, 8

const_value set 1
	const CINNABARVOLCANO1F_BUCK
	const CINNABARVOLCANO1F_BOULDER1
	const CINNABARVOLCANO1F_BOULDER2
	const CINNABARVOLCANO1F_BOULDER3
	const CINNABARVOLCANO1F_BOULDER4

CinnabarVolcano1FBouldersFall:
	writecmdqueue .BoulderCmdQueue
	return

.BoulderCmdQueue:
	dbw CMDQUEUE_STONETABLE, .BoulderTable ; check if any stones are sitting on a warp
	dw 0 ; filler

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

TrainerScientistOskar:
	trainer EVENT_BEAT_SCIENTIST_OSKAR, SCIENTIST, OSKAR, ScientistOskarSeenText, ScientistOskarBeatenText, 0, ScientistOskarScript

ScientistOskarScript:
	end_if_just_battled
	jumptextfaceplayer ScientistOskarAfterText

TrainerSuperNerdLuis:
	trainer EVENT_BEAT_SUPER_NERD_LUIS, SUPER_NERD, LUIS, SuperNerdLuisSeenText, SuperNerdLuisBeatenText, 0, SuperNerdLuisScript

SuperNerdLuisScript:
	end_if_just_battled
	jumptextfaceplayer SuperNerdLuisAfterText

ScientistOskarSeenText:
	text "I'm studying the"
	line "volcano to learn"
	cont "why it erupted."
	done

ScientistOskarBeatenText:
	text "Better luck next"
	line "time!"
	done

ScientistOskarAfterText:
	text "It's important to"
	line "study natural"
	cont "disasters so we"

	para "can prepare for"
	line "the next one."
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

SuperNerdLuisAfterText:
	text "It's so thrilling"
	line "to be inside a"
	cont "volcano!"

	para "But scary at the"
	line "same time."
	done

CinnabarVolcano1FBoulderFellText:
	text "The boulder fell"
	line "through!"
	done
