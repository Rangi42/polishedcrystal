Route30_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  7, 39, ROUTE_30_BERRY_SPEECH_HOUSE, 1
	warp_event 17,  5, MR_POKEMONS_HOUSE, 1

	db 0 ; coord events

	db 6 ; bg events
	bg_event  9, 43, SIGNPOST_JUMPTEXT, Route30SignText
	bg_event 13, 29, SIGNPOST_JUMPTEXT, MrPokemonsHouseDirectionsSignText
	bg_event 15,  5, SIGNPOST_JUMPTEXT, MrPokemonsHouseSignText
	bg_event  3, 21, SIGNPOST_JUMPTEXT, Route30TrainerTipsText
	bg_event 14,  9, SIGNPOST_ITEM + POTION, EVENT_ROUTE_30_HIDDEN_POTION
	bg_event  5, 39, SIGNPOST_JUMPTEXT, BerryMastersHouseSignText

	db 12 ; object events
	object_event  5, 26, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, YoungsterJoey_ImportantBattleScript, EVENT_ROUTE_30_BATTLE
	object_event  5, 24, SPRITE_PIDGEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_30_BATTLE
	object_event  5, 25, SPRITE_ROUTE_30_RATTATA, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_30_BATTLE
	object_event  2, 28, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterJoey, EVENT_ROUTE_30_YOUNGSTER_JOEY
	object_event  5, 23, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerYoungsterMikey, -1
	object_event  1,  7, SPRITE_CHERRYGROVE_RIVAL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerBug_catcherDon, -1
	object_event  7, 30, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, Route30YoungsterScript, -1
	object_event  2, 13, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, Route30CooltrainerFText, -1
	cuttree_event  8,  6, EVENT_ROUTE_30_CUT_TREE
	fruittree_event 10, 39, FRUITTREE_ROUTE_30_1, ORAN_BERRY
	fruittree_event 11,  5, FRUITTREE_ROUTE_30_2, PECHA_BERRY
	itemball_event  8, 35, ANTIDOTE, 1, EVENT_ROUTE_30_ANTIDOTE

	const_def 1 ; object constants
	const ROUTE30_YOUNGSTER1
	const ROUTE30_PIDGEY
	const ROUTE30_RATTATA

YoungsterJoey_ImportantBattleScript:
	waitsfx
	special SaveMusic
	playmusic MUSIC_JOHTO_TRAINER_BATTLE
	opentext
	writetext Text_UseTackle
	pause 30
	closetext
	playsound SFX_TACKLE
	applymovement ROUTE30_RATTATA, Route30_JoeysRattataAttacksMovement
	opentext
	faceplayer
	writetext Text_ThisIsABigBattle
	waitbutton
	turnobject ROUTE30_YOUNGSTER1, UP
	closetext
	playsound SFX_TACKLE
	applymovement ROUTE30_PIDGEY, Route30_MikeysPidgeyAttacksMovement
	special RestoreMusic
	end

TrainerYoungsterJoey:
	trainer YOUNGSTER, JOEY1, EVENT_BEAT_YOUNGSTER_JOEY, YoungsterJoey1SeenText, YoungsterJoey1BeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_YOUNGSTER_JOEY
	opentext
	checkflag ENGINE_JOEY
	iftrue .Rematch
	checkcellnum PHONE_YOUNGSTER_JOEY
	iftrue .NumberAccepted
	checkevent EVENT_JOEY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext YoungsterJoey1AfterText
	buttonsound
	setevent EVENT_JOEY_ASKED_FOR_PHONE_NUMBER
	callstd asknumber1m
	jump .RequestNumber

.AskAgain:
	callstd asknumber2m
.RequestNumber:
	askforphonenumber PHONE_YOUNGSTER_JOEY
	ifequal $1, .PhoneFull
	ifequal $2, .NumberDeclined
	trainertotext YOUNGSTER, JOEY1, $0
	callstd registerednumberm
	jumpstd numberacceptedm

.Rematch:
	callstd rematchm
	winlosstext YoungsterJoey1BeatenText, 0
	copybytetovar wJoeyFightCount
	ifequal 4, .Fight4
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight4:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight3
.Fight2:
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer YOUNGSTER, JOEY1
	startbattle
	reloadmapafterbattle
	loadvar wJoeyFightCount, 1
	clearflag ENGINE_JOEY
	end

.LoadFight1:
	loadtrainer YOUNGSTER, JOEY2
	startbattle
	reloadmapafterbattle
	loadvar wJoeyFightCount, 2
	clearflag ENGINE_JOEY
	end

.LoadFight2:
	loadtrainer YOUNGSTER, JOEY3
	startbattle
	reloadmapafterbattle
	loadvar wJoeyFightCount, 3
	clearflag ENGINE_JOEY
	end

.LoadFight3:
	loadtrainer YOUNGSTER, JOEY4
	startbattle
	reloadmapafterbattle
	loadvar wJoeyFightCount, 4
	clearflag ENGINE_JOEY
	end

.LoadFight4:
	loadtrainer YOUNGSTER, JOEY5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JOEY
	checkevent EVENT_JOEY_HP_UP
	iftrue .GiveHPUp
	checkevent EVENT_GOT_HP_UP_FROM_JOEY
	iftrue .done
	callstd rematchgiftm
	verbosegiveitem HP_UP
	iffalse .PackFull
	setevent EVENT_GOT_HP_UP_FROM_JOEY
	jumpstd numberacceptedm

.done
	end

.GiveHPUp:
	opentext
	writetext YoungsterJoeyText_GiveHPUpAfterBattle
	waitbutton
	verbosegiveitem HP_UP
	iffalse .PackFull
	clearevent EVENT_JOEY_HP_UP
	setevent EVENT_GOT_HP_UP_FROM_JOEY
	jumpstd numberacceptedm

.NumberAccepted:
	jumpstd numberacceptedm

.NumberDeclined:
	jumpstd numberdeclinedm

.PhoneFull:
	jumpstd phonefullm

.PackFull:
	setevent EVENT_JOEY_HP_UP
	jumpstd packfullm

GenericTrainerYoungsterMikey:
	generictrainer YOUNGSTER, MIKEY, EVENT_BEAT_YOUNGSTER_MIKEY, YoungsterMikeySeenText, YoungsterMikeyBeatenText

	text "Becoming a good"
	line "trainer is really"
	cont "tough."

	para "I'm going to bat-"
	line "tle other people"
	cont "to get better."
	done

GenericTrainerBug_catcherDon:
	generictrainer BUG_CATCHER, DON, EVENT_BEAT_BUG_CATCHER_DON, Bug_catcherDonSeenText, Bug_catcherDonBeatenText

	text "I ran out of #"
	line "Balls while I was"
	cont "catching #mon."

	para "I should've bought"
	line "some more…"
	done

Route30YoungsterScript:
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue_jumptextfaceplayer Route30YoungsterText_EveryoneIsBattling
	jumptextfaceplayer Route30YoungsterText_DirectionsToMrPokemonsHouse

Route30_JoeysRattataAttacksMovement:
	big_step_up
	big_step_down
	step_end

Route30_MikeysPidgeyAttacksMovement:
	big_step_down
	big_step_up
	step_end

Text_UseTackle:
	text "Go, Rattata!"

	para "Tackle!"
	done

Text_ThisIsABigBattle:
	text "What? This is a"
	line "big battle!"
	cont "Leave me alone!"
	done

YoungsterJoey1SeenText:
	text "I just lost, so"
	line "I'm trying to find"
	cont "more #mon."

	para "Wait! You look"
	line "weak! Come on,"
	cont "let's battle!"
	done

YoungsterJoey1BeatenText:
	text "Ack! I lost again!"
	line "Doggone it!"
	done

YoungsterJoey1AfterText:
	text "Do I have to have"
	line "more #mon in"

	para "order to battle"
	line "better?"

	para "No! I'm sticking"
	line "with this one no"
	cont "matter what!"
	done

YoungsterMikeySeenText:
	text "You're a #mon"
	line "trainer, right?"

	para "Then you have to"
	line "battle!"
	done

YoungsterMikeyBeatenText:
	text "That's strange."
	line "I won before."
	done

Bug_catcherDonSeenText:
	text "Instead of a bug"
	line "#mon, I found"
	cont "a trainer!"
	done

Bug_catcherDonBeatenText:
	text "Argh! You're too"
	line "strong!"
	done

Route30YoungsterText_DirectionsToMrPokemonsHouse:
	text "Mr.#mon's"
	line "house? It's a bit"
	cont "farther ahead."
	done

Route30YoungsterText_EveryoneIsBattling:
	text "Everyone's having"
	line "fun battling!"
	cont "You should too!"
	done

Route30CooltrainerFText:
	text "I'm not a trainer."

	para "But if you look"
	line "one in the eyes,"
	cont "prepare to battle."
	done

Route30SignText:
	text "Route 30"

	para "Cherrygrove City -"
	line "Violet City"
	done

MrPokemonsHouseDirectionsSignText:
	text "Mr.#mon's House"
	line "Straight Ahead!"
	done

MrPokemonsHouseSignText:
	text "Mr.#mon's House"
	done

BerryMastersHouseSignText:
	text "Berry Master's"
	line "House"
	done

Route30TrainerTipsText:
	text "Trainer Tips"

	para "No stealing other"
	line "people's #mon!"

	para "# Balls are to"
	line "be thrown only at"
	cont "wild #mon!"
	done

YoungsterJoeyText_GiveHPUpAfterBattle:
	text "I lost again…"
	line "Gee, you're tough!"

	para "Oh yeah, I almost"
	line "forgot that I had"
	cont "to give you this."

	para "Use it to get even"
	line "tougher, OK?"

	para "I'm going to get"
	line "tougher too."
	done
