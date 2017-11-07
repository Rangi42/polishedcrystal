Route43_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 3
	dbw MAPCALLBACK_NEWMAP, UnknownScript_0x19d051
	dbw MAPCALLBACK_TILES, Route43RainScript
	dbw MAPCALLBACK_OBJECTS, Route43RebattleBreederScript

Route43_MapEventHeader:

.Warps: db 5
	warp_def 51, 9, 1, ROUTE_43_MAHOGANY_GATE
	warp_def 51, 10, 2, ROUTE_43_MAHOGANY_GATE
	warp_def 35, 17, 3, ROUTE_43_GATE
	warp_def 31, 17, 1, ROUTE_43_GATE
	warp_def 31, 18, 2, ROUTE_43_GATE

.XYTriggers: db 0

.Signposts: db 3
	signpost 3, 13, SIGNPOST_JUMPTEXT, Route43Sign1Text
	signpost 49, 11, SIGNPOST_JUMPTEXT, Route43Sign2Text
	signpost 38, 16, SIGNPOST_JUMPTEXT, Route43TrainerTipsText

.PersonEvents: db 13
	person_event SPRITE_LADY, 6, 1, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route43SightseerfScript, -1
	person_event SPRITE_SUPER_NERD, 5, 13, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerPokemaniacBen, -1
	person_event SPRITE_SUPER_NERD, 20, 13, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPokemaniacBrent1, -1
	person_event SPRITE_SUPER_NERD, 7, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerPokemaniacRon, -1
	person_event SPRITE_FISHER, 16, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerFisherMarvin, -1
	person_event SPRITE_LASS, 10, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerPicnickerTiffany1, -1
	person_event SPRITE_YOUNGSTER, 40, 13, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerCamperSpencer, -1
	person_event SPRITE_BREEDER, 32, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerBreederJody, -1
	person_event SPRITE_LASS, 24, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerSrandjrIvyandamy1, -1
	person_event SPRITE_LASS, 25, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerSrandjrIvyandamy2, -1
	cuttree_event 28, 2, EVENT_ROUTE_43_CUT_TREE
	fruittree_event 26, 1, FRUITTREE_ROUTE_43, PERSIM_BERRY
	itemball_event 32, 12, MAX_ETHER, 1, EVENT_ROUTE_43_MAX_ETHER

const_value set 1
	const ROUTE43_SIGHTSEER_F

Route43RebattleBreederScript:
	clearevent EVENT_BEAT_BREEDER_JODY
	return

UnknownScript_0x19d051:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue UnknownScript_0x19d05c
	domaptrigger ROUTE_43_GATE, $0
	return

Route43RainScript:
	special Special_GetOvercastIndex
	if_equal LAKE_OF_RAGE_OVERCAST, .flood
	changemap Route43_BlockData
	return

.flood
	changemap Route43Raining_BlockData
	return

UnknownScript_0x19d05c:
	domaptrigger ROUTE_43_GATE, $1
	return

Route43SightseerfScript:
	checkevent EVENT_GOT_FLAME_ORB_FROM_ROUTE_43_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	checkevent EVENT_BEAT_SIGHTSEERF_LENIE
	iftrue .Beaten
	checkevent EVENT_BEAT_BREEDER_JODY_ONCE
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_SR_AND_JR_IVY_AND_AMY
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_CAMPER_SPENCER
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_POKEMANIAC_BEN
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_POKEMANIAC_BRENT
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_POKEMANIAC_RON
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_FISHER_MARVIN
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_PICNICKER_TIFFANY
	iffalse_jumptext .IntroText
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE43_SIGHTSEER_F
	loadtrainer SIGHTSEERF, LENIE
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_SIGHTSEERF_LENIE
.Beaten:
	opentext
	writetext .AfterText1
	buttonsound
	verbosegiveitem FLAME_ORB
	iffalse_endtext
	setevent EVENT_GOT_FLAME_ORB_FROM_ROUTE_43_LEADER
	thisopenedtext

.AfterText2:
	text "I love visiting"
	line "new places and"

	para "challenging every"
	line "trainer there."

	para "I'll keep looking"
	line "for strong train-"
	cont "ers like you."
	done

.IntroText:
	text "I'm seeking out"
	line "strong trainers"

	para "in Johto, but I"
	line "haven't found any."

	para "Hmmm… You seem"
	line "promising."

	para "I can see it in"
	line "your eyes."

	para "Let's battle--but"
	line "first, I want to"

	para "see you conquer"
	line "this route by"

	para "beating everyone"
	line "else."
	done

.QuestionText:
	text "Excellent! Time to"
	line "test my new stra-"
	cont "tegy…"

	para "Ready for a"
	line "battle?"
	done

.RefusedText:
	text "Aw… I was so"
	line "anxious!"

	para "Don't make me"
	line "wait!"
	done

.SeenText:
	text "Let's see how"
	line "strong Johto's"
	cont "trainers can be."

	para "Face my Flame Orb"
	line "strategy!"
	done

.BeatenText:
	text "Awesome! ♥"
	done

.AfterText1:
	text "Wow! I've finally"
	line "found what I was"
	cont "looking for!"

	para "I'll give you a"
	line "Flame Orb, but"

	para "please be careful"
	line "if you give it to"
	cont "a #mon."
	done

TrainerBreederJody:
	trainer EVENT_BEAT_BREEDER_JODY, BREEDER, JODY, BreederJodySeenText, BreederJodyBeatenText, 0, BreederJodyScript

BreederJodyScript:
	setevent EVENT_BEAT_BREEDER_JODY_ONCE
	end_if_just_battled
	jumptextfaceplayer BreederJodyAfterText

TrainerSrandjrIvyandamy1:
	trainer EVENT_BEAT_SR_AND_JR_IVY_AND_AMY, SR_AND_JR, IVYANDAMY1, SrandjrIvyandamy1SeenText, SrandjrIvyandamy1BeatenText, 0, SrandjrIvyandamy1Script

SrandjrIvyandamy1Script:
	end_if_just_battled
	jumptextfaceplayer SrandjrIvyandamy1AfterText

TrainerSrandjrIvyandamy2:
	trainer EVENT_BEAT_SR_AND_JR_IVY_AND_AMY, SR_AND_JR, IVYANDAMY2, SrandjrIvyandamy2SeenText, SrandjrIvyandamy2BeatenText, 0, SrandjrIvyandamy2Script

SrandjrIvyandamy2Script:
	end_if_just_battled
	jumptextfaceplayer SrandjrIvyandamy2AfterText

TrainerCamperSpencer:
	trainer EVENT_BEAT_CAMPER_SPENCER, CAMPER, SPENCER, CamperSpencerSeenText, CamperSpencerBeatenText, 0, CamperSpencerScript

CamperSpencerScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19d57e

TrainerPokemaniacBen:
	trainer EVENT_BEAT_POKEMANIAC_BEN, POKEMANIAC, BEN, PokemaniacBenSeenText, PokemaniacBenBeatenText, 0, PokemaniacBenScript

PokemaniacBenScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19d2d2

TrainerPokemaniacBrent1:
	trainer EVENT_BEAT_POKEMANIAC_BRENT, POKEMANIAC, BRENT1, PokemaniacBrent1SeenText, PokemaniacBrent1BeatenText, 0, PokemaniacBrent1Script

PokemaniacBrent1Script:
	writecode VAR_CALLERID, PHONE_POKEMANIAC_BRENT
	opentext
	checkflag ENGINE_BRENT
	iftrue UnknownScript_0x19d0cf
	checkcellnum PHONE_POKEMANIAC_BRENT
	iftrue UnknownScript_0x19d138
	checkevent EVENT_BRENT_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x19d0b8
	writetext UnknownText_0x19d359
	buttonsound
	setevent EVENT_BRENT_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x19d12c
	jump UnknownScript_0x19d0bb

UnknownScript_0x19d0b8:
	scall UnknownScript_0x19d130
UnknownScript_0x19d0bb:
	askforphonenumber PHONE_POKEMANIAC_BRENT
	if_equal $1, UnknownScript_0x19d140
	if_equal $2, UnknownScript_0x19d13c
	trainertotext POKEMANIAC, BRENT1, $0
	scall UnknownScript_0x19d134
	jump UnknownScript_0x19d138

UnknownScript_0x19d0cf:
	scall UnknownScript_0x19d144
	winlosstext PokemaniacBrent1BeatenText, 0
	copybytetovar wBrentFightCount
	if_equal 3, .Fight3
	if_equal 2, .Fight2
	if_equal 1, .Fight1
	if_equal 0, .LoadFight0
.Fight3:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight3
.Fight2:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer POKEMANIAC, BRENT1
	startbattle
	reloadmapafterbattle
	loadvar wBrentFightCount, 1
	clearflag ENGINE_BRENT
	end

.LoadFight1:
	loadtrainer POKEMANIAC, BRENT2
	startbattle
	reloadmapafterbattle
	loadvar wBrentFightCount, 2
	clearflag ENGINE_BRENT
	end

.LoadFight2:
	loadtrainer POKEMANIAC, BRENT3
	startbattle
	reloadmapafterbattle
	loadvar wBrentFightCount, 3
	clearflag ENGINE_BRENT
	end

.LoadFight3:
	loadtrainer POKEMANIAC, BRENT4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BRENT
	end

UnknownScript_0x19d12c:
	jumpstd asknumber1m
	end

UnknownScript_0x19d130:
	jumpstd asknumber2m
	end

UnknownScript_0x19d134:
	jumpstd registerednumberm
	end

UnknownScript_0x19d138:
	jumpstd numberacceptedm
	end

UnknownScript_0x19d13c:
	jumpstd numberdeclinedm
	end

UnknownScript_0x19d140:
	jumpstd phonefullm
	end

UnknownScript_0x19d144:
	jumpstd rematchm
	end

TrainerPokemaniacRon:
	trainer EVENT_BEAT_POKEMANIAC_RON, POKEMANIAC, RON, PokemaniacRonSeenText, PokemaniacRonBeatenText, 0, PokemaniacRonScript

PokemaniacRonScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19d3f8

TrainerFisherMarvin:
	trainer EVENT_BEAT_FISHER_MARVIN, FISHER, MARVIN, FisherMarvinSeenText, FisherMarvinBeatenText, 0, FisherMarvinScript

FisherMarvinScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19d4d3

TrainerPicnickerTiffany1:
	trainer EVENT_BEAT_PICNICKER_TIFFANY, PICNICKER, TIFFANY1, PicnickerTiffany1SeenText, PicnickerTiffany1BeatenText, 0, PicnickerTiffany1Script

PicnickerTiffany1Script:
	writecode VAR_CALLERID, PHONE_PICNICKER_TIFFANY
	opentext
	checkflag ENGINE_TIFFANY
	iftrue UnknownScript_0x19d1c1
	checkflag ENGINE_TIFFANY_HAS_PINK_BOW
	iftrue UnknownScript_0x19d21e
	checkcellnum PHONE_PICNICKER_TIFFANY
	iftrue UnknownScript_0x19d245
	checkpoke CLEFAIRY
	iffalse UnknownScript_0x19d233
	checkevent EVENT_TIFFANY_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x19d1aa
	writetext UnknownText_0x19d618
	buttonsound
	setevent EVENT_TIFFANY_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x19d239
	jump UnknownScript_0x19d1ad

UnknownScript_0x19d1aa:
	scall UnknownScript_0x19d23d
UnknownScript_0x19d1ad:
	askforphonenumber PHONE_PICNICKER_TIFFANY
	if_equal $1, UnknownScript_0x19d24d
	if_equal $2, UnknownScript_0x19d249
	trainertotext PICNICKER, TIFFANY1, $0
	scall UnknownScript_0x19d241
	jump UnknownScript_0x19d245

UnknownScript_0x19d1c1:
	scall UnknownScript_0x19d251
	winlosstext PicnickerTiffany1BeatenText, 0
	copybytetovar wTiffanyFightCount
	if_equal 3, .Fight3
	if_equal 2, .Fight2
	if_equal 1, .Fight1
	if_equal 0, .LoadFight0
.Fight3:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight3
.Fight2:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer PICNICKER, TIFFANY1
	startbattle
	reloadmapafterbattle
	loadvar wTiffanyFightCount, 1
	clearflag ENGINE_TIFFANY
	end

.LoadFight1:
	loadtrainer PICNICKER, TIFFANY2
	startbattle
	reloadmapafterbattle
	loadvar wTiffanyFightCount, 2
	clearflag ENGINE_TIFFANY
	end

.LoadFight2:
	loadtrainer PICNICKER, TIFFANY3
	startbattle
	reloadmapafterbattle
	loadvar wTiffanyFightCount, 3
	clearflag ENGINE_TIFFANY
	end

.LoadFight3:
	loadtrainer PICNICKER, TIFFANY4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TIFFANY
	end

UnknownScript_0x19d21e:
	scall UnknownScript_0x19d255
	verbosegiveitem PINK_BOW
	iffalse UnknownScript_0x19d230
	clearflag ENGINE_TIFFANY_HAS_PINK_BOW
	setevent EVENT_TIFFANY_GAVE_PINK_BOW
	jump UnknownScript_0x19d245

UnknownScript_0x19d230:
	jump UnknownScript_0x19d259

UnknownScript_0x19d233:
	jumpopenedtext UnknownText_0x19d64b

UnknownScript_0x19d239:
	jumpstd asknumber1f
	end

UnknownScript_0x19d23d:
	jumpstd asknumber2f
	end

UnknownScript_0x19d241:
	jumpstd registerednumberf
	end

UnknownScript_0x19d245:
	jumpstd numberacceptedf
	end

UnknownScript_0x19d249:
	jumpstd numberdeclinedf
	end

UnknownScript_0x19d24d:
	jumpstd phonefullf
	end

UnknownScript_0x19d251:
	jumpstd rematchf
	end

UnknownScript_0x19d255:
	jumpstd giftf
	end

UnknownScript_0x19d259:
	jumpstd packfullf
	end

PokemaniacBenSeenText:
	text "I love #mon!"

	para "That's why I"
	line "started--and why"

	para "I'll keep on col-"
	line "lecting #mon!"
	done

PokemaniacBenBeatenText:
	text "How could you do"
	line "this to me?"
	done

UnknownText_0x19d2d2:
	text "What else do I"
	line "like besides"
	cont "#mon?"

	para "Mary on the radio."
	line "I bet she's cute!"
	done

PokemaniacBrent1SeenText:
	text "Hey! Do you have"
	line "any rare #mon?"
	done

PokemaniacBrent1BeatenText:
	text "Oh, my poor #-"
	line "mon! Darlings!"
	done

UnknownText_0x19d359:
	text "I'd be happy just"
	line "to own a single"
	cont "rare #mon."
	done

PokemaniacRonSeenText:
	text "Would you get"
	line "this?"

	para "Some <RIVAL> guy"
	line "made fun of my"
	cont "#mon!"

	para "Darn it! My #-"
	line "mon's great!"
	done

PokemaniacRonBeatenText:
	text "My Nidoking did"
	line "pretty right on!"
	done

UnknownText_0x19d3f8:
	text "It's OK for people"
	line "to like different"
	cont "types of #mon."

	para "#mon isn't just"
	line "about having the"
	cont "most powerful one."
	done

FisherMarvinSeenText:
	text "I'm in a slump."

	para "Maybe it's the"
	line "gear I'm using."

	para "Let's battle for a"
	line "change of pace!"
	done

FisherMarvinBeatenText:
	text "I lost, but I feel"
	line "better anyway."
	done

UnknownText_0x19d4d3:
	text "Kurt's Lure Ball"
	line "is the best for"

	para "catching hooked"
	line "#mon."

	para "It's much more"
	line "effective than a"
	cont "Ultra Ball."
	done

CamperSpencerSeenText:
	text "I can do so much"
	line "with my #mon--"
	cont "it's super-fun!"
	done

CamperSpencerBeatenText:
	text "Losing isn't fun"
	line "at all…"
	done

UnknownText_0x19d57e:
	text "What is going on"
	line "at Lake of Rage?"

	para "We were planning"
	line "to camp there."
	done

PicnickerTiffany1SeenText:
	text "Are you going to"
	line "Lake of Rage too?"

	para "Let's play for a"
	line "little while!"
	done

PicnickerTiffany1BeatenText:
	text "I played too much!"
	done

UnknownText_0x19d618:
	text "I'm having a pic-"
	line "nic with #mon."

	para "Won't you join us?"
	done

UnknownText_0x19d64b:
	text "Isn't my Clefairy"
	line "just the most"
	cont "adorable thing?"
	done

BreederJodySeenText:
	text "I bred my #mon"
	line "so they know"
	cont "special moves!"
	done

BreederJodyBeatenText:
	text "I lost anyway!"
	done

BreederJodyAfterText:
	text "A baby #mon"
	line "can sometimes"

	para "inherit a move"
	line "from its father,"

	para "even one that it"
	line "wouldn't normally"
	cont "learn."
	done

SrandjrIvyandamy1SeenText:
	text "Ivy: I'll show my"
	line "junior how it's"
	cont "done!"
	done

SrandjrIvyandamy1BeatenText:
	text "Ivy: You embarass-"
	line "ed me in front of"
	cont "my junior…"
	done

SrandjrIvyandamy1AfterText:
	text "Ivy: I don't want"
	line "my junior to think"
	cont "I can't help her."
	done

SrandjrIvyandamy2SeenText:
	text "Amy: A trainer!"
	line "Senior, please"
	cont "help me win!"
	done

SrandjrIvyandamy2BeatenText:
	text "Amy: We couldn't"
	line "do it…"
	done

SrandjrIvyandamy2AfterText:
	text "Amy: I hope my"
	line "senior noticed"
	cont "how hard I tried."
	done

Route43Sign1Text:
	text "Route 43"

	para "Lake of Rage -"
	line "Mahogany Town"
	done

Route43Sign2Text:
	text "Route 43"

	para "Lake of Rage -"
	line "Mahogany Town"
	done

Route43TrainerTipsText:
	text "Trainer Tips"

	para "All #mon have"
	line "pros and cons"

	para "depending on their"
	line "types."

	para "If their types"
	line "differ, a higher-"

	para "level #mon may"
	line "lose in battle."

	para "Learn which types"
	line "are strong and"

	para "weak against your"
	line "#mon's type."
	done
