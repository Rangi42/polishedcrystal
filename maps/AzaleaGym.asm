AzaleaGym_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 15, AZALEA_TOWN, 5
	warp_event  5, 15, AZALEA_TOWN, 5

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, AzaleaGymStatue
	bg_event  6, 13, BGEVENT_READ, AzaleaGymStatue

	def_object_events
	object_event  5,  7, SPRITE_BUGSY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaGymBugsyScript, -1
	object_event  7, 13, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, AzaleaGymGuyScript, -1
	object_event  5,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBug_catcherBenny, -1
	object_event  8,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBug_catcherAl, -1
	object_event  0,  2, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBug_catcherJosh, -1
	object_event  4, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerTwinsAmyandmay1, -1
	object_event  5, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerTwinsAmyandmay2, -1

AzaleaGymStatue:
	gettrainername BUGSY, 1, $1
	checkflag ENGINE_HIVEBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	readvar VAR_BADGES
	ifgreater 9, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

AzaleaGymBugsyScript:
	checkevent EVENT_BEAT_BUGSY
	iftrue_jumptextfaceplayer .AfterText
	showtextfaceplayer .SeenText
	winlosstext .BeatenText, 0
	loadtrainer BUGSY, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BUGSY
	opentext
	writethistext
		text "<PLAYER> received"
		line "the Hive Badge."
		done
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_HIVEBADGE
	setmapscene AZALEA_TOWN, $1
	setevent EVENT_BEAT_TWINS_AMY_AND_MAY
	setevent EVENT_BEAT_BUG_CATCHER_BENNY
	setevent EVENT_BEAT_BUG_CATCHER_AL
	setevent EVENT_BEAT_BUG_CATCHER_JOSH
	writethistext
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
	promptbutton
	verbosegivetmhm TM_U_TURN
	setevent EVENT_GOT_TM69_U_TURN
	jumpthisopenedtext

	text "TM69 contains"
	line "U-turn."

	para "It lets your #-"
	line "mon attack, then"

	para "switch out right"
	line "away."

	para "Isn't that great?"
	line "I discovered it!"
	done

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

.AfterText:
	text "Bug #mon are"
	line "deep. There are"

	para "many mysteries to"
	line "be explored."

	para "Study your favor-"
	line "ites thoroughly."
	done

AzaleaGymGuyScript:
	checkevent EVENT_BEAT_BUGSY
	iftrue_jumptextfaceplayer .WinText
	jumpthistextfaceplayer

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
	line "are super effec-"
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

GenericTrainerBug_catcherBenny:
	generictrainer BUG_CATCHER, BENNY, EVENT_BEAT_BUG_CATCHER_BENNY, .SeenText, .BeatenText

	text "#mon become"
	line "stronger if they"
	cont "evolve. Really!"
	done

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

GenericTrainerBug_catcherAl:
	generictrainer BUG_CATCHER, AL, EVENT_BEAT_BUG_CATCHER_AL, .SeenText, .BeatenText

	text "They're so cool,"
	line "but most girls"

	para "don't like bug"
	line "#mon."

	para "I don't know why…"
	done

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

GenericTrainerBug_catcherJosh:
	generictrainer BUG_CATCHER, JOSH, EVENT_BEAT_BUG_CATCHER_JOSH, .SeenText, .BeatenText

	text "I guess I should"
	line "teach them better"
	cont "moves…"
	done

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

GenericTrainerTwinsAmyandmay1:
	generictrainer TWINS, AMYANDMAY1, EVENT_BEAT_TWINS_AMY_AND_MAY, .SeenText, TrainerTwinsAmyandmayBeatenText

	text "Amy: You're"
	line "really strong!"
	done

.SeenText:
	text "Amy: Hi! Are you"
	line "challenging the"
	cont "Leader? No way!"
	done

GenericTrainerTwinsAmyandmay2:
	generictrainer TWINS, AMYANDMAY2, EVENT_BEAT_TWINS_AMY_AND_MAY, .SeenText, TrainerTwinsAmyandmayBeatenText

	text "Mimi: Our bug"
	line "#mon lost!"

	para "Oh, what a"
	line "shame."
	done

.SeenText:
	text "Mimi: You want to"
	line "see the Leader?"
	cont "We come first!"
	done

TrainerTwinsAmyandmayBeatenText:
	text "Amy & Mimi: Oh,"
	line "double goodness!"
	done
