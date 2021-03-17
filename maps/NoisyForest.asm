NoisyForest_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6,  4, ROCKY_BEACH, 2
	warp_event  6,  5, ROCKY_BEACH, 3
	warp_event 35, 28, SHAMOUTI_SHRINE_RUINS, 1
	warp_event 35, 29, SHAMOUTI_SHRINE_RUINS, 2

	def_coord_events

	def_bg_events
	bg_event 15,  9, BGEVENT_JUMPTEXT, NoisyForestSignpostText
	bg_event 25, 31, BGEVENT_JUMPTEXT, NoisyForestSignpostText
	bg_event 32,  2, BGEVENT_ITEM + ULTRA_BALL, EVENT_NOISY_FOREST_HIDDEN_ULTRA_BALL
	bg_event 34, 18, BGEVENT_ITEM + TINYMUSHROOM, EVENT_NOISY_FOREST_HIDDEN_TINYMUSHROOM
	bg_event  7, 29, BGEVENT_ITEM + FULL_RESTORE, EVENT_NOISY_FOREST_HIDDEN_FULL_RESTORE

	def_object_events
	object_event 20, 19, SPRITE_ANABEL, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NoisyForestAnabelScript, EVENT_NOISY_FOREST_ANABEL
	object_event 19, 36, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TOLD_ABOUT_PIKABLU
	object_event 24, 31, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, MARILL, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, NoisyForestPikabluScript, EVENT_NOISY_FOREST_PIKABLU
	object_event 10, 15, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBird_keeperTrent, -1
	object_event 20,  4, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBug_maniacPierre, -1
	object_event  4, 27, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBug_maniacDylan, -1
	object_event 31, 17, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerGuitaristfJaclyn, -1
	object_event 12, 30, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerGuitaristmEzekiel, -1
	object_event 20, 34, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerHikerLester, -1
	object_event 13,  6, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, (1 << MORN) | (1 << DAY), PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, NoisyForestTeacherText, -1
	object_event 40, 15, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, NoisyForestChildText, -1
	itemball_event 41,  2, BALMMUSHROOM, 1, EVENT_NOISY_FOREST_BALMMUSHROOM
	itemball_event 16, 28, MULCH, 1, EVENT_NOISY_FOREST_MULCH
	tmhmball_event 17, 23, TM_DRAIN_PUNCH, EVENT_NOISY_FOREST_TM_DRAIN_PUNCH
	cuttree_event 40, 12, EVENT_NOISY_FOREST_CUT_TREE_1
	cuttree_event 12, 21, EVENT_NOISY_FOREST_CUT_TREE_2

	object_const_def
	const NOISYFOREST_ANABEL
	const NOISYFOREST_YOUNGSTER
	const NOISYFOREST_MARILL

NoisyForestAnabelScript:
	faceplayer
	checkevent EVENT_BEAT_ANABEL
	iftrue .Beaten
	opentext
	writetext .ChallengeText
	yesorno
	iffalse_jumpopenedtext .NoText
	writetext .YesText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked NOISYFOREST_ANABEL
	loadtrainer ANABEL, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ANABEL
.Beaten
	opentext
	writetext .ItemText
	promptbutton
	verbosegiveitem POWER_BAND
	iffalse_endtext
	writetext .GoodbyeText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear NOISYFOREST_ANABEL
	pause 15
	special Special_FadeInQuickly
	clearevent EVENT_BATTLE_TOWER_ANABEL
	end

.ChallengeText:
	text "Greetings… My name"
	line "is Anabel."

	para "…You are <PLAYER>?"
	line "I have heard sev-"
	cont "eral rumors about"
	cont "you…"

	para "Let me see your"
	line "talent in its"
	cont "entirety…"
	done

.YesText:
	text "Let's begin,"
	line "shall we?"
	done

.NoText:
	text "It's very dis-"
	line "appointing…"
	done

.BeatenText:
	text "OK, I understand…"
	done

.ItemText:
	text "Fufufu, nicely"
	line "done…"

	para "Take this, please…"
	done

.GoodbyeText:
	text "I urge you to keep"
	line "battling and keep"
	cont "on winning."

	para "I will be waiting"
	line "for you in Battle"
	cont "Tower."

	para "Until the next"
	line "time we meet…"
	done

GenericTrainerBug_maniacPierre:
	generictrainer BUG_MANIAC, PIERRE, EVENT_BEAT_BUG_MANIAC_PIERRE, .SeenText, .BeatenText

	text "Bzzz… Bzzz…"

	para "That noise is"
	line "stuck in my head…"
	done

.SeenText:
	text "My #mon love"
	line "this forest."

	para "They buzz nonstop"
	line "here!"
	done

.BeatenText:
	text "Bzzz! I lost!"
	done

GenericTrainerBug_maniacDylan:
	generictrainer BUG_MANIAC, DYLAN, EVENT_BEAT_BUG_MANIAC_DYLAN, .SeenText, .BeatenText

	text "There's something"
	line "about the buzz of"

	para "this forest that"
	line "bugs just love."
	done

.SeenText:
	text "I've never seen my"
	line "bugs this happy!"
	done

.BeatenText:
	text "Aw, but they were"
	line "so happy!"
	done

GenericTrainerGuitaristfJaclyn:
	generictrainer GUITARISTF, JACLYN, EVENT_BEAT_GUITARISTF_JACLYN, .SeenText, .BeatenText

	text "Wait up! I'm not"
	line "done singing!"
	done

.SeenText:
	text "Let my guitar"
	line "howl!"

	para "Hear me scream!"
	done

.BeatenText:
	text "Giyaaaah!"
	done

GenericTrainerGuitaristmEzekiel:
	generictrainer GUITARISTM, EZEKIEL, EVENT_BEAT_GUITARISTM_EZEKIEL, .SeenText, .BeatenText

	text "If you listen"
	line "carefully, you can"

	para "hear the rhythm of"
	line "the forest's hum."
	done

.SeenText:
	text "Battle? Yeah, I'm"
	line "up for that."
	done

.BeatenText:
	text "Wow. Good stuff."
	done

GenericTrainerHikerLester:
	generictrainer HIKER, LESTER, EVENT_BEAT_HIKER_LESTER, .SeenText, .BeatenText

	text "What, can't a Hiker"
	line "explore a forest"

	para "instead of a moun-"
	line "tain now and then?"
	done

.SeenText:
	text "Yahoo!"
	done

.BeatenText:
	text "Gweh! Cough!"

	para "Hollering choked"
	line "me up!"
	done

GenericTrainerBird_keeperTrent:
	generictrainer BIRD_KEEPER, TRENT, EVENT_BEAT_BIRD_KEEPER_TRENT, .SeenText, .BeatenText

	text "I get up early"
	line "every day to train"
	cont "my birds here."

	para "The din is part of"
	line "our training."
	done

.SeenText:
	text "The early bird"
	line "catches the worm!"
	done

.BeatenText:
	text "Looks like I was"
	line "the worm…"
	done

NoisyForestTeacherText:
	text "I come here for my"
	line "morning stroll."

	para "I even have a ped-"
	line "ometer that counts"
	cont "my steps!"
	done

NoisyForestChildText:
	text "Gah! This place"
	line "is deafening!"
	done

NoisyForestPikabluScript:
	showcrytext .PikabluText, MARILL
	appear NOISYFOREST_YOUNGSTER
	applymovement NOISYFOREST_YOUNGSTER, .WalkToYou
	turnobject PLAYER, DOWN
	showtext .OwnerText1
	disappear NOISYFOREST_MARILL
	opentext
	writetext .OwnerText2
	promptbutton
	verbosegiveitem ODD_SOUVENIR
	iffalse .NoItem
	setevent EVENT_GOT_ODD_SOUVENIR_FROM_PIKABLU_GUY
	writetext .OwnerText3
.Leave:
	waitbutton
	closetext
	applymovement NOISYFOREST_YOUNGSTER, .WalkAway
	disappear NOISYFOREST_YOUNGSTER
	clearevent EVENT_SHAMOUTI_ISLAND_PIKABLU_GUY
	end

.NoItem:
	writetext .OwnerText4
	sjump .Leave

.PikabluText:
	text "Marill: Rill!"
	done

.OwnerText1:
	text "You found my"
	line "Pikablu!"
	cont "Thank you!"
	done

.OwnerText2:
	text "Let me give you a"
	line "little something."
	done

.OwnerText3:
	text "A souvenir of your"
	line "time on Shamouti"
	cont "Island!"

	para "Doesn't it look"
	line "strange?"

	para "Bye, and thanks"
	line "again!"
	done

.OwnerText4:
	text "Oh, you can't carry"
	line "it right now."

	para "Come find me by"
	line "the #mon Center"
	cont "if you want it."
	done

.WalkToYou:
	step_right
	step_right
	step_right
	step_right
	step_right
	step_up
	step_up
	step_up
	step_end

.WalkAway:
	step_down
	step_down
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

NoisyForestSignpostText:
	text "Noisy Forest"
	done
