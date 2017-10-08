DragonsDenB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, DragonsDenB1FSilverCallback

DragonsDenB1F_MapEventHeader:

.Warps: db 2
	warp_def 3, 20, 3, DRAGONS_DEN_1F
	warp_def 29, 19, 1, DRAGON_SHRINE

.XYTriggers: db 1
	xy_trigger 1, 30, 19, DragonsDenB1FClairTrigger

.Signposts: db 4
	signpost 24, 18, SIGNPOST_JUMPTEXT, DragonsDenShrineSignText
	signpost 29, 33, SIGNPOST_ITEM + REVIVE, EVENT_DRAGONS_DEN_B1F_HIDDEN_REVIVE
	signpost 17, 21, SIGNPOST_ITEM + MAX_POTION, EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_POTION
	signpost 15, 31, SIGNPOST_ITEM + MAX_ELIXER, EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_ELIXER

.PersonEvents: db 11
	person_event SPRITE_CLAIR, 30, 14, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_DRAGONS_DEN_CLAIR
	person_event SPRITE_SILVER, 23, 20, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DragonsDenB1FSilverScript, EVENT_RIVAL_DRAGONS_DEN
	person_event SPRITE_DRAGON_TAMER, 8, 20, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerDragonTamerDarin, -1
	person_event SPRITE_DRAGON_TAMER, 8, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerDragonTamerAdam, -1
	person_event SPRITE_COOLTRAINER_M, 17, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoDanandcara1, -1
	person_event SPRITE_COOLTRAINER_F, 18, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoDanandcara2, -1
	person_event SPRITE_TWIN, 29, 30, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerTwinsLeaandpia1, -1
	person_event SPRITE_TWIN, 29, 31, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerTwinsLeaandpia2, -1
	itemball_event 16, 35, DRAGON_FANG, 1, EVENT_DRAGONS_DEN_B1F_DRAGON_FANG
	itemball_event 4, 30, CALCIUM, 1, EVENT_DRAGONS_DEN_B1F_CALCIUM
	itemball_event 20, 5, MAX_ELIXER, 1, EVENT_DRAGONS_DEN_B1F_MAX_ELIXER

const_value set 1
	const DRAGONSDENB1F_CLAIR
	const DRAGONSDENB1F_SILVER

DragonsDenB1FSilverCallback:
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iftrue .CheckDay
	disappear DRAGONSDENB1F_SILVER
	return

.CheckDay:
	checkcode VAR_WEEKDAY
	if_equal TUESDAY, .AppearSilver
	if_equal THURSDAY, .AppearSilver
	if_equal SATURDAY, .AppearSilver
	disappear DRAGONSDENB1F_SILVER
	return

.AppearSilver:
	appear DRAGONSDENB1F_SILVER
	return

DragonsDenB1FClairTrigger:
	appear DRAGONSDENB1F_CLAIR
	opentext
	writetext .WaitText
	pause 30
	closetext
	showemote EMOTE_SHOCK, PLAYER, 15
	spriteface PLAYER, LEFT
	playmusic MUSIC_CLAIR
	applymovement DRAGONSDENB1F_CLAIR, .WalksToYouMovement
	opentext
	writetext .GiveTMText
	buttonsound
	verbosegivetmhm TM_DRAGON_PULSE
	setevent EVENT_GOT_TM59_DRAGON_PULSE
	writetext .DescribeDragonPulseText
	buttonsound
	writetext ClairPokemonLeagueDirectionsText ; in BlackthornGym1F.asm
	waitbutton
	closetext
	applymovement DRAGONSDENB1F_CLAIR, .WalksAwayMovement
	special Special_FadeOutMusic
	pause 30
	special RestartMapMusic
	disappear DRAGONSDENB1F_CLAIR
	dotrigger $0
	domaptrigger NEW_BARK_TOWN, $1
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
	checkevent EVENT_GAVE_KURT_APRICORNS
	iftrue .SilverTalkAgain
	checkevent EVENT_GOT_RIVALS_EGG
	iftrue .SilverTalk
	writetext .Training1Text
	waitbutton
	writetext .GiveEggText
	buttonsound
	checkcode VAR_PARTYCOUNT
	if_equal PARTY_LENGTH, .PartyFull
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .GiveChikoritaEgg
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .GiveCyndaquilEgg
	giveegg TOTODILE, EGG_LEVEL
	jump .GotRivalsEgg

.GiveChikoritaEgg:
	giveegg CHIKORITA, EGG_LEVEL
	jump .GotRivalsEgg

.GiveCyndaquilEgg:
	giveegg CYNDAQUIL, EGG_LEVEL
.GotRivalsEgg
	farwritetext UnknownText_0x1bdfa5 ; in text/common_1.asm
	playsound SFX_GET_EGG_FROM_DAYCARE_LADY
	waitsfx
	writetext .DescribeEggText
	waitbutton
	closetext
	setevent EVENT_GOT_RIVALS_EGG
	setevent EVENT_GAVE_KURT_APRICORNS
	domaptrigger ELMS_LAB, $7
	special RestartMapMusic
	end

.PartyFull:
	writetext .PartyFullText
	waitbutton
	closetext
	special RestartMapMusic
	end

.SilverTalk:
	writetext .Training1Text
	waitbutton
	closetext
	setevent EVENT_GAVE_KURT_APRICORNS
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

	para "The Pokemon I…"
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

.PartyFullText:
	text "Humph. You don't"
	line "have any room…"
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
	generictrainer EVENT_BEAT_DRAGON_TAMER_DARIN, DRAGON_TAMER, DARIN, .SeenText, .BeatenText

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
	generictrainer EVENT_BEAT_DRAGON_TAMER_ADAM, DRAGON_TAMER, ADAM, .SeenText, .BeatenText

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
	generictrainer EVENT_BEAT_ACE_DUO_DAN_AND_CARA, ACE_DUO, DANANDCARA1, .SeenText, .BeatenText

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
	generictrainer EVENT_BEAT_ACE_DUO_DAN_AND_CARA, ACE_DUO, DANANDCARA2, .SeenText, .BeatenText

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
	generictrainer EVENT_BEAT_TWINS_LEA_AND_PIA, TWINS, LEAANDPIA1, .SeenText, .BeatenText

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
	generictrainer EVENT_BEAT_TWINS_LEA_AND_PIA, TWINS, LEAANDPIA1, .SeenText, .BeatenText

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
