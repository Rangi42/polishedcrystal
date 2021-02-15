CeruleanGym_MapScriptHeader:
	def_scene_scripts
	scene_script CeruleanGymTrigger0
	scene_script CeruleanGymTrigger1

	def_callbacks

	def_warp_events
	warp_event  4, 15, CERULEAN_CITY, 5
	warp_event  5, 15, CERULEAN_CITY, 5

	def_coord_events

	def_bg_events
	bg_event  3,  8, BGEVENT_IFNOTSET, CeruleanGymHiddenMachinePart
	bg_event  2, 13, BGEVENT_READ, CeruleanGymStatue1
	bg_event  6, 13, BGEVENT_READ, CeruleanGymStatue2

	def_object_events
	object_event  4, 10, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_CERULEAN_GYM_ROCKET
	object_event  5,  3, SPRITE_MISTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeruleanGymMistyScript, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  4,  6, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfDiana, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  1,  9, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSwimmerfBriana, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  8,  9, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfViola, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  0,  4, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSailorParker, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  9,  4, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSailorEddie, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  3, 13, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanGymGuyScript, EVENT_TRAINERS_IN_CERULEAN_GYM

	object_const_def
	const CERULEANGYM_ROCKET

CeruleanGymTrigger1:
	priorityjump UnknownScript_0x1883de
CeruleanGymTrigger0:
	end

UnknownScript_0x1883de:
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntRunsDownMovement
	playsound SFX_TACKLE
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntRunsIntoYouMovement
	playmusic MUSIC_ROCKET_ENCOUNTER
	showtext CeruleanGymGruntIntroText
	showemote EMOTE_SHOCK, CERULEANGYM_ROCKET, 15
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntBacksAwayMovement
	showtext CeruleanGymGruntBigMistakeText
	applyonemovement CERULEANGYM_ROCKET, big_step_down
	showtext CeruleanGymGruntByeText
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntRunsOutMovement
	playsound SFX_EXIT_BUILDING
	disappear CERULEANGYM_ROCKET
	setevent EVENT_MET_ROCKET_GRUNT_AT_CERULEAN_GYM
	clearevent EVENT_FOUND_MACHINE_PART_IN_CERULEAN_GYM
	clearevent EVENT_ROUTE_24_ROCKET
	setscene $0
	setmapscene POWER_PLANT, $0
	waitsfx
	special RestartMapMusic
	pause 15
	turnobject PLAYER, DOWN
	pause 15
	end

CeruleanGymMistyScript:
	faceplayer
	opentext
	checkflag ENGINE_CASCADEBADGE
	iftrue .FightDone
	writetext MistyIntroText
	waitbutton
	closetext
	winlosstext MistyWinLossText, 0
	loadtrainer MISTY, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_MISTY
	setevent EVENT_BEAT_SWIMMERF_DIANA
	setevent EVENT_BEAT_SWIMMERF_VIOLA
	setevent EVENT_BEAT_SWIMMERF_BRIANA
	setevent EVENT_BEAT_SAILOR_PARKER
	setevent EVENT_BEAT_SAILOR_EDDIE
	opentext
	writetext ReceivedCascadeBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_CASCADEBADGE
	checkcode VAR_BADGES
	ifequal 9, .FirstBadge
	ifequal 10, .SecondBadge
	ifequal 12, .LyrasEgg
	jump .FightDone
.FirstBadge:
	specialphonecall SPECIALCALL_FIRSTBADGE
	jump .FightDone
.SecondBadge:
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	iftrue .FightDone
	specialphonecall SPECIALCALL_SECONDBADGE
	jump .FightDone
.LyrasEgg:
	specialphonecall SPECIALCALL_LYRASEGG
.FightDone:
	checkevent EVENT_GOT_TM63_WATER_PULSE
	iftrue_jumpopenedtext MistyFightDoneText
	writetext MistyGiveTMText
	buttonsound
	verbosegivetmhm TM_WATER_PULSE
	setevent EVENT_GOT_TM63_WATER_PULSE
	jumpopenedtext MistyOutroText

GenericTrainerSwimmerfDiana:
	generictrainer SWIMMERF, DIANA, EVENT_BEAT_SWIMMERF_DIANA, SwimmerfDianaSeenText, SwimmerfDianaBeatenText

	text "I'll be swimming"
	line "quietly."
	done

GenericTrainerSwimmerfViola:
	generictrainer SWIMMERF, VIOLA, EVENT_BEAT_SWIMMERF_VIOLA, SwimmerfViolaSeenText, SwimmerfViolaBeatenText

	text "Swimming is good"
	line "for both beauty"
	cont "and health!"

	para "Just look at"
	line "Misty, you'll see."
	done

GenericTrainerSwimmerfBriana:
	generictrainer SWIMMERF, BRIANA, EVENT_BEAT_SWIMMERF_BRIANA, SwimmerfBrianaSeenText, SwimmerfBrianaBeatenText

	text "Don't be too smug"
	line "about beating me."

	para "Misty will destroy"
	line "you if you get"
	cont "complacent."
	done

GenericTrainerSailorParker:
	generictrainer SAILOR, PARKER, EVENT_BEAT_SAILOR_PARKER, SailorParkerSeenText, SailorParkerBeatenText

	text "Misty has gotten"
	line "much better in the"
	cont "past few years."

	para "Don't let your"
	line "guard down, or"
	cont "you'll be crushed!"
	done

GenericTrainerSailorEddie:
	generictrainer SAILOR, EDDIE, EVENT_BEAT_SAILOR_EDDIE, SailorEddieSeenText, SailorEddieBeatenText

	text "Hey, let's go for"
	line "a swim!"

	para "Sailors have to"
	line "be able to swim!"
	done

CeruleanGymGuyScript:
	checkevent EVENT_BEAT_MISTY
	iftrue_jumptextfaceplayer CeruleanGymGuyWinText
	jumptextfaceplayer CeruleanGymGuyText

CeruleanGymHiddenMachinePart:
	dw EVENT_FOUND_MACHINE_PART_IN_CERULEAN_GYM
	checkevent EVENT_LEARNED_ABOUT_MACHINE_PART
	iffalse_jumptext CeruleanGymSomethingUnderwaterText
	givekeyitem MACHINE_PART
	opentext
	writetext CeruleanGymFoundMachinePartText
	playsound SFX_ITEM
	waitsfx
	keyitemnotify
	closetext
	setevent EVENT_FOUND_MACHINE_PART_IN_CERULEAN_GYM
	end

CeruleanGymStatue1:
	checkevent EVENT_TRAINERS_IN_CERULEAN_GYM
	iffalse CeruleanGymStatue
	jumptext CeruleanGymNote1

CeruleanGymStatue2:
	checkevent EVENT_TRAINERS_IN_CERULEAN_GYM
	iffalse CeruleanGymStatue
	jumptext CeruleanGymNote2

CeruleanGymStatue:
	trainertotext MISTY, 1, $1
	checkflag ENGINE_CASCADEBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	jumpstd gymstatue2

CeruleanGymGruntRunsDownMovement:
	run_step_down
	run_step_down
	run_step_down
	run_step_down
	step_end

CeruleanGymGruntRunsOutMovement:
	run_step_right
	run_step_down
	step_end

CeruleanGymGruntRunsIntoYouMovement:
	fix_facing
	set_sliding
	jump_step_up
	remove_sliding
	remove_fixed_facing
	step_sleep_8
	step_sleep_8
	step_down
	step_down
	step_end

CeruleanGymGruntBacksAwayMovement:
	fix_facing
	slow_step_up
	remove_fixed_facing
	step_end

CeruleanGymGruntIntroText:
	text "Oops! I so sorry!"
	line "You not hurt,"
	cont "okay?"

	para "I very busy."
	line "No time for talk-"
	cont "ing with you. Not"
	cont "good for me if"
	cont "seen by somebody."
	done

CeruleanGymGruntBigMistakeText:
	text "Oh no! You seen"
	line "me already! I make"
	cont "big mistake!"
	done

CeruleanGymGruntByeText:
	text "Hey, you! Forget"
	line "you see me, okay?"

	para "You see, hear,"
	line "know nothing,"

	para "okay?"
	line "Bye, kid! Nothing!"

	para "Bye-bye a go-go!"
	done

CeruleanGymNote1:
	text "Sorry, I'll be out"
	line "for a while."
	cont "Misty, Gym Leader"
	done

CeruleanGymNote2:
	text "Since Misty's out,"
	line "we'll be away too."
	cont "Gym Trainers"
	done

MistyIntroText:
	text "Misty: I was ex-"
	line "pecting you, you"
	cont "pest!"

	para "You may have a"
	line "lot of Johto Gym"

	para "Badges, but you'd"
	line "better not take me"
	cont "too lightly."

	para "My Water-type"
	line "#mon are tough!"
	done

MistyWinLossText:
	text "Misty: You really"
	line "are good…"

	para "I'll admit that"
	line "you are skilled…"

	para "Here you go. It's"
	line "the Cascade Badge."
	done

ReceivedCascadeBadgeText:
	text "<PLAYER> received"
	line "the Cascade Badge."
	done

MistyGiveTMText:
	text "Misty: Here's"
	line "another memento"

	para "from this battle."
	line "Take it!"
	done

MistyOutroText:
	text "It contains the"
	line "move Water Pulse."

	para "It can sometimes"
	line "confuse your foe."
	done

MistyFightDoneText:
	text "Misty: Are there"
	line "many strong train-"
	cont "ers in Johto? Like"
	cont "you, I mean."

	para "I'm going to"
	line "travel one day, so"

	para "I can battle some"
	line "skilled trainers."
	done

SwimmerfDianaSeenText:
	text "Sorry about being"
	line "away. Let's get on"
	cont "with it!"
	done

SwimmerfDianaBeatenText:
	text "I give up! You're"
	line "the winner!"
	done

SwimmerfViolaSeenText:
	text "Swimming isn't"
	line "just about speed!"

	para "It's also about"
	line "beauty and grace!"
	done

SwimmerfViolaBeatenText:
	text "I lost"
	line "beautifully…"
	done

SwimmerfBrianaSeenText:
	text "Don't let my ele-"
	line "gant swimming un-"
	cont "nerve you."
	done

SwimmerfBrianaBeatenText:
	text "Ooh, you calmly"
	line "disposed of me…"
	done

SailorParkerSeenText:
	text "Alright! Come"
	line "and get me!"
	done

SailorParkerBeatenText:
	text "This can't be…"
	done

SailorEddieSeenText:
	text "I've been relaxing"
	line "poolside, so"
	cont "I've got enough"
	cont "strength!"
	done

SailorEddieBeatenText:
	text "You can't win with"
	line "strength alone."
	done

CeruleanGymGuyText:
	text "Yo! Champ in"
	line "making!"

	para "Since Misty was"
	line "away, I went out"

	para "for some fun too."
	line "He-he-he."
	done

CeruleanGymGuyWinText:
	text "Hoo, you showed me"
	line "how tough you are."

	para "As always, that"
	line "was one heck of a"
	cont "great battle!"
	done

CeruleanGymFoundMachinePartText:
	text "<PLAYER> found"
	line "Machine Part!"
	done

CeruleanGymSomethingUnderwaterText:
	text "There's something"
	line "under the water…"
	cont "Wonder what it is?"
	done
