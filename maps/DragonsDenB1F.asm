const_value set 2
	const DRAGONSDENB1F_CLAIR
	const DRAGONSDENB1F_SILVER
	const DRAGONSDENB1F_DRAGON_TAMER1
	const DRAGONSDENB1F_DRAGON_TAMER2
	const DRAGONSDENB1F_COOLTRAINER_M
	const DRAGONSDENB1F_COOLTRAINER_F
	const DRAGONSDENB1F_TWIN1
	const DRAGONSDENB1F_TWIN2
	const DRAGONSDENB1F_POKE_BALL1
	const DRAGONSDENB1F_POKE_BALL2
	const DRAGONSDENB1F_POKE_BALL3

DragonsDenB1F_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_NEWMAP, .CheckSilver

.Trigger0:
	end

.Trigger1:
	end

.CheckSilver:
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

DragonsDenB1F_ClairTrigger:
	appear DRAGONSDENB1F_CLAIR
	opentext
	writetext ClairText_Wait
	pause 30
	closetext
	showemote EMOTE_SHOCK, PLAYER, 15
	spriteface PLAYER, LEFT
	playmusic MUSIC_CLAIR
	applymovement DRAGONSDENB1F_CLAIR, MovementDragonsDen_ClairWalksToYou
	opentext
	writetext ClairText_GiveDragonbreathDragonDen
	buttonsound
	verbosegivetmhm TM_DRAGONBREATH
	setevent EVENT_GOT_TM21_DRAGONBREATH
	writetext ClairText_DescribeDragonbreathDragonDen
	buttonsound
	writetext ClairText_WhatsTheMatterDragonDen
	waitbutton
	closetext
	applymovement DRAGONSDENB1F_CLAIR, MovementDragonsDen_ClairWalksAway
	special Special_FadeOutMusic
	pause 30
	special RestartMapMusic
	disappear DRAGONSDENB1F_CLAIR
	dotrigger $0
	domaptrigger NEW_BARK_TOWN, $1
	clearevent EVENT_LYRA_IN_HER_ROOM
	end

TrainerDragonTamerDarin:
	trainer EVENT_BEAT_DRAGON_TAMER_DARIN, DRAGON_TAMER, DARIN, DragonTamerDarinSeenText, DragonTamerDarinBeatenText, 0, DragonTamerDarinScript

DragonTamerDarinScript:
	end_if_just_battled
	opentext
	writetext DragonTamerDarinAfterText
	waitbutton
	closetext
	end

TrainerDragonTamerAdam:
	trainer EVENT_BEAT_DRAGON_TAMER_ADAM, DRAGON_TAMER, ADAM, DragonTamerAdamSeenText, DragonTamerAdamBeatenText, 0, DragonTamerAdamScript

DragonTamerAdamScript:
	end_if_just_battled
	opentext
	writetext DragonTamerAdamAfterText
	waitbutton
	closetext
	end

TrainerAceDuoDanandcara1:
	trainer EVENT_BEAT_ACE_DUO_DAN_AND_CARA, ACE_DUO, DANANDCARA1, AceDuoDanandcara1SeenText, AceDuoDanandcara1BeatenText, 0, AceDuoDanandcara1Script

AceDuoDanandcara1Script:
	end_if_just_battled
	opentext
	writetext AceDuoDanandcara1AfterText
	waitbutton
	closetext
	end

TrainerAceDuoDanandcara2:
	trainer EVENT_BEAT_ACE_DUO_DAN_AND_CARA, ACE_DUO, DANANDCARA2, AceDuoDanandcara2SeenText, AceDuoDanandcara2BeatenText, 0, AceDuoDanandcara2Script

AceDuoDanandcara2Script:
	end_if_just_battled
	opentext
	writetext AceDuoDanandcara2AfterText
	waitbutton
	closetext
	end

TrainerTwinsLeaandpia1:
	trainer EVENT_BEAT_TWINS_LEA_AND_PIA, TWINS, LEAANDPIA1, TwinsLeaandpia1SeenText, TwinsLeaandpia1BeatenText, 0, TwinsLeaandpia1Script

TwinsLeaandpia1Script:
	end_if_just_battled
	opentext
	writetext TwinsLeaandpia1AfterText
	waitbutton
	closetext
	end

TrainerTwinsLeaandpia2:
	trainer EVENT_BEAT_TWINS_LEA_AND_PIA, TWINS, LEAANDPIA1, TwinsLeaandpia2SeenText, TwinsLeaandpia2BeatenText, 0, TwinsLeaandpia2Script

TwinsLeaandpia2Script:
	end_if_just_battled
	opentext
	writetext TwinsLeaandpia2AfterText
	waitbutton
	closetext
	end

SilverScript_0x18c97e:
	playmusic MUSIC_RIVAL_ENCOUNTER
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iftrue .SilverTalkAgain
	checkevent EVENT_GOT_RIVALS_EGG
	iftrue .SilverTalk
	writetext SilverText_Training1
	waitbutton
	writetext SilverText_GiveEgg
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
	farwritetext UnknownText_0x1bdfa5
	playsound SFX_GET_EGG_FROM_DAYCARE_LADY
	waitsfx
	writetext SilverText_DescribeEgg
	waitbutton
	closetext
	setevent EVENT_GOT_RIVALS_EGG
	setevent EVENT_GAVE_KURT_APRICORNS
	domaptrigger ELMS_LAB, $7
	special RestartMapMusic
	end

.PartyFull:
	writetext SilverText_PartyFull
	waitbutton
	closetext
	end

.SilverTalk:
	writetext SilverText_Training1
	waitbutton
	closetext
	setevent EVENT_GAVE_KURT_APRICORNS
	special RestartMapMusic
	end

.SilverTalkAgain:
	writetext SilverText_Training2
	waitbutton
	closetext
	special RestartMapMusic
	end

MapDragonsDenB1FSignpost0Script:
	jumptext DragonShrineSignpostText

DragonsDenB1FDragonFang:
	itemball DRAGON_FANG

DragonsDenB1FCalcium:
	itemball CALCIUM

DragonsDenB1FMaxElixer:
	itemball MAX_ELIXER

DragonsDenB1FHiddenRevive:
	dwb EVENT_DRAGONS_DEN_B1F_HIDDEN_REVIVE, REVIVE

DragonsDenB1FHiddenMaxPotion:
	dwb EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_POTION, MAX_POTION

DragonsDenB1FHiddenMaxElixer:
	dwb EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_ELIXER, MAX_ELIXER

MovementDragonsDen_ClairWalksToYou:
	slow_step_right
	slow_step_right
	slow_step_right
	slow_step_right
	step_end

MovementDragonsDen_ClairWalksAway:
	slow_step_left
	slow_step_left
	slow_step_left
	slow_step_left
	step_end

ClairText_Wait:
	text "Wait!"
	done

ClairText_GiveDragonbreathDragonDen:
	text "Clair: I'm sorry"
	line "about this."

	para "Here, take this as"
	line "my apology."
	done

ClairText_DescribeDragonbreathDragonDen:
	text "That contains"
	line "DragonBreath."

	para "No, it doesn't"
	line "have anything to"
	cont "do with my breath."

	para "If you don't want"
	line "it, you don't have"
	cont "to take it."
	done

ClairText_NoRoom:
	text "Oh? You don't have"
	line "any room for this."

	para "I'm going back to"
	line "the Gym, so make"

	para "room, then come"
	line "see me there."
	done

ClairText_WhatsTheMatterDragonDen:
	text "Clair: What's the"
	line "matter? Aren't you"

	para "going on to the"
	line "#mon League?"

	para "Do you know how to"
	line "get there?"

	para "From here, go to"
	line "New Bark Town."

	para "Then Surf east to"
	line "#mon League."

	para "The route there is"
	line "very tough."

	para "Don't you dare"
	line "lose at the #-"
	cont "mon League!"

	para "If you do, I'll"
	line "feel even worse"

	para "about having lost"
	line "to you!"

	para "Give it everything"
	line "you've got."
	done

DragonShrineSignpostText:
	text "Dragon Shrine"

	para "A shrine honoring"
	line "the dragon #mon"

	para "said to have lived"
	line "in Dragon's Den."
	done

SilverText_GiveEgg:
	text "…"
	line "Listen."

	para "The Pokemon I…"
	line "took from the Lab…"

	para "It had an Egg."
	line "I don't need it."
	cont "Here. Take it."
	done

SilverText_DescribeEgg:
	text "Humph. Are you"
	line "through here?"

	para "Then stay out of"
	line "my way."
	done

SilverText_PartyFull:
	text "Humph. You don't"
	line "have any room…"
	done

SilverText_Training1:
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

SilverText_Training2:
	text "…"

	para "Whew…"

	para "Learn to stay out"
	line "of my way…"
	done

DragonTamerDarinSeenText:
	text "You! How dare you"
	line "enter uninvited!"
	done

DragonTamerDarinBeatenText:
	text "S-strong!"
	done

DragonTamerDarinAfterText:
	text "The Shrine ahead"
	line "is home to the"

	para "Master of our"
	line "dragon-user clan."

	para "You're not allowed"
	line "to just go in!"
	done

DragonTamerAdamSeenText:
	text "You shouldn't be"
	line "in here!"
	done

DragonTamerAdamBeatenText:
	text "No! I was"
	line "defeated!"
	done

DragonTamerAdamAfterText:
	text "Not even the power"
	line "of dragons could"
	cont "stop you."

	para "You may be the"
	line "kind of trainer"

	para "our Master is"
	line "looking for."
	done

AceDuoDanandcara1SeenText:
	text "Dan: I may not"
	line "use dragons, but"
	cont "I'm still strong!"
	done

AceDuoDanandcara1BeatenText:
	text "Dan: You were"
	line "even stronger!"
	done

AceDuoDanandcara1AfterText:
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

AceDuoDanandcara2SeenText:
	text "Cara: Do you want"
	line "to train dragons"
	cont "too?"
	done

AceDuoDanandcara2BeatenText:
	text "Cara: Oh yikes,"
	line "I lost!"
	done

AceDuoDanandcara2AfterText:
	text "Cara: Dragons are"
	line "difficult to"

	para "raise, and very"
	line "powerful."

	para "They're not for"
	line "everyone."
	done

TwinsLeaandpia1SeenText:
	text "It's a stranger we"
	line "don't know."
	done

TwinsLeaandpia1BeatenText:
	text "Ouchies."
	done

TwinsLeaandpia1AfterText:
	text "It was like having"
	line "to battle Lance."
	done

TwinsLeaandpia2SeenText:
	text "Who are you?"
	done

TwinsLeaandpia2BeatenText:
	text "Meanie."
	done

TwinsLeaandpia2AfterText:
	text "We'll tell on you."

	para "Master will be"
	line "angry with you."
	done

DragonsDenB1F_MapEventHeader:
.Warps:
	db 2
	warp_def $3, $14, 3, DRAGONS_DEN_1F
	warp_def $1d, $13, 1, DRAGON_SHRINE

.XYTriggers:
	db 1
	xy_trigger 1, $1e, $13, DragonsDenB1F_ClairTrigger

.Signposts:
	db 4
	signpost 24, 18, SIGNPOST_READ, MapDragonsDenB1FSignpost0Script
	signpost 29, 33, SIGNPOST_ITEM, DragonsDenB1FHiddenRevive
	signpost 17, 21, SIGNPOST_ITEM, DragonsDenB1FHiddenMaxPotion
	signpost 15, 31, SIGNPOST_ITEM, DragonsDenB1FHiddenMaxElixer

.PersonEvents:
	db 11
	person_event SPRITE_CLAIR, 30, 14, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_DRAGONS_DEN_CLAIR
	person_event SPRITE_SILVER, 23, 20, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SilverScript_0x18c97e, EVENT_RIVAL_DRAGONS_DEN
	person_event SPRITE_DRAGON_TAMER, 8, 20, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 4, TrainerDragonTamerDarin, -1
	person_event SPRITE_DRAGON_TAMER, 8, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerDragonTamerAdam, -1
	person_event SPRITE_COOLTRAINER_M, 17, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoDanandcara1, -1
	person_event SPRITE_COOLTRAINER_F, 18, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoDanandcara2, -1
	person_event SPRITE_TWIN, 29, 30, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerTwinsLeaandpia1, -1
	person_event SPRITE_TWIN, 29, 31, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerTwinsLeaandpia2, -1
	person_event SPRITE_BALL_CUT_FRUIT, 16, 35, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, DragonsDenB1FDragonFang, EVENT_DRAGONS_DEN_B1F_DRAGON_FANG
	person_event SPRITE_BALL_CUT_FRUIT, 4, 30, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, DragonsDenB1FCalcium, EVENT_DRAGONS_DEN_B1F_CALCIUM
	person_event SPRITE_BALL_CUT_FRUIT, 20, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, DragonsDenB1FMaxElixer, EVENT_DRAGONS_DEN_B1F_MAX_ELIXER
