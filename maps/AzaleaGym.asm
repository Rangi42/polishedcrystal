AzaleaGym_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

AzaleaGym_MapEventHeader:
.Warps:
	db 2
	warp_def $f, $4, 5, AZALEA_TOWN
	warp_def $f, $5, 5, AZALEA_TOWN

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 13, 3, SIGNPOST_READ, AzaleaGymStatue
	signpost 13, 6, SIGNPOST_READ, AzaleaGymStatue

.PersonEvents:
	db 7
	person_event SPRITE_BUGSY, 7, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, AzaleaGymBugsyScript, -1
	person_event SPRITE_BUG_CATCHER, 3, 5, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_GENERICTRAINER, 2, TrainerBug_catcherBenny, -1
	person_event SPRITE_BUG_CATCHER, 8, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_GENERICTRAINER, 3, TrainerBug_catcherAl, -1
	person_event SPRITE_BUG_CATCHER, 2, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_GENERICTRAINER, 3, TrainerBug_catcherJosh, -1
	person_event SPRITE_TWIN, 10, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 1, TrainerTwinsAmyandmay1, -1
	person_event SPRITE_TWIN, 10, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 1, TrainerTwinsAmyandmay2, -1
	person_event SPRITE_GYM_GUY, 13, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, AzaleaGymGuyScript, -1

AzaleaGymStatue:
	trainertotext BUGSY, 1, $1
	checkflag ENGINE_HIVEBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	checkcode VAR_BADGES
	if_greater_than 9, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

AzaleaGymBugsyScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BUGSY
	iftrue .FightDone
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer BUGSY, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BUGSY
	opentext
	writetext .ReceivedHiveBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_HIVEBADGE
	domaptrigger AZALEA_TOWN, $1
.FightDone:
	checkevent EVENT_GOT_TM49_FURY_CUTTER
	iftrue .GotFuryCutter
	setevent EVENT_BEAT_TWINS_AMY_AND_MAY
	setevent EVENT_BEAT_BUG_CATCHER_BENNY
	setevent EVENT_BEAT_BUG_CATCHER_AL
	setevent EVENT_BEAT_BUG_CATCHER_JOSH
	writetext .HiveBadgeSpeech
	buttonsound
	verbosegivetmhm TM_FURY_CUTTER
	setevent EVENT_GOT_TM49_FURY_CUTTER
	writetext .FuryCutterSpeech
	waitbutton
	closetext
	end

.GotFuryCutter:
	writetext .BugMonsAreDeep
	waitbutton
	closetext
	end

.SeenText:
	text "I'm Bugsy!"
	line "I never lose when"

	para "it comes to bug"
	line "#mon."

	para "My research is"
	line "going to make me"

	para "the authority on"
	line "bug #mon!"

	para "Let me demonstrate"
	line "what I've learned"
	cont "from my studies."
	done

.BeatenText:
	text "Whoa, amazing!"
	line "You're an expert"
	cont "on #mon!"

	para "My research isn't"
	line "complete yet."

	para "OK, you win. Take"
	line "this Badge."
	done

.ReceivedHiveBadgeText:
	text "<PLAYER> received"
	line "the Hive Badge."
	done

.HiveBadgeSpeech:
	text "Do you know the"
	line "benefits of the"
	cont "Hive Badge?"

	para "If you have it,"
	line "#mon up to <LV>30"

	para "will obey you,"
	line "even traded ones."

	para "#mon that know"
	line "Cut will be able"

	para "to use it outside"
	line "of battle too."

	para "Here, I also want"
	line "you to have this."
	done

.FuryCutterSpeech:
	text "TM49 contains"
	line "Fury Cutter."

	para "If you don't miss,"
	line "it gets stronger"
	cont "every turn."

	para "The longer your"
	line "battle goes, the"
	cont "better it gets."

	para "Isn't that great?"
	line "I discovered it!"
	done

.BugMonsAreDeep:
	text "Bug #mon are"
	line "deep. There are"

	para "many mysteries to"
	line "be explored."

	para "Study your favor-"
	line "ites thoroughly."
	done

TrainerBug_catcherBenny:
	trainer EVENT_BEAT_BUG_CATCHER_BENNY, BUG_CATCHER, BENNY, .SeenText, .BeatenText, 0, .AfterScript

.AfterScript:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "Bug #mon evolve"
	line "young. So they get"

	para "stronger that much"
	line "faster."
	done

.BeatenText:
	text "Just evolving"
	line "isn't enough!"
	done

.AfterText:
	text "#mon become"
	line "stronger if they"
	cont "evolve. Really!"
	done

TrainerBug_catcherAl:
	trainer EVENT_BEAT_BUG_CATCHER_AL, BUG_CATCHER, AL, .SeenText, .BeatenText, 0, .AfterScript

.AfterScript:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "Bug #mon are"
	line "cool and tough!"

	para "I'll prove it to"
	line "you!"
	done

.BeatenText:
	text "You proved how"
	line "tough you are…"
	done

.AfterText:
	text "They're so cool,"
	line "but most girls"

	para "don't like bug"
	line "#mon."

	para "I don't know why…"
	done

TrainerBug_catcherJosh:
	trainer EVENT_BEAT_BUG_CATCHER_JOSH, BUG_CATCHER, JOSH, .SeenText, .BeatenText, 0, .AfterScript

.AfterScript:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "You saved all the"
	line "Slowpoke? Whew,"
	cont "you're mighty!"

	para "But my grown-up"
	line "#mon are pretty"
	cont "tough too!"
	done

.BeatenText:
	text "Urrgggh!"
	done

.AfterText:
	text "I guess I should"
	line "teach them better"
	cont "moves…"
	done

TrainerTwinsAmyandmay1:
	trainer EVENT_BEAT_TWINS_AMY_AND_MAY, TWINS, AMYANDMAY1, .SeenText, TrainerTwinsAmyandmayBeatenText, 0, .AfterScript

.AfterScript:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "Amy: Hi! Are you"
	line "challenging the"
	cont "Leader? No way!"
	done

.AfterText:
	text "Amy: You're"
	line "really strong!"
	done

TrainerTwinsAmyandmay2:
	trainer EVENT_BEAT_TWINS_AMY_AND_MAY, TWINS, AMYANDMAY2, .SeenText, TrainerTwinsAmyandmayBeatenText, 0, .AfterScript

.AfterScript:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "May: You want to"
	line "see the Leader?"
	cont "We come first!"
	done

.AfterText:
	text "May: Our bug #-"
	line "mon lost! Oh, what"
	cont "a shame."
	done

TrainerTwinsAmyandmayBeatenText:
	text "Amy & May: Oh,"
	line "double goodness!"
	done

AzaleaGymGuyScript:
	faceplayer
	checkevent EVENT_BEAT_BUGSY
	iftrue .AzaleaGymGuyWinScript
	opentext
	writetext .Text
	waitbutton
	closetext
	end

.AzaleaGymGuyWinScript:
	opentext
	writetext .WinText
	waitbutton
	closetext
	end

.Text:
	text "Yo, challenger!"

	para "Bugsy's young, but"
	line "his knowledge of"

	para "bug #mon is for"
	line "real."

	para "It's going to be"
	line "tough without my"
	cont "advice."

	para "Let's see… Bug"
	line "#mon don't like"
	cont "fire."

	para "Flying-type moves"
	line "are super-effec-"
	cont "tive too."
	done

.WinText:
	text "Well done! That"
	line "was a great clash"

	para "of talented young"
	line "trainers."

	para "With people like"
	line "you, the future of"
	cont "#mon is bright!"
	done
