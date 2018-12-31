NoisyForest_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

NoisyForest_MapEventHeader:

.Warps: db 4
	warp_def 4, 6, 2, ROCKY_BEACH
	warp_def 5, 6, 3, ROCKY_BEACH
	warp_def 28, 35, 1, SHAMOUTI_SHRINE_RUINS
	warp_def 29, 35, 2, SHAMOUTI_SHRINE_RUINS

.XYTriggers: db 0

.Signposts: db 5
	signpost 9, 15, SIGNPOST_JUMPTEXT, NoisyForestSignpostText
	signpost 31, 25, SIGNPOST_JUMPTEXT, NoisyForestSignpostText
	signpost 2, 32, SIGNPOST_ITEM + ULTRA_BALL, EVENT_NOISY_FOREST_HIDDEN_ULTRA_BALL
	signpost 18, 34, SIGNPOST_ITEM + TINYMUSHROOM, EVENT_NOISY_FOREST_HIDDEN_TINYMUSHROOM
	signpost 29, 7, SIGNPOST_ITEM + FULL_RESTORE, EVENT_NOISY_FOREST_HIDDEN_FULL_RESTORE

.PersonEvents: db 15
	person_event SPRITE_ANABEL, 19, 20, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NoisyForestAnabelScript, EVENT_NOISY_FOREST_ANABEL
	person_event SPRITE_YOUNGSTER, 15, 10, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerBird_keeperTrent, -1
	person_event SPRITE_MARILL, 31, 24, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, NoisyForestPikabluScript, EVENT_NOISY_FOREST_PIKABLU
	person_event SPRITE_SUPER_NERD, 4, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBug_maniacPierre, -1
	person_event SPRITE_SUPER_NERD, 27, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBug_maniacDylan, -1
	person_event SPRITE_COOLTRAINER_F, 17, 31, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerGuitaristfJaclyn, -1
	person_event SPRITE_ROCKER, 30, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerGuitaristmEzekiel, -1
	person_event SPRITE_POKEFAN_M, 34, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerHikerLester, -1
	person_event SPRITE_TEACHER, 6, 13, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, NoisyForestTeacherText, -1
	person_event SPRITE_CHILD, 15, 40, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, NoisyForestChildText, -1
	itemball_event 2, 41, BALMMUSHROOM, 1, EVENT_NOISY_FOREST_BALMMUSHROOM
	itemball_event 28, 16, MULCH, 1, EVENT_NOISY_FOREST_MULCH
	tmhmball_event 23, 17, TM_DRAIN_PUNCH, EVENT_NOISY_FOREST_TM_DRAIN_PUNCH
	cuttree_event 12, 40, EVENT_NOISY_FOREST_CUT_TREE_1
	cuttree_event 21, 12, EVENT_NOISY_FOREST_CUT_TREE_2

const_value set 1
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
	buttonsound
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

TrainerBug_maniacPierre:
	trainer EVENT_BEAT_BUG_MANIAC_PIERRE, BUG_MANIAC, PIERRE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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
	jumptextfaceplayer .AfterText

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
	jumptextfaceplayer .AfterText

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
	jumptextfaceplayer .AfterText

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
	jumptextfaceplayer .AfterText

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
	jumptextfaceplayer .AfterText

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
	disappear NOISYFOREST_YOUNGSTER
	moveperson NOISYFOREST_YOUNGSTER, 19, 36
	appear NOISYFOREST_YOUNGSTER
	applymovement NOISYFOREST_YOUNGSTER, .WalkToYou
	spriteface PLAYER, DOWN
	showtext .OwnerText1
	disappear NOISYFOREST_MARILL
	opentext
	writetext .OwnerText2
	buttonsound
	verbosegiveitem ODD_SOUVENIR
	iffalse .NoItem
	setevent EVENT_GOT_ODD_SOUVENIR_FROM_PIKABLU_GUY
	writetext .OwnerText3
.Leave:
	waitbutton
	closetext
	applymovement NOISYFOREST_YOUNGSTER, .WalkAway
	disappear NOISYFOREST_YOUNGSTER
	moveperson NOISYFOREST_YOUNGSTER, 10, 15
	appear NOISYFOREST_YOUNGSTER
	clearevent EVENT_SHAMOUTI_ISLAND_PIKABLU_GUY
	end

.NoItem:
	writetext .OwnerText4
	jump .Leave

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
