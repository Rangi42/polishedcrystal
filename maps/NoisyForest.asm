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
	object_event 19, 36, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TOLD_ABOUT_PIKABLU
	object_event 24, 31, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, MARILL, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, NO_FORM, NoisyForestPikabluScript, EVENT_NOISY_FOREST_PIKABLU
	object_event 20, 19, SPRITE_KATY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, KatyScript, -1
	object_event 10, 15, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBird_keeperTrent, -1
	object_event 20,  4, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBug_maniacPierre, -1
	object_event  4, 27, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBug_maniacDylan, -1
	object_event 31, 17, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerGuitaristfJaclyn, -1
	object_event 12, 30, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerGuitaristmEzekiel, -1
	object_event 20, 34, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerHikerLester, -1
	object_event 13,  6, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, (1 << MORN) | (1 << DAY), PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, NoisyForestTeacherText, -1
	object_event 40, 15, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, NoisyForestChildText, -1
	itemball_event 41,  2, BALMMUSHROOM, 1, EVENT_NOISY_FOREST_BALMMUSHROOM
	itemball_event 16, 28, MULCH, 1, EVENT_NOISY_FOREST_MULCH
	tmhmball_event 17, 22, TM_DRAIN_PUNCH, EVENT_NOISY_FOREST_TM_DRAIN_PUNCH
	cuttree_event 40, 12, EVENT_NOISY_FOREST_CUT_TREE_1
	cuttree_event 12, 21, EVENT_NOISY_FOREST_CUT_TREE_2

	object_const_def
	const NOISYFOREST_WILHOMENA
	const NOISYFOREST_PIKABLU
	const NOISYFOREST_KATY

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
	appear NOISYFOREST_WILHOMENA
	applymovement NOISYFOREST_WILHOMENA, .WalkToYou
	turnobject PLAYER, DOWN
	showtext .OwnerText1
	disappear NOISYFOREST_PIKABLU
	opentext
	writetext .OwnerText2
	promptbutton
	verbosegiveitem ODD_SOUVENIR
	iffalsefwd .NoItem
	setevent EVENT_GOT_ODD_SOUVENIR_FROM_WILHOMENA
	writetext .OwnerText3
.Leave:
	waitbutton
	closetext
	applymovement NOISYFOREST_WILHOMENA, .WalkAway
	disappear NOISYFOREST_WILHOMENA
	clearevent EVENT_SHAMOUTI_ISLAND_WILHOMENA
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

KatyScript:
	faceplayer
	checkevent EVENT_BEAT_KATY
	iftruefwd .After
	opentext
	checkevent EVENT_INTRODUCED_KATY
	iftruefwd .Introduced
	writetext .IntroText
	sjumpfwd .Question
.Introduced
	writetext .RematchText
.Question
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	setevent EVENT_INTRODUCED_KATY
	winlosstext .BeatenText, 0
	setlasttalked NOISYFOREST_KATY
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftruefwd .Rematch
	loadtrainer KATY, 1
	sjumpfwd .StartBattle
.Rematch
	loadtrainer KATY, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_KATY
.After
	opentext
	checkevent EVENT_GOT_SWEET_HONEY_FROM_KATY
	iftruefwd .Done
	writetext .RewardText
	promptbutton
	verbosegiveitem SWEET_HONEY
	iffalse_endtext
	setevent EVENT_GOT_SWEET_HONEY_FROM_KATY
.Done
	jumpthisopenedtext

	text "May your future"
	line "adventures be as"

	para "sweet and lovely"
	line "as a good dessert."

	para "Off you go, then."
	line "Until we meet"
	cont "again!"
	done

.RewardText:
	text "Your strength rose"
	line "during our battle"

	para "like a nice bread"
	line "in the oven."

	para "I may need to work"
	line "on my own strength"
	cont "as well!"

	para "Allow me to pre-"
	line "sent you with"

	para "this for your"
	line "victory!"
	done

.IntroText:
	text "Hello there!"
	line "My name is Katy."

	para "I'm the owner of a"
	line "patisserie in a"
	cont "far-away region."

	para "Oh? That's right,"
	line "I'm not in my shop."

	para "I'm collecting"
	line "ingredients."

	para "Little sweets that"
	line "bring happiness"
	cont "in just one bite,"

	para "Bug-type #mon"
	line "hiding in foliage…"

	para "Both are small but"
	line "very powerful."

	para "Shall I give you"
	line "a taste?"
	done

.RematchText:
	text "Hello again,"
	line "<PLAYER>!"

	para "You really looked"
	line "like you were en-"
	cont "joying yourself"

	para "during our last"
	line "battle."

	para "How about a second"
	line "helping?"
	done

.SeenText:
	text "Don't let your"
	line "guard down unless"

	para "you would like to"
	line "be knocked off"
	cont "your feet!"
	done

.BeatenText:
	text "My sweet little"
	line "#mon dropped"
	cont "like flies!"
	done

.RefusedText:
	text "Awww. Not yet?"
	line "Do come back when"

	para "you're good and"
	line "ready!"
	done

NoisyForestSignpostText:
	text "Noisy Forest"
	done
