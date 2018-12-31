Route44_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route44_MapEventHeader:

.Warps: db 1
	warp_def 7, 56, 1, ICE_PATH_1F

.XYTriggers: db 0

.Signposts: db 3
	signpost 7, 53, SIGNPOST_JUMPTEXT, Route44Sign1Text
	signpost 10, 6, SIGNPOST_JUMPTEXT, Route44Sign2Text
	signpost 9, 32, SIGNPOST_ITEM + ELIXER, EVENT_ROUTE_44_HIDDEN_ELIXER

.PersonEvents: db 12
	person_event SPRITE_VETERAN_M, 8, 32, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, Route44VeteranmScript, -1
	person_event SPRITE_FISHER, 3, 35, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherWilton1, -1
	person_event SPRITE_FISHER, 13, 19, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherEdgar, -1
	person_event SPRITE_YOUNGSTER, 9, 10, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPsychicPhil, -1
	person_event SPRITE_SUPER_NERD, 2, 43, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPokemaniacZach, -1
	person_event SPRITE_YOUNGSTER, 5, 51, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerBird_keeperVance1, -1
	person_event SPRITE_COOLTRAINER_M, 15, 41, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 5, TrainerCooltrainermAllen, -1
	person_event SPRITE_COOLTRAINER_F, 14, 31, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 5, TrainerCooltrainerfCybil, -1
	fruittree_event 5, 9, FRUITTREE_ROUTE_44, ASPEAR_BERRY
	itemball_event 8, 30, MAX_REVIVE, 1, EVENT_ROUTE_44_MAX_REVIVE
	itemball_event 4, 45, ULTRA_BALL, 1, EVENT_ROUTE_44_ULTRA_BALL
	itemball_event 9, 14, MAX_REPEL, 1, EVENT_ROUTE_44_MAX_REPEL

const_value set 1
	const ROUTE44_VETERAN_M

Route44VeteranmScript:
	checkevent EVENT_GOT_ROCKY_HELMET_FROM_ROUTE_44_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	checkevent EVENT_BEAT_VETERANM_BARKHORN
	iftrue .Beaten
	checkevent EVENT_BEAT_BIRD_KEEPER_VANCE
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_PSYCHIC_PHIL
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_FISHER_WILTON
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_FISHER_EDGAR
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_COOLTRAINERF_CYBIL
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_POKEMANIAC_ZACH
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_COOLTRAINERM_ALLEN
	iffalse_jumptext .IntroText
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE44_VETERAN_M
	loadtrainer VETERANM, BARKHORN
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_VETERANM_BARKHORN
.Beaten:
	opentext
	writetext .AfterText1
	buttonsound
	verbosegiveitem ROCKY_HELMET
	iffalse_endtext
	setevent EVENT_GOT_ROCKY_HELMET_FROM_ROUTE_44_LEADER
	thisopenedtext

.AfterText2:
	text "You're a very"
	line "quiet person."

	para "Has anybody told"
	line "you that before?"
	done

.IntroText:
	text "My #mon are"
	line "wearing Rocky"
	cont "Helmets."

	para "Want to challenge"
	line "them?"

	para "Okay, then you've"
	line "got to beat every"

	para "trainer on this"
	line "route first."
	done

.QuestionText:
	text "I saw your"
	line "battles."

	para "Your #mon are"
	line "really tough."

	para "Are you ready?"
	done

.RefusedText:
	text "You beat Team"
	line "Rocket and you're"
	cont "scared of me?"

	para "Do I look that"
	line "scary?"
	done

.SeenText:
	text "I'll show you the"
	line "power of my Rocky"
	cont "Helmets!"
	done

.BeatenText:
	text "Bah. These Helmets"
	line "weren't enough."
	done

.AfterText1:
	text "You're really"
	line "strong for someone"
	cont "so young."
	cont "Keep it up!"

	para "Take one of these"
	line "Rocky Helmets."

	para "You can use it as"
	line "well as me."
	done

TrainerBird_keeperVance1:
	trainer EVENT_BEAT_BIRD_KEEPER_VANCE, BIRD_KEEPER, VANCE1, Bird_keeperVance1SeenText, Bird_keeperVance1BeatenText, 0, Bird_keeperVance1Script

Bird_keeperVance1Script:
	writecode VAR_CALLERID, PHONE_BIRDKEEPER_VANCE
	opentext
	checkflag ENGINE_VANCE
	iftrue UnknownScript_0x19d86a
	checkcellnum PHONE_BIRDKEEPER_VANCE
	iftrue UnknownScript_0x19d8eb
	checkevent EVENT_VANCE_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x19d853
	writetext UnknownText_0x19dbf3
	buttonsound
	setevent EVENT_VANCE_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x19d8df
	jump UnknownScript_0x19d856

UnknownScript_0x19d853:
	scall UnknownScript_0x19d8e3
UnknownScript_0x19d856:
	askforphonenumber PHONE_BIRDKEEPER_VANCE
	if_equal $1, UnknownScript_0x19d8f3
	if_equal $2, UnknownScript_0x19d8ef
	trainertotext BIRD_KEEPER, VANCE1, $0
	scall UnknownScript_0x19d8e7
	jump UnknownScript_0x19d8eb

UnknownScript_0x19d86a:
	scall UnknownScript_0x19d8f7
	winlosstext Bird_keeperVance1BeatenText, 0
	copybytetovar wVanceFightCount
	if_equal 2, .Fight2
	if_equal 1, .Fight1
	if_equal 0, .LoadFight0
.Fight2:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer BIRD_KEEPER, VANCE1
	startbattle
	reloadmapafterbattle
	loadvar wVanceFightCount, 1
	clearflag ENGINE_VANCE
	end

.LoadFight1:
	loadtrainer BIRD_KEEPER, VANCE2
	startbattle
	reloadmapafterbattle
	loadvar wVanceFightCount, 2
	clearflag ENGINE_VANCE
	end

.LoadFight2:
	loadtrainer BIRD_KEEPER, VANCE3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_VANCE
	checkevent EVENT_VANCE_CARBOS
	iftrue UnknownScript_0x19d8cb
	checkevent EVENT_GOT_CARBOS_FROM_VANCE
	iftrue UnknownScript_0x19d8ca
	scall UnknownScript_0x19d90a
	verbosegiveitem CARBOS
	iffalse UnknownScript_0x19d903
	setevent EVENT_GOT_CARBOS_FROM_VANCE
	jump UnknownScript_0x19d8eb

UnknownScript_0x19d8ca:
	end

UnknownScript_0x19d8cb:
	opentext
	writetext UnknownText_0x19dc67
	waitbutton
	verbosegiveitem CARBOS
	iffalse UnknownScript_0x19d903
	clearevent EVENT_VANCE_CARBOS
	setevent EVENT_GOT_CARBOS_FROM_VANCE
	jump UnknownScript_0x19d8eb

UnknownScript_0x19d8df:
	jumpstd asknumber1m
	end

UnknownScript_0x19d8e3:
	jumpstd asknumber2m
	end

UnknownScript_0x19d8e7:
	jumpstd registerednumberm
	end

UnknownScript_0x19d8eb:
	jumpstd numberacceptedm
	end

UnknownScript_0x19d8ef:
	jumpstd numberdeclinedm
	end

UnknownScript_0x19d8f3:
	jumpstd phonefullm
	end

UnknownScript_0x19d8f7:
	jumpstd rematchm
	end

UnknownScript_0x19d8fb:
	jumpstd giftm
	end

UnknownScript_0x19d8ff:
	jumpstd packfullm
	end

UnknownScript_0x19d903:
	setevent EVENT_VANCE_CARBOS
	jumpstd packfullm
	end

UnknownScript_0x19d90a:
	jumpstd rematchgiftm
	end

TrainerPsychicPhil:
	trainer EVENT_BEAT_PSYCHIC_PHIL, PSYCHIC_T, PHIL, PsychicPhilSeenText, PsychicPhilBeatenText, 0, PsychicPhilScript

PsychicPhilScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19dcfc

TrainerFisherWilton1:
	trainer EVENT_BEAT_FISHER_WILTON, FISHER, WILTON1, FisherWilton1SeenText, FisherWilton1BeatenText, 0, FisherWilton1Script

FisherWilton1Script:
	writecode VAR_CALLERID, PHONE_FISHER_WILTON
	opentext
	checkflag ENGINE_WILTON
	iftrue UnknownScript_0x19d96e
	checkflag ENGINE_WILTON_HAS_ITEM
	iftrue UnknownScript_0x19d9b4
	checkcellnum PHONE_FISHER_WILTON
	iftrue UnknownScript_0x19d8eb
	checkevent EVENT_WILTON_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x19d957
	checkunits
	iftrue .metric
	writetext UnknownText_0x19daa8_Imperial
	jump .ok
.metric
	writetext UnknownText_0x19daa8_Metric
.ok
	buttonsound
	setevent EVENT_WILTON_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x19d8df
	jump UnknownScript_0x19d95a

UnknownScript_0x19d957:
	scall UnknownScript_0x19d8e3
UnknownScript_0x19d95a:
	askforphonenumber PHONE_FISHER_WILTON
	if_equal $1, UnknownScript_0x19d8f3
	if_equal $2, UnknownScript_0x19d8ef
	trainertotext FISHER, WILTON1, $0
	scall UnknownScript_0x19d8e7
	jump UnknownScript_0x19d8eb

UnknownScript_0x19d96e:
	scall UnknownScript_0x19d8f7
	winlosstext FisherWilton1BeatenText, 0
	copybytetovar wWiltonFightCount
	if_equal 2, .Fight2
	if_equal 1, .Fight1
	if_equal 0, .LoadFight0
.Fight2:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer FISHER, WILTON1
	startbattle
	reloadmapafterbattle
	loadvar wWiltonFightCount, 1
	clearflag ENGINE_WILTON
	end

.LoadFight1:
	loadtrainer FISHER, WILTON2
	startbattle
	reloadmapafterbattle
	loadvar wWiltonFightCount, 2
	clearflag ENGINE_WILTON
	end

.LoadFight2:
	loadtrainer FISHER, WILTON3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WILTON
	end

UnknownScript_0x19d9b4:
	scall UnknownScript_0x19d8fb
	checkevent EVENT_WILTON_HAS_ULTRA_BALL
	iftrue UnknownScript_0x19d9c9
	checkevent EVENT_WILTON_HAS_GREAT_BALL
	iftrue UnknownScript_0x19d9d2
	checkevent EVENT_WILTON_HAS_POKE_BALL
	iftrue UnknownScript_0x19d9db
UnknownScript_0x19d9c9:
	verbosegiveitem ULTRA_BALL
	iffalse UnknownScript_0x19d9e7
	jump UnknownScript_0x19d9e1

UnknownScript_0x19d9d2:
	verbosegiveitem GREAT_BALL
	iffalse UnknownScript_0x19d9e7
	jump UnknownScript_0x19d9e1

UnknownScript_0x19d9db:
	verbosegiveitem POKE_BALL
	iffalse UnknownScript_0x19d9e7
UnknownScript_0x19d9e1:
	clearflag ENGINE_WILTON_HAS_ITEM
	jump UnknownScript_0x19d8eb

UnknownScript_0x19d9e7:
	jump UnknownScript_0x19d8ff

TrainerFisherEdgar:
	trainer EVENT_BEAT_FISHER_EDGAR, FISHER, EDGAR, FisherEdgarSeenText, FisherEdgarBeatenText, 0, FisherEdgarScript

FisherEdgarScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19db6f

TrainerCooltrainerfCybil:
	trainer EVENT_BEAT_COOLTRAINERF_CYBIL, COOLTRAINERF, CYBIL, CooltrainerfCybilSeenText, CooltrainerfCybilBeatenText, 0, CooltrainerfCybilScript

CooltrainerfCybilScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19df4d

TrainerPokemaniacZach:
	trainer EVENT_BEAT_POKEMANIAC_ZACH, POKEMANIAC, ZACH, PokemaniacZachSeenText, PokemaniacZachBeatenText, 0, PokemaniacZachScript

PokemaniacZachScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19dd7e

TrainerCooltrainermAllen:
	trainer EVENT_BEAT_COOLTRAINERM_ALLEN, COOLTRAINERM, ALLEN, CooltrainermAllenSeenText, CooltrainermAllenBeatenText, 0, CooltrainermAllenScript

CooltrainermAllenScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19de66

FisherWilton1SeenText:
	text "Aack! You made me"
	line "lose a Poliwag!"

	para "What are you going"
	line "to do about it?"
	done

FisherWilton1BeatenText:
	text "Just forget about"
	line "it."
	done

UnknownText_0x19daa8_Imperial:
	text "That Poliwag that"
	line "got away…"
	cont "It was huge."

	para "I swear it must've"
	line "been 16 feet long!"
	done

UnknownText_0x19daa8_Metric:
	text "That Poliwag that"
	line "got away…"
	cont "It was huge."

	para "I swear it must've"
	line "been five meters"
	cont "long!"
	done

FisherEdgarSeenText:
	text "I fish until I"
	line "can't anymore."

	para "I also battle"
	line "until I drop."

	para "That's my"
	line "relationship"
	cont "with my #mon."
	done

FisherEdgarBeatenText:
	text "Hmmmm…"
	line "This isn't right."
	done

UnknownText_0x19db6f:
	text "That's 100 wins"
	line "to 101 losses."

	para "I won't battle"
	line "again for a while."
	done

Bird_keeperVance1SeenText:
	text "Do you know about"
	line "the legendary bird"
	cont "#mon?"
	done

Bird_keeperVance1BeatenText:
	text "Whew! You're hot"
	line "stuff."
	done

UnknownText_0x19dbf3:
	text "Articuno, Zapdos"
	line "and Moltres are"

	para "the three legend-"
	line "ary bird #mon."

	para "I heard there are"
	line "other legendary"
	cont "birds, though."
	done

UnknownText_0x19dc67:
	text "Why can't I ever"
	line "beat you?"

	para "Oh yeah, here you"
	line "go. It's that gift"

	para "I couldn't give"
	line "you last time."
	done

PsychicPhilSeenText:
	text "I'm gonna win,"
	line "for sure!"
	done

PsychicPhilBeatenText:
	text "Arrgh… That's a"
	line "shocking loss…"
	done

UnknownText_0x19dcfc:
	text "It's important to"
	line "have conviction"
	cont "on your side."
	done

PokemaniacZachSeenText:
	text "I'll do anything"
	line "to get my hands on"
	cont "rare #mon!"
	done

PokemaniacZachBeatenText:
	text "Oooh, your #mon"
	line "are so appealing."
	done

UnknownText_0x19dd7e:
	text "If a #mon has"
	line "different colors"

	para "from usual, it's"
	line "more valuable."

	para "What? You mean"
	line "that's not true?"
	done

CooltrainermAllenSeenText:
	text "I can tell you're"
	line "a good trainer by"
	cont "looking at you."

	para "I'm good at #-"
	line "mon, and I can see"
	cont "that you are too."
	done

CooltrainermAllenBeatenText:
	text "Tch! It's a total"
	line "loss on my part."
	done

UnknownText_0x19de66:
	text "Wow. You have a"
	line "lot of Badges."

	para "No wonder you're"
	line "so tough."

	para "I wonder if"
	line "Ecruteak Gym's"

	para "Morty is still in"
	line "training?"

	para "He really hammered"
	line "me."
	done

CooltrainerfCybilSeenText:
	text "You look strong."

	para "Good trainers seek"
	line "tough opponents"
	cont "instinctively."
	done

CooltrainerfCybilBeatenText:
	text "Nope! This won't"
	line "do at all."
	done

UnknownText_0x19df4d:
	text "We all get better"
	line "by experiencing"
	cont "many battles."

	para "I battled a lot to"
	line "become what I am"
	cont "today--an elite."
	done

Route44Sign1Text:
	text "Route 44"
	line "Ice Path Ahead"
	done

Route44Sign2Text:
	text "Route 44"

	para "Mahogany Town -"
	line "Blackthorn City"
	done
