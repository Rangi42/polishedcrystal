Route27_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 33,  7, ROUTE_27_REST_HOUSE, 1
	warp_event 26,  5, TOHJO_FALLS, 1
	warp_event 36,  5, TOHJO_FALLS, 2

	def_coord_events
	coord_event 18, 10, 0, FirstStepIntoKantoLeftScene
	coord_event 19, 10, 0, FirstStepIntoKantoRightScene

	def_bg_events
	bg_event 25,  7, BGEVENT_JUMPTEXT, TohjoFallsSignText

	def_object_events
	object_event 48, 12, SPRITE_VETERAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route27VeteranfScript, -1
	object_event 21, 10, SPRITE_FAT_GUY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route27FisherText, -1
	object_event 48,  7, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerCooltrainermBlake, -1
	object_event 58,  6, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoJakeandbri1, -1
	object_event 59,  6, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoJakeandbri2, -1
	object_event 72, 10, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 4, TrainerCooltrainerfReena, -1
	object_event 37,  6, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerCooltrainerfMegan, -1
	object_event 65,  7, SPRITE_PSYCHIC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPsychicGilbert, -1
	object_event 58, 13, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerBird_keeperJose1, -1
	itemball_event 53, 12, RARE_CANDY, 1, EVENT_ROUTE_27_RARE_CANDY
	itemball_event 71,  4, DESTINY_KNOT, 1, EVENT_ROUTE_27_DESTINY_KNOT
	fruittree_event 60, 12, FRUITTREE_ROUTE_27, LUM_BERRY, PAL_NPC_GREEN

	object_const_def
	const ROUTE27_VETERAN_F
	const ROUTE27_FISHER

FirstStepIntoKantoLeftScene:
	turnobject ROUTE27_FISHER, LEFT
	showemote EMOTE_SHOCK, ROUTE27_FISHER, 15
	applymovement ROUTE27_FISHER, Route27FisherStepLeftTwiceMovement
	jump FirstStepIntoKantoScene_Continue

FirstStepIntoKantoRightScene:
	turnobject ROUTE27_FISHER, LEFT
	showemote EMOTE_SHOCK, ROUTE27_FISHER, 15
	applyonemovement ROUTE27_FISHER, step_left
FirstStepIntoKantoScene_Continue:
	turnobject PLAYER, RIGHT
	opentext
	writetext Route27FisherHeyText
	buttonsound
	writetext Route27FisherText
	waitbutton
	closetext
	setscene $1
	end

Route27VeteranfScript:
	checkevent EVENT_GOT_CHOICE_SPECS_FROM_ROUTE_27_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	checkevent EVENT_BEAT_VETERANF_LITVYAK
	iftrue .Beaten
	checkevent EVENT_BEAT_PSYCHIC_GILBERT
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BIRD_KEEPER_JOSE
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_COOLTRAINERM_BLAKE
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_ACE_DUO_JAKE_AND_BRI
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_COOLTRAINERF_REENA
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_COOLTRAINERF_MEGAN
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_DRAGON_TAMER_KAZU
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_COOLTRAINERM_GAVEN
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_COOLTRAINERF_JOYCE
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_COOLTRAINERF_BETH
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_PSYCHIC_RICHARD
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BATTLE_GIRL_RONDA
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_FISHER_SCOTT
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_DRAGON_TAMER_ERICK
	iffalse_jumptext .IntroText
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE27_VETERAN_F
	loadtrainer VETERANF, LITVYAK
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_VETERANF_LITVYAK
.Beaten:
	opentext
	writetext .AfterText1
	buttonsound
	verbosegiveitem CHOICE_SPECS
	iffalse_endtext
	setevent EVENT_GOT_CHOICE_SPECS_FROM_ROUTE_27_LEADER
	jumpthisopenedtext

.AfterText2:
	text "Good luck! Say"
	line "hello to Lance"
	cont "for me."
	done

.IntroText:
	text "Hm! If you're here,"
	line "then you must be"

	para "heading for the"
	line "#mon League."

	para "Want to train"
	line "with me?"

	para "Then beat everyone"
	line "else on Routes 26"
	cont "and 27."

	para "I'll wait for you"
	line "here."
	done

.QuestionText:
	text "Hm. You beat the"
	line "rest faster than"
	cont "I expected."

	para "Let's train."
	done

.RefusedText:
	text "It's okay."
	line "I can wait."
	done

.SeenText:
	text "My #mon are"
	line "all wearing"
	cont "Choice Specs."

	para "They may look"
	line "weird, but they"
	cont "are powerful."
	done

.BeatenText:
	text "You're ready for"
	line "the #mon"
	cont "League, I'm sure!"
	done

.AfterText1:
	text "Choice Specs will"
	line "boost a #mon's"
	cont "Special Attack,"

	para "but it can only"
	line "use one move."

	para "Take a pair"
	line "yourself."
	done

GenericTrainerPsychicGilbert:
	generictrainer PSYCHIC_T, GILBERT, EVENT_BEAT_PSYCHIC_GILBERT, PsychicGilbertSeenText, PsychicGilbertBeatenText

	text "With your skills,"
	line "you'll do well at"
	cont "the League."

	para "That's what my"
	line "premonition says."
	done

TrainerBird_keeperJose1:
	trainer BIRD_KEEPER, JOSE1, EVENT_BEAT_BIRD_KEEPER_JOSE, Bird_keeperJose1SeenText, Bird_keeperJose1BeatenText, 0, Bird_keeperJose1Script

Bird_keeperJose1Script:
	writecode VAR_CALLERID, PHONE_BIRDKEEPER_JOSE
	opentext
	checkflag ENGINE_JOSE
	iftrue UnknownScript_0x1a08ff
	checkflag ENGINE_JOSE_HAS_STAR_PIECE
	iftrue UnknownScript_0x1a0945
	checkcellnum PHONE_BIRDKEEPER_JOSE
	iftrue UnknownScript_0x1a0963
	checkevent EVENT_JOSE_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x1a08e8
	writetext BirdKeeperJose2AfterBattleText
	buttonsound
	setevent EVENT_JOSE_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x1a0957
	jump UnknownScript_0x1a08eb

UnknownScript_0x1a08e8:
	scall UnknownScript_0x1a095b
UnknownScript_0x1a08eb:
	askforphonenumber PHONE_BIRDKEEPER_JOSE
	ifequal $1, UnknownScript_0x1a096b
	ifequal $2, UnknownScript_0x1a0967
	trainertotext BIRD_KEEPER, JOSE1, $0
	scall UnknownScript_0x1a095f
	jump UnknownScript_0x1a0963

UnknownScript_0x1a08ff:
	scall UnknownScript_0x1a096f
	winlosstext Bird_keeperJose1BeatenText, 0
	copybytetovar wJoseFightCount
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight2:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer BIRD_KEEPER, JOSE1
	startbattle
	reloadmapafterbattle
	loadvar wJoseFightCount, 1
	clearflag ENGINE_JOSE
	end

.LoadFight1:
	loadtrainer BIRD_KEEPER, JOSE2
	startbattle
	reloadmapafterbattle
	loadvar wJoseFightCount, 2
	clearflag ENGINE_JOSE
	end

.LoadFight2:
	loadtrainer BIRD_KEEPER, JOSE3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JOSE
	end

UnknownScript_0x1a0945:
	scall UnknownScript_0x1a0973
	verbosegiveitem STAR_PIECE
	iffalse UnknownScript_0x1a0954
	clearflag ENGINE_JOSE_HAS_STAR_PIECE
	jump UnknownScript_0x1a0963

UnknownScript_0x1a0954:
	jump UnknownScript_0x1a0977

UnknownScript_0x1a0957:
	jumpstd asknumber1m

UnknownScript_0x1a095b:
	jumpstd asknumber2m

UnknownScript_0x1a095f:
	jumpstd registerednumberm

UnknownScript_0x1a0963:
	jumpstd numberacceptedm

UnknownScript_0x1a0967:
	jumpstd numberdeclinedm

UnknownScript_0x1a096b:
	jumpstd phonefullm

UnknownScript_0x1a096f:
	jumpstd rematchm

UnknownScript_0x1a0973:
	jumpstd giftm

UnknownScript_0x1a0977:
	jumpstd packfullm

GenericTrainerCooltrainermBlake:
	generictrainer COOLTRAINERM, BLAKE, EVENT_BEAT_COOLTRAINERM_BLAKE, CooltrainermBlakeSeenText, CooltrainermBlakeBeatenText

	text "If you prevail on"
	line "this harsh trek,"

	para "the truth will be"
	line "revealed!"

	para "Heh, sorry, I just"
	line "wanted to say"
	cont "something cool."
	done

GenericTrainerAceDuoJakeandbri1:
	generictrainer ACE_DUO, JAKEANDBRI1, EVENT_BEAT_ACE_DUO_JAKE_AND_BRI, AceDuoJakeandbri1SeenText, AceDuoJakeandbri1BeatenText

	text "Jake: A good"
	line "trainer can recog-"

	para "nize other good"
	line "trainers."
	done

GenericTrainerAceDuoJakeandbri2:
	generictrainer ACE_DUO, JAKEANDBRI2, EVENT_BEAT_ACE_DUO_JAKE_AND_BRI, AceDuoJakeandbri2SeenText, AceDuoJakeandbri2BeatenText

	text "Bri: Good trainers"
	line "also know how to"

	para "fight alongside"
	line "each other."
	done

TrainerCooltrainerfReena:
	trainer COOLTRAINERF, REENA1, EVENT_BEAT_COOLTRAINERF_REENA, CooltrainerfReena1SeenText, CooltrainerfReena1BeatenText, 0, CooltrainerfReena1Script

CooltrainerfReena1Script:
	writecode VAR_CALLERID, PHONE_COOLTRAINERF_REENA
	opentext
	checkflag ENGINE_REENA
	iftrue UnknownScript_0x1a09e9
	checkcellnum PHONE_COOLTRAINERF_REENA
	iftrue UnknownScript_0x1a0a3b
	checkevent EVENT_REENA_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x1a09d2
	writetext CooltrainerfReenaAfterBattleText
	buttonsound
	setevent EVENT_REENA_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x1a0a2f
	jump UnknownScript_0x1a09d5

UnknownScript_0x1a09d2:
	scall UnknownScript_0x1a0a33
UnknownScript_0x1a09d5:
	askforphonenumber PHONE_COOLTRAINERF_REENA
	ifequal $1, UnknownScript_0x1a0a43
	ifequal $2, UnknownScript_0x1a0a3f
	trainertotext COOLTRAINERF, REENA1, $0
	scall UnknownScript_0x1a0a37
	jump UnknownScript_0x1a0a3b

UnknownScript_0x1a09e9:
	scall UnknownScript_0x1a0a47
	winlosstext CooltrainerfReena1BeatenText, 0
	copybytetovar wReenaFightCount
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight2:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer COOLTRAINERF, REENA1
	startbattle
	reloadmapafterbattle
	loadvar wReenaFightCount, 1
	clearflag ENGINE_REENA
	end

.LoadFight1:
	loadtrainer COOLTRAINERF, REENA2
	startbattle
	reloadmapafterbattle
	loadvar wReenaFightCount, 2
	clearflag ENGINE_REENA
	end

.LoadFight2:
	loadtrainer COOLTRAINERF, REENA3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_REENA
	end

UnknownScript_0x1a0a2f:
	jumpstd asknumber1f

UnknownScript_0x1a0a33:
	jumpstd asknumber2f

UnknownScript_0x1a0a37:
	jumpstd registerednumberf

UnknownScript_0x1a0a3b:
	jumpstd numberacceptedf

UnknownScript_0x1a0a3f:
	jumpstd numberdeclinedf

UnknownScript_0x1a0a43:
	jumpstd phonefullf

UnknownScript_0x1a0a47:
	jumpstd rematchf

GenericTrainerCooltrainerfMegan:
	generictrainer COOLTRAINERF, MEGAN, EVENT_BEAT_COOLTRAINERF_MEGAN, CooltrainerfMeganSeenText, CooltrainerfMeganBeatenText

	text "I'm checking out"
	line "pre- and post-"
	cont "evolution #mon."

	para "Evolution really"
	line "does make #mon"
	cont "stronger."

	para "But evolved forms"
	line "also learn moves"
	cont "later on."
	done

Route27FisherStepLeftTwiceMovement:
	step_left
	step_left
	turn_head_left
	step_end

Route27FisherHeyText:
	text "Hey!"
	done

Route27FisherText:
	text "Do you know what"
	line "you just did?"

	para "You've taken your"
	line "first step into"
	cont "Kanto."

	para "Check your #-"
	line "gear Map and see."
	done

CooltrainermBlakeSeenText:
	text "You look pretty"
	line "strong."
	cont "Let me battle you!"
	done

CooltrainermBlakeBeatenText:
	text "Yow!"
	done

AceDuoJakeandbri1SeenText:
	text "Jake: Hm? You're"
	line "good, aren't you?"
	done

AceDuoJakeandbri1BeatenText:
	text "Jake: Just as I"
	line "thought!"
	done

AceDuoJakeandbri2SeenText:
	text "Bri: The two of"
	line "us together are"
	cont "unstoppable!"
	done

AceDuoJakeandbri2BeatenText:
	text "Bri: Our teamwork"
	line "wasn't enough…"
	done

CooltrainerfReena1SeenText:
	text "You shouldn't"
	line "underestimate the"

	para "wild #mon in"
	line "these parts."
	done

CooltrainerfReena1BeatenText:
	text "Oh! You're much"
	line "too strong!"
	done

CooltrainerfReenaAfterBattleText:
	text "You're just a kid,"
	line "but you're not to"

	para "be underestimated"
	line "either."
	done

CooltrainerfMeganSeenText:
	text "It's rare to see"
	line "anyone come here."

	para "Are you training"
	line "on your own?"
	done

CooltrainerfMeganBeatenText:
	text "Oh! You're really"
	line "strong!"
	done

PsychicGilbertSeenText:
	text "Don't say a thing!"

	para "Let me guess what"
	line "you're thinking."

	para "Mmmmmmm…"

	para "I got it! You're"
	line "on the #mon"
	cont "League challenge!"
	done

PsychicGilbertBeatenText:
	text "You're too much!"
	done

Bird_keeperJose1SeenText:
	text "Tweet! Tweet!"
	line "Tetweet!"
	done

Bird_keeperJose1BeatenText:
	text "Tweet!"
	done

BirdKeeperJose2AfterBattleText:
	text "Bird Keepers like"
	line "me mimic bird"

	para "whistles to com-"
	line "mand #mon."
	done

TohjoFallsSignText:
	text "Tohjo Falls"

	para "The Link Between"
	line "Kanto and Johto"
	done
