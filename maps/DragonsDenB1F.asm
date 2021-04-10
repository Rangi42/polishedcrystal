DragonsDenB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, DragonsDenB1FSilverCallback

	def_warp_events
	warp_event 20,  3, DRAGONS_DEN_1F, 3
	warp_event 19, 29, DRAGON_SHRINE, 1

	def_coord_events
	coord_event 19, 30, 1, DragonsDenB1FClairTrigger

	def_bg_events
	bg_event 18, 24, BGEVENT_JUMPTEXT, DragonsDenShrineSignText
	bg_event 33, 29, BGEVENT_ITEM + REVIVE, EVENT_DRAGONS_DEN_B1F_HIDDEN_REVIVE
	bg_event 21, 17, BGEVENT_ITEM + MAX_POTION, EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_POTION
	bg_event 31, 15, BGEVENT_ITEM + MAX_ELIXIR, EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_ELIXIR

	def_object_events
	object_event 14, 30, SPRITE_CLAIR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_DRAGONS_DEN_CLAIR
	object_event 20, 23, SPRITE_SILVER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DragonsDenB1FSilverScript, EVENT_RIVAL_DRAGONS_DEN
	object_event 20,  8, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerDragonTamerDarin, -1
	object_event  8,  8, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerDragonTamerAdam, -1
	object_event  4, 17, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoDanandcara1, -1
	object_event  4, 18, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoDanandcara2, -1
	object_event 30, 29, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerTwinsLeaandpia1, -1
	object_event 31, 29, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerTwinsLeaandpia2, -1
	itemball_event 35, 16, DRAGON_FANG, 1, EVENT_DRAGONS_DEN_B1F_DRAGON_FANG
	itemball_event 30,  4, CALCIUM, 1, EVENT_DRAGONS_DEN_B1F_CALCIUM
	itemball_event  5, 20, MAX_ELIXIR, 1, EVENT_DRAGONS_DEN_B1F_MAX_ELIXIR

	object_const_def
	const DRAGONSDENB1F_CLAIR
	const DRAGONSDENB1F_SILVER

DragonsDenB1FSilverCallback:
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iftrue .CheckDay
	disappear DRAGONSDENB1F_SILVER
	endcallback

.CheckDay:
	checkevent EVENT_GOT_RIVALS_EGG
	iffalse .AppearSilver
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .AppearSilver
	ifequal THURSDAY, .AppearSilver
	ifequal SATURDAY, .AppearSilver
	disappear DRAGONSDENB1F_SILVER
	endcallback

.AppearSilver:
	appear DRAGONSDENB1F_SILVER
	endcallback

DragonsDenB1FClairTrigger:
	appear DRAGONSDENB1F_CLAIR
	opentext
	writetext .WaitText
	pause 30
	closetext
	showemote EMOTE_SHOCK, PLAYER, 15
	turnobject PLAYER, LEFT
	playmusic MUSIC_CLAIR
	applymovement DRAGONSDENB1F_CLAIR, .WalksToYouMovement
	opentext
	writetext .GiveTMText
	promptbutton
	verbosegivetmhm TM_DRAGON_PULSE
	setevent EVENT_GOT_TM59_DRAGON_PULSE
	writetext .DescribeDragonPulseText
	promptbutton
	writetext ClairPokemonLeagueDirectionsText ; in BlackthornGym1F.asm
	waitbutton
	closetext
	applymovement DRAGONSDENB1F_CLAIR, .WalksAwayMovement
	special Special_FadeOutMusic
	pause 30
	special RestartMapMusic
	disappear DRAGONSDENB1F_CLAIR
	setscene $0
	setmapscene NEW_BARK_TOWN, $1
	clearevent EVENT_LYRA_IN_HER_ROOM
	end

.WaitText:
	text "Wait!"
	done

.GiveTMText:
	text "Clair: I'm sorry"
	line "about this."

	para "Here, take this as"
	line "my apology."
	done

.DescribeDragonPulseText:
	text "That contains"
	line "Dragon Pulse."

	para "If you don't want"
	line "it, you don't have"
	cont "to take it."
	done

.WalksToYouMovement:
	slow_step_right
	slow_step_right
	slow_step_right
	slow_step_right
	step_end

.WalksAwayMovement:
	slow_step_left
	slow_step_left
	slow_step_left
	slow_step_left
	step_end

DragonsDenShrineSignText:
	text "Dragon Shrine"

	para "A shrine honoring"
	line "the dragon #mon"

	para "said to have lived"
	line "in Dragon's Den."
	done

DragonsDenB1FSilverScript:
	playmusic MUSIC_RIVAL_ENCOUNTER
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .SilverTalkAgain
	checkevent EVENT_GOT_RIVALS_EGG
	iftrue .SilverTalk
	writetext .Training1Text
	waitbutton
	writetext .GiveEggText
	promptbutton
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .GiveChikoritaEgg
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .GiveCyndaquilEgg
	giveegg TOTODILE
	sjump .GotRivalsEgg

.GiveChikoritaEgg:
	giveegg CHIKORITA
	sjump .GotRivalsEgg

.GiveCyndaquilEgg:
	giveegg CYNDAQUIL
.GotRivalsEgg
	iffalse .PartyAndBoxFull 
	writetext .DescribeEggText
	waitbutton
	closetext
	setevent EVENT_GOT_RIVALS_EGG
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setmapscene ELMS_LAB, $7
	special RestartMapMusic
	end

.PartyAndBoxFull:
	writetext .PartyAndBoxFullText
	waitbutton
	closetext
	special RestartMapMusic
	end

.SilverTalk:
	writetext .Training1Text
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	special RestartMapMusic
	end

.SilverTalkAgain:
	writetext .Training2Text
	waitbutton
	closetext
	special RestartMapMusic
	end

.GiveEggText:
	text "…"
	line "Listen."

	para "The #mon I…"
	line "took from the Lab…"

	para "It had an Egg."
	line "I don't need it."
	cont "Here. Take it."
	done

.DescribeEggText:
	text "Humph. Are you"
	line "through here?"

	para "Then stay out of"
	line "my way."
	done

.PartyAndBoxFullText:
	text "Humph. You don't"
	line "have any room…"
	cont "Even in your box…"
	done

.Training1Text:
	text "…"
	line "What? <PLAYER>?"

	para "…No, I won't"
	line "battle you now…"

	para "My #mon aren't"
	line "ready to beat you."

	para "I can't push them"
	line "too hard now."

	para "I have to be dis-"
	line "ciplined to become"

	para "the greatest #-"
	line "mon trainer…"
	done

.Training2Text:
	text "…"

	para "Whew…"

	para "Learn to stay out"
	line "of my way…"
	done

GenericTrainerDragonTamerDarin:
	generictrainer DRAGON_TAMER, DARIN, EVENT_BEAT_DRAGON_TAMER_DARIN, .SeenText, .BeatenText

	text "The Shrine ahead"
	line "is home to the"

	para "Master of our"
	line "dragon-user clan."

	para "You're not allowed"
	line "to just go in!"
	done

.SeenText:
	text "You! How dare you"
	line "enter uninvited!"
	done

.BeatenText:
	text "S-strong!"
	done

GenericTrainerDragonTamerAdam:
	generictrainer DRAGON_TAMER, ADAM, EVENT_BEAT_DRAGON_TAMER_ADAM, .SeenText, .BeatenText

	text "Not even the power"
	line "of dragons could"
	cont "stop you."

	para "You may be the"
	line "kind of trainer"

	para "our Master is"
	line "looking for."
	done

.SeenText:
	text "You shouldn't be"
	line "in here!"
	done

.BeatenText:
	text "No! I was"
	line "defeated!"
	done

GenericTrainerAceDuoDanandcara1:
	generictrainer ACE_DUO, DANANDCARA1, EVENT_BEAT_ACE_DUO_DAN_AND_CARA, .SeenText, .BeatenText

	text "Dan: Soon I'll"
	line "get permission"

	para "from our Master to"
	line "use dragons."

	para "When I do, I'm"
	line "going to become an"

	para "admirable dragon"
	line "trainer and gain"

	para "our Master's"
	line "approval."
	done

.SeenText:
	text "Dan: I may not"
	line "use dragons, but"
	cont "I'm still strong!"
	done

.BeatenText:
	text "Dan: You were"
	line "even stronger!"
	done

GenericTrainerAceDuoDanandcara2:
	generictrainer ACE_DUO, DANANDCARA2, EVENT_BEAT_ACE_DUO_DAN_AND_CARA, .SeenText, .BeatenText

	text "Cara: Dragons are"
	line "difficult to"

	para "raise, and very"
	line "powerful."

	para "They're not for"
	line "everyone."
	done

.SeenText:
	text "Cara: Do you want"
	line "to train dragons"
	cont "too?"
	done

.BeatenText:
	text "Cara: Oh yikes,"
	line "I lost!"
	done

GenericTrainerTwinsLeaandpia1:
	generictrainer TWINS, LEAANDPIA1, EVENT_BEAT_TWINS_LEA_AND_PIA, .SeenText, .BeatenText

	text "It was like having"
	line "to battle Lance."
	done

.SeenText:
	text "It's a stranger we"
	line "don't know."
	done

.BeatenText:
	text "Ouchies."
	done

GenericTrainerTwinsLeaandpia2:
	generictrainer TWINS, LEAANDPIA1, EVENT_BEAT_TWINS_LEA_AND_PIA, .SeenText, .BeatenText

	text "We'll tell on you."

	para "Master will be"
	line "angry with you."
	done

.SeenText:
	text "Who are you?"
	done

.BeatenText:
	text "Meanie."
	done
