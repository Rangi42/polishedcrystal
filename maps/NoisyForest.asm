const_value set 2
	const NOISYFOREST_ANABEL
	const NOISYFOREST_SUPER_NERD1
	const NOISYFOREST_SUPER_NERD2
	const NOISYFOREST_COOLTRAINER_F
	const NOISYFOREST_ROCKER
	const NOISYFOREST_POKEFAN_M
	const NOISYFOREST_YOUNGSTER
	const NOISYFOREST_TEACHER
	const NOISYFOREST_CHILD
	const NOISYFOREST_MARILL
	const NOISYFOREST_POKE_BALL1
	const NOISYFOREST_POKE_BALL2
	const NOISYFOREST_POKE_BALL3
	const NOISYFOREST_CUT_TREE1
	const NOISYFOREST_CUT_TREE2

NoisyForest_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NoisyForestAnabelScript:
	faceplayer
	checkevent EVENT_BEAT_ANABEL
	iftrue .Beaten
	opentext
	writetext .ChallengeText
	yesorno
	iffalse .No
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
	buttonsound
	verbosegiveitem POWER_BAND
	iffalse .Done
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

.Done:
	closetext
	end

.No:
	writetext .NoText
	waitbutton
	closetext
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
	text "Okay, I under-"
	line "stand…"
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

TrainerBug_maniacPierre:
	trainer EVENT_BEAT_BUG_MANIAC_PIERRE, BUG_MANIAC, PIERRE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "My #mon love"
	line "this forest."

	para "They buzz nonstop"
	line "here!"
	done

.BeatenText:
	text "Bzzz! I lost!"
	done

.AfterText:
	text "Bzzz… Bzzz…"

	para "That noise is"
	line "stuck in my head…"
	done

TrainerBug_maniacDylan:
	trainer EVENT_BEAT_BUG_MANIAC_DYLAN, BUG_MANIAC, DYLAN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "I've never seen my"
	line "bugs this happy!"
	done

.BeatenText:
	text "Aw, but they were"
	line "so happy!"
	done

.AfterText:
	text "There's something"
	line "about the buzz of"

	para "this forest that"
	line "bugs just love."
	done

TrainerGuitaristfJaclyn:
	trainer EVENT_BEAT_GUITARISTF_JACLYN, GUITARISTF, JACLYN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "Let my guitar"
	line "howl!"

	para "Hear me scream!"
	done

.BeatenText:
	text "Giyaaaah!"
	done

.AfterText:
	text "Wait up! I'm not"
	line "done singing!"
	done

TrainerGuitaristmEzekiel:
	trainer EVENT_BEAT_GUITARISTM_EZEKIEL, GUITARISTM, EZEKIEL, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "Battle? Yeah, I'm"
	line "up for that."
	done

.BeatenText:
	text "Wow. Good stuff."
	done

.AfterText:
	text "If you listen"
	line "carefully, you can"

	para "hear the rhythm of"
	line "the forest's hum."
	done

TrainerHikerLester:
	trainer EVENT_BEAT_HIKER_LESTER, HIKER, LESTER, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "Yahoo!"
	done

.BeatenText:
	text "Gweh! Cough!"

	para "Hollering choked"
	line "me up!"
	done

.AfterText:
	text "What, can't a Hiker"
	line "explore a forest"

	para "instead of a moun-"
	line "tain now and then?"
	done

TrainerBird_keeperTrent:
	trainer EVENT_BEAT_BIRD_KEEPER_TRENT, BIRD_KEEPER, TRENT, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "The early bird"
	line "catches the worm!"
	done

.BeatenText:
	text "Looks like I was"
	line "the worm…"
	done

.AfterText:
	text "I get up early"
	line "every day to train"
	cont "my birds here."

	para "The din is part of"
	line "our training."
	done

NoisyForestTeacherScript:
	jumptextfaceplayer .Text

.Text:
	text "I come here for my"
	line "morning stroll."

	para "I even have a ped-"
	line "ometer that counts"
	cont "my steps!"
	done

NoisyForestChildScript:
	jumptextfaceplayer .Text

.Text:
	text "Gah! This place"
	line "is deafening!"
	done

NoisyForestPikabluScript:
	opentext
	writetext .Text
	cry MARILL
	waitbutton
	closetext
	end

.Text:
	text "Marill: Rill!"
	done

NoisyForestBalmMushroom:
	itemball BALMMUSHROOM

NoisyForestMulch:
	itemball MULCH

NoisyForestTMUTurn:
	tmhmball TM_U_TURN

NoisyForestCutTree:
	jumpstd cuttree

NoisyForestSignpostScript:
	jumptext .Text

.Text:
	text "Noisy Forest"
	done

NoisyForestHiddenUltraBall:
	dwb EVENT_NOISY_FOREST_HIDDEN_ULTRA_BALL, ULTRA_BALL

NoisyForestHiddenTinyMushroom:
	dwb EVENT_NOISY_FOREST_HIDDEN_TINYMUSHROOM, TINYMUSHROOM

NoisyForestHiddenFullRestore:
	dwb EVENT_NOISY_FOREST_HIDDEN_FULL_RESTORE, FULL_RESTORE

NoisyForest_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $4, $6, 2, ROCKY_BEACH
	warp_def $5, $6, 3, ROCKY_BEACH
	warp_def $1c, $23, 1, SHAMOUTI_SHRINE_RUINS
	warp_def $1d, $23, 2, SHAMOUTI_SHRINE_RUINS

.XYTriggers:
	db 0

.Signposts:
	db 5
	signpost 9, 15, SIGNPOST_READ, NoisyForestSignpostScript
	signpost 31, 25, SIGNPOST_READ, NoisyForestSignpostScript
	signpost 2, 32, SIGNPOST_ITEM, NoisyForestHiddenUltraBall
	signpost 18, 34, SIGNPOST_ITEM, NoisyForestHiddenTinyMushroom
	signpost 29, 7, SIGNPOST_ITEM, NoisyForestHiddenFullRestore

.PersonEvents:
	db 15
	person_event SPRITE_ANABEL, 19, 20, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NoisyForestAnabelScript, EVENT_NOISY_FOREST_ANABEL
	person_event SPRITE_SUPER_NERD, 4, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBug_maniacPierre, -1
	person_event SPRITE_SUPER_NERD, 27, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBug_maniacDylan, -1
	person_event SPRITE_COOLTRAINER_F, 17, 31, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerGuitaristfJaclyn, -1
	person_event SPRITE_ROCKER, 30, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerGuitaristmEzekiel, -1
	person_event SPRITE_POKEFAN_M, 34, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerHikerLester, -1
	person_event SPRITE_YOUNGSTER, 15, 10, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerBird_keeperTrent, -1
	person_event SPRITE_TEACHER, 6, 13, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, NoisyForestTeacherScript, -1
	person_event SPRITE_CHILD, 15, 40, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, NoisyForestChildScript, -1
	person_event SPRITE_MARILL, 31, 24, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, NoisyForestPikabluScript, EVENT_NOISY_FOREST_PIKABLU
	person_event SPRITE_BALL_CUT_FRUIT, 2, 41, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, NoisyForestBalmMushroom, EVENT_NOISY_FOREST_BALMMUSHROOM
	person_event SPRITE_BALL_CUT_FRUIT, 28, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, NoisyForestMulch, EVENT_NOISY_FOREST_MULCH
	person_event SPRITE_BALL_CUT_FRUIT, 23, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TMHMBALL, 0, NoisyForestTMUTurn, EVENT_NOISY_FOREST_TM_U_TURN
	person_event SPRITE_BALL_CUT_FRUIT, 12, 40, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NoisyForestCutTree, EVENT_NOISY_FOREST_CUT_TREE_1
	person_event SPRITE_BALL_CUT_FRUIT, 21, 12, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NoisyForestCutTree, EVENT_NOISY_FOREST_CUT_TREE_2
