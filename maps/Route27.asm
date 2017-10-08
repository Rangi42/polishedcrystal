Route27_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_SPRITES, Route27DragonTamerSprite

Route27_MapEventHeader:

.Warps: db 3
	warp_def 7, 33, 1, ROUTE_27_REST_HOUSE
	warp_def 5, 26, 1, TOHJO_FALLS
	warp_def 5, 36, 2, TOHJO_FALLS

.XYTriggers: db 2
	xy_trigger 0, 10, 18, UnknownScript_0x1a0873
	xy_trigger 0, 10, 19, UnknownScript_0x1a0881

.Signposts: db 1
	signpost 7, 25, SIGNPOST_JUMPTEXT, TohjoFallsSignText

.PersonEvents: db 12
	person_event SPRITE_VETERAN_F, 12, 48, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, Route27VeteranfScript, -1
	person_event SPRITE_FISHER, 10, 21, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a0a71, -1
	person_event SPRITE_COOLTRAINER_M, 7, 48, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerCooltrainermBlake, -1
	person_event SPRITE_COOLTRAINER_M, 6, 58, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoJakeandbri1, -1
	person_event SPRITE_COOLTRAINER_F, 6, 59, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoJakeandbri2, -1
	person_event SPRITE_COOLTRAINER_F, 10, 72, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerCooltrainerfReena, -1
	person_event SPRITE_COOLTRAINER_F, 6, 37, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerCooltrainerfMegan, -1
	person_event SPRITE_YOUNGSTER, 7, 65, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPsychicGilbert, -1
	person_event SPRITE_YOUNGSTER, 13, 58, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBird_keeperJose1, -1
	itemball_event 12, 53, RARE_CANDY, 1, EVENT_ROUTE_27_RARE_CANDY
	itemball_event 4, 71, DESTINY_KNOT, 1, EVENT_ROUTE_27_DESTINY_KNOT
	fruittree_event 12, 60, FRUITTREE_ROUTE_27, LUM_BERRY

const_value set 1
	const ROUTE27_VETERAN_F
	const ROUTE27_FISHER

Route27DragonTamerSprite:
	variablesprite SPRITE_GUIDE_GENT, SPRITE_DRAGON_TAMER
	return

UnknownScript_0x1a0873:
	spriteface ROUTE27_FISHER, LEFT
	showemote EMOTE_SHOCK, ROUTE27_FISHER, 15
	applymovement ROUTE27_FISHER, MovementData_0x1a0a66
	jump UnknownScript_0x1a088c

UnknownScript_0x1a0881:
	spriteface ROUTE27_FISHER, LEFT
	showemote EMOTE_SHOCK, ROUTE27_FISHER, 15
	applyonemovement ROUTE27_FISHER, step_left
UnknownScript_0x1a088c:
	spriteface PLAYER, RIGHT
	opentext
	writetext UnknownText_0x1a0a6b
	buttonsound
	writetext UnknownText_0x1a0a71
	waitbutton
	closetext
	dotrigger $1
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
	thisopenedtext

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

TrainerPsychicGilbert:
	trainer EVENT_BEAT_PSYCHIC_GILBERT, PSYCHIC_T, GILBERT, PsychicGilbertSeenText, PsychicGilbertBeatenText, 0, PsychicGilbertScript

PsychicGilbertScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a0dd2

TrainerBird_keeperJose1:
	trainer EVENT_BEAT_BIRD_KEEPER_JOSE, BIRD_KEEPER, JOSE1, Bird_keeperJose1SeenText, Bird_keeperJose1BeatenText, 0, Bird_keeperJose1Script

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
	writetext UnknownText_0x1a0e42
	buttonsound
	setevent EVENT_JOSE_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x1a0957
	jump UnknownScript_0x1a08eb

UnknownScript_0x1a08e8:
	scall UnknownScript_0x1a095b
UnknownScript_0x1a08eb:
	askforphonenumber PHONE_BIRDKEEPER_JOSE
	if_equal $1, UnknownScript_0x1a096b
	if_equal $2, UnknownScript_0x1a0967
	trainertotext BIRD_KEEPER, JOSE1, $0
	scall UnknownScript_0x1a095f
	jump UnknownScript_0x1a0963

UnknownScript_0x1a08ff:
	scall UnknownScript_0x1a096f
	winlosstext Bird_keeperJose1BeatenText, 0
	copybytetovar wJoseFightCount
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
	end

UnknownScript_0x1a095b:
	jumpstd asknumber2m
	end

UnknownScript_0x1a095f:
	jumpstd registerednumberm
	end

UnknownScript_0x1a0963:
	jumpstd numberacceptedm
	end

UnknownScript_0x1a0967:
	jumpstd numberdeclinedm
	end

UnknownScript_0x1a096b:
	jumpstd phonefullm
	end

UnknownScript_0x1a096f:
	jumpstd rematchm
	end

UnknownScript_0x1a0973:
	jumpstd giftm
	end

UnknownScript_0x1a0977:
	jumpstd packfullm
	end

TrainerCooltrainermBlake:
	trainer EVENT_BEAT_COOLTRAINERM_BLAKE, COOLTRAINERM, BLAKE, CooltrainermBlakeSeenText, CooltrainermBlakeBeatenText, 0, CooltrainermBlakeScript

CooltrainermBlakeScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a0b0b

TrainerAceDuoJakeandbri1:
	trainer EVENT_BEAT_ACE_DUO_JAKE_AND_BRI, ACE_DUO, JAKEANDBRI1, AceDuoJakeandbri1SeenText, AceDuoJakeandbri1BeatenText, 0, AceDuoJakeandbri1Script

AceDuoJakeandbri1Script:
	end_if_just_battled
	jumptextfaceplayer AceDuoJakeandbri1AfterText

TrainerAceDuoJakeandbri2:
	trainer EVENT_BEAT_ACE_DUO_JAKE_AND_BRI, ACE_DUO, JAKEANDBRI2, AceDuoJakeandbri2SeenText, AceDuoJakeandbri2BeatenText, 0, AceDuoJakeandbri2Script

AceDuoJakeandbri2Script:
	end_if_just_battled
	jumptextfaceplayer AceDuoJakeandbri2AfterText

TrainerCooltrainerfReena:
	trainer EVENT_BEAT_COOLTRAINERF_REENA, COOLTRAINERF, REENA1, CooltrainerfReena1SeenText, CooltrainerfReena1BeatenText, 0, CooltrainerfReena1Script

CooltrainerfReena1Script:
	writecode VAR_CALLERID, PHONE_COOLTRAINERF_REENA
	opentext
	checkflag ENGINE_REENA
	iftrue UnknownScript_0x1a09e9
	checkcellnum PHONE_COOLTRAINERF_REENA
	iftrue UnknownScript_0x1a0a3b
	checkevent EVENT_REENA_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x1a09d2
	writetext UnknownText_0x1a0c35
	buttonsound
	setevent EVENT_REENA_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x1a0a2f
	jump UnknownScript_0x1a09d5

UnknownScript_0x1a09d2:
	scall UnknownScript_0x1a0a33
UnknownScript_0x1a09d5:
	askforphonenumber PHONE_COOLTRAINERF_REENA
	if_equal $1, UnknownScript_0x1a0a43
	if_equal $2, UnknownScript_0x1a0a3f
	trainertotext COOLTRAINERF, REENA1, $0
	scall UnknownScript_0x1a0a37
	jump UnknownScript_0x1a0a3b

UnknownScript_0x1a09e9:
	scall UnknownScript_0x1a0a47
	winlosstext CooltrainerfReena1BeatenText, 0
	copybytetovar wReenaFightCount
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
	end

UnknownScript_0x1a0a33:
	jumpstd asknumber2f
	end

UnknownScript_0x1a0a37:
	jumpstd registerednumberf
	end

UnknownScript_0x1a0a3b:
	jumpstd numberacceptedf
	end

UnknownScript_0x1a0a3f:
	jumpstd numberdeclinedf
	end

UnknownScript_0x1a0a43:
	jumpstd phonefullf
	end

UnknownScript_0x1a0a47:
	jumpstd rematchf
	end

TrainerCooltrainerfMegan:
	trainer EVENT_BEAT_COOLTRAINERF_MEGAN, COOLTRAINERF, MEGAN, CooltrainerfMeganSeenText, CooltrainerfMeganBeatenText, 0, CooltrainerfMeganScript

CooltrainerfMeganScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a0cce

MovementData_0x1a0a66:
	step_left
	step_left
	step_end

UnknownText_0x1a0a6b:
	text "Hey!"
	done

UnknownText_0x1a0a71:
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

UnknownText_0x1a0b0b:
	text "If you prevail on"
	line "this harsh trek,"

	para "the truth will be"
	line "revealed!"

	para "Heh, sorry, I just"
	line "wanted to say"
	cont "something cool."
	done

AceDuoJakeandbri1SeenText:
	text "Jake: Hm? You're"
	line "good, aren't you?"
	done

AceDuoJakeandbri1BeatenText:
	text "Jake: Just as I"
	line "thought!"
	done

AceDuoJakeandbri1AfterText:
	text "Jake: A good"
	line "trainer can recog-"

	para "nize other good"
	line "trainers."
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

AceDuoJakeandbri2AfterText:
	text "Bri: Good trainers"
	line "also know how to"

	para "fight alongside"
	line "each other."
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

UnknownText_0x1a0c35:
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

UnknownText_0x1a0cce:
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

UnknownText_0x1a0dd2:
	text "With your skills,"
	line "you'll do well at"
	cont "the League."

	para "That's what my"
	line "premonition says."
	done

Bird_keeperJose1SeenText:
	text "Tweet! Tweet!"
	line "Tetweet!"
	done

Bird_keeperJose1BeatenText:
	text "Tweet!"
	done

UnknownText_0x1a0e42:
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
