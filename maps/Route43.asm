Route43_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route43CheckIfRocketsScript
	callback MAPCALLBACK_TILES, Route43RainScript

	def_warp_events
	warp_event  9, 51, ROUTE_43_MAHOGANY_GATE, 1
	warp_event 10, 51, ROUTE_43_MAHOGANY_GATE, 2
	warp_event 17, 35, ROUTE_43_GATE, 3
	warp_event 17, 31, ROUTE_43_GATE, 1
	warp_event 18, 31, ROUTE_43_GATE, 2

	def_coord_events

	def_bg_events
	bg_event 13,  3, BGEVENT_JUMPTEXT, Route43Sign1Text
	bg_event 11, 49, BGEVENT_JUMPTEXT, Route43Sign2Text
	bg_event 16, 38, BGEVENT_JUMPTEXT, Route43TrainerTipsText

	def_object_events
	object_event  1,  6, SPRITE_LADY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route43SightseerfScript, -1
	object_event 13,  5, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPokemaniacBen, -1
	object_event 13, 20, SPRITE_POKEMANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerPokemaniacBrent1, -1
	object_event 14,  7, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPokemaniacRon, -1
	object_event  4, 16, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerFisherMarvin, -1
	object_event  8, 10, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerPicnickerTiffany1, -1
	object_event 13, 40, SPRITE_CAMPER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerCamperSpencer, -1
	object_event  8, 32, SPRITE_BREEDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBreederJody, -1
	object_event 11, 24, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSrandjrIvyandamy1, -1
	object_event 11, 25, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSrandjrIvyandamy2, -1
	cuttree_event  2, 28, EVENT_ROUTE_43_CUT_TREE
	fruittree_event  1, 26, FRUITTREE_ROUTE_43, PERSIM_BERRY, PAL_NPC_RED
	itemball_event 12, 32, MAX_ETHER, 1, EVENT_ROUTE_43_MAX_ETHER

	object_const_def
	const ROUTE43_SIGHTSEER_F

Route43CheckIfRocketsScript:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue Route43NoRocketsScript
	setmapscene ROUTE_43_GATE, $0
	return

Route43RainScript:
	special Special_GetOvercastIndex
	ifequal LAKE_OF_RAGE_OVERCAST, .flood
	changemap Route43_BlockData
	return

.flood
	changemap Route43Raining_BlockData
	return

Route43NoRocketsScript:
	setmapscene ROUTE_43_GATE, $1
	return

Route43SightseerfScript:
	checkevent EVENT_GOT_FLAME_ORB_FROM_ROUTE_43_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	checkevent EVENT_BEAT_SIGHTSEERF_LENIE
	iftrue .Beaten
	checkevent EVENT_BEAT_BREEDER_JODY
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
	jumpthisopenedtext

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

GenericTrainerBreederJody:
	generictrainer BREEDER, JODY, EVENT_BEAT_BREEDER_JODY, BreederJodySeenText, BreederJodyBeatenText

	text "A baby #mon"
	line "can sometimes"

	para "inherit a move"
	line "from its father,"

	para "even one that it"
	line "wouldn't normally"
	cont "learn."
	done

GenericTrainerSrandjrIvyandamy1:
	generictrainer SR_AND_JR, IVYANDAMY1, EVENT_BEAT_SR_AND_JR_IVY_AND_AMY, SrandjrIvyandamy1SeenText, SrandjrIvyandamy1BeatenText

	text "Ivy: I don't want"
	line "my junior to think"
	cont "I can't help her."
	done

GenericTrainerSrandjrIvyandamy2:
	generictrainer SR_AND_JR, IVYANDAMY2, EVENT_BEAT_SR_AND_JR_IVY_AND_AMY, SrandjrIvyandamy2SeenText, SrandjrIvyandamy2BeatenText

	text "Amy: I hope my"
	line "senior noticed"
	cont "how hard I tried."
	done

GenericTrainerCamperSpencer:
	generictrainer CAMPER, SPENCER, EVENT_BEAT_CAMPER_SPENCER, CamperSpencerSeenText, CamperSpencerBeatenText

	text "What is going on"
	line "at Lake of Rage?"

	para "We were planning"
	line "to camp there."
	done

GenericTrainerPokemaniacBen:
	generictrainer POKEMANIAC, BEN, EVENT_BEAT_POKEMANIAC_BEN, PokemaniacBenSeenText, PokemaniacBenBeatenText

	text "What else do I"
	line "like besides"
	cont "#mon?"

	para "Mary on the radio."
	line "I bet she's cute!"
	done

TrainerPokemaniacBrent1:
	trainer POKEMANIAC, BRENT1, EVENT_BEAT_POKEMANIAC_BRENT, PokemaniacBrent1SeenText, PokemaniacBrent1BeatenText, 0, PokemaniacBrent1Script

PokemaniacBrent1Script:
	writecode VAR_CALLERID, PHONE_POKEMANIAC_BRENT
	opentext
	checkflag ENGINE_BRENT
	iftrue UnknownScript_0x19d0cf
	checkcellnum PHONE_POKEMANIAC_BRENT
	iftrue UnknownScript_0x19d138
	checkevent EVENT_BRENT_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x19d0b8
	writetext PokemaniacBrentAfterBattleText
	buttonsound
	setevent EVENT_BRENT_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x19d12c
	jump UnknownScript_0x19d0bb

UnknownScript_0x19d0b8:
	scall UnknownScript_0x19d130
UnknownScript_0x19d0bb:
	askforphonenumber PHONE_POKEMANIAC_BRENT
	ifequal $1, UnknownScript_0x19d140
	ifequal $2, UnknownScript_0x19d13c
	trainertotext POKEMANIAC, BRENT1, $0
	scall UnknownScript_0x19d134
	jump UnknownScript_0x19d138

UnknownScript_0x19d0cf:
	scall UnknownScript_0x19d144
	winlosstext PokemaniacBrent1BeatenText, 0
	copybytetovar wBrentFightCount
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
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

UnknownScript_0x19d130:
	jumpstd asknumber2m

UnknownScript_0x19d134:
	jumpstd registerednumberm

UnknownScript_0x19d138:
	jumpstd numberacceptedm

UnknownScript_0x19d13c:
	jumpstd numberdeclinedm

UnknownScript_0x19d140:
	jumpstd phonefullm

UnknownScript_0x19d144:
	jumpstd rematchm

GenericTrainerPokemaniacRon:
	generictrainer POKEMANIAC, RON, EVENT_BEAT_POKEMANIAC_RON, PokemaniacRonSeenText, PokemaniacRonBeatenText

	text "It's OK for people"
	line "to like different"
	cont "types of #mon."

	para "#mon isn't just"
	line "about having the"
	cont "most powerful one."
	done

GenericTrainerFisherMarvin:
	generictrainer FISHER, MARVIN, EVENT_BEAT_FISHER_MARVIN, FisherMarvinSeenText, FisherMarvinBeatenText

	text "Kurt's Lure Ball"
	line "is the best for"

	para "catching hooked"
	line "#mon."

	para "It's much more"
	line "effective than a"
	cont "Ultra Ball."
	done

TrainerPicnickerTiffany1:
	trainer PICNICKER, TIFFANY1, EVENT_BEAT_PICNICKER_TIFFANY, PicnickerTiffany1SeenText, PicnickerTiffany1BeatenText, 0, PicnickerTiffany1Script

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
	writetext PicnickerTiffanyWantsPicnicText
	buttonsound
	setevent EVENT_TIFFANY_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x19d239
	jump UnknownScript_0x19d1ad

UnknownScript_0x19d1aa:
	scall UnknownScript_0x19d23d
UnknownScript_0x19d1ad:
	askforphonenumber PHONE_PICNICKER_TIFFANY
	ifequal $1, UnknownScript_0x19d24d
	ifequal $2, UnknownScript_0x19d249
	trainertotext PICNICKER, TIFFANY1, $0
	scall UnknownScript_0x19d241
	jump UnknownScript_0x19d245

UnknownScript_0x19d1c1:
	scall UnknownScript_0x19d251
	winlosstext PicnickerTiffany1BeatenText, 0
	copybytetovar wTiffanyFightCount
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
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
	jumpopenedtext PicnickerTiffanyClefairyText

UnknownScript_0x19d239:
	jumpstd asknumber1f

UnknownScript_0x19d23d:
	jumpstd asknumber2f

UnknownScript_0x19d241:
	jumpstd registerednumberf

UnknownScript_0x19d245:
	jumpstd numberacceptedf

UnknownScript_0x19d249:
	jumpstd numberdeclinedf

UnknownScript_0x19d24d:
	jumpstd phonefullf

UnknownScript_0x19d251:
	jumpstd rematchf

UnknownScript_0x19d255:
	jumpstd giftf

UnknownScript_0x19d259:
	jumpstd packfullf

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

PokemaniacBrent1SeenText:
	text "Hey! Do you have"
	line "any rare #mon?"
	done

PokemaniacBrent1BeatenText:
	text "Oh, my poor #-"
	line "mon! Darlings!"
	done

PokemaniacBrentAfterBattleText:
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

CamperSpencerSeenText:
	text "I can do so much"
	line "with my #mon--"
	cont "it's super fun!"
	done

CamperSpencerBeatenText:
	text "Losing isn't fun"
	line "at all…"
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

PicnickerTiffanyWantsPicnicText:
	text "I'm having a pic-"
	line "nic with #mon."

	para "Won't you join us?"
	done

PicnickerTiffanyClefairyText:
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

SrandjrIvyandamy2SeenText:
	text "Amy: A trainer!"
	line "Senior, please"
	cont "help me win!"
	done

SrandjrIvyandamy2BeatenText:
	text "Amy: We couldn't"
	line "do it…"
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
