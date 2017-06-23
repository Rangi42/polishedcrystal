const_value set 2
	const ROUTE39_SAILOR
	const ROUTE39_POKEFAN_M
	const ROUTE39_POKEFAN_F1
	const ROUTE39_MILTANK1
	const ROUTE39_MILTANK2
	const ROUTE39_MILTANK3
	const ROUTE39_MILTANK4
	const ROUTE39_YOUNGSTER
	const ROUTE39_FRUIT_TREE
	const ROUTE39_POKEFAN_F2
	const ROUTE39_COWGIRL
	const ROUTE39_BEAUTY

Route39_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route39Miltank:
	opentext
	writetext Route39MiltankText
	cry MILTANK
	waitbutton
	closetext
	end

TrainerPokefanmDerek1:
	trainer EVENT_BEAT_POKEFANM_DEREK, POKEFANM, DEREK1, PokefanmDerek1SeenText, PokefanmDerek1BeatenText, 0, PokefanmDerek1Script

PokefanmDerek1Script:
	writecode VAR_CALLERID, PHONE_POKEFANM_DEREK
	end_if_just_battled
	opentext
	checkflag ENGINE_DEREK_HAS_NUGGET
	iftrue UnknownScript_0x1a5b4a
	checkcellnum PHONE_POKEFANM_DEREK
	iftrue UnknownScript_0x1a5b6e
	checkpoke PIKACHU
	iffalse UnknownScript_0x1a5b5c
	checkevent EVENT_DEREK_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x1a5b33
	writetext UnknownText_0x1a5cf8
	buttonsound
	setevent EVENT_DEREK_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x1a5b62
	jump UnknownScript_0x1a5b36

UnknownScript_0x1a5b33:
	scall UnknownScript_0x1a5b66
UnknownScript_0x1a5b36:
	askforphonenumber PHONE_POKEFANM_DEREK
	if_equal $1, UnknownScript_0x1a5b76
	if_equal $2, UnknownScript_0x1a5b72
	trainertotext POKEFANM, DEREK1, $0
	scall UnknownScript_0x1a5b6a
	jump UnknownScript_0x1a5b6e

UnknownScript_0x1a5b4a:
	scall UnknownScript_0x1a5b7a
	verbosegiveitem NUGGET
	iffalse UnknownScript_0x1a5b59
	clearflag ENGINE_DEREK_HAS_NUGGET
	jump UnknownScript_0x1a5b6e

UnknownScript_0x1a5b59:
	jump UnknownScript_0x1a5b7e

UnknownScript_0x1a5b5c:
	writetext UnknownText_0x1a5dec
	waitbutton
	closetext
	end

UnknownScript_0x1a5b62:
	jumpstd asknumber1m
	end

UnknownScript_0x1a5b66:
	jumpstd asknumber2m
	end

UnknownScript_0x1a5b6a:
	jumpstd registerednumberm
	end

UnknownScript_0x1a5b6e:
	jumpstd numberacceptedm
	end

UnknownScript_0x1a5b72:
	jumpstd numberdeclinedm
	end

UnknownScript_0x1a5b76:
	jumpstd phonefullm
	end

UnknownScript_0x1a5b7a:
	jumpstd giftm
	end

UnknownScript_0x1a5b7e:
	jumpstd packfullm
	end

TrainerPokefanfRuth:
	trainer EVENT_BEAT_POKEFANF_RUTH, POKEFANF, RUTH, PokefanfRuthSeenText, PokefanfRuthBeatenText, 0, PokefanfRuthScript

PokefanfRuthScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a5db2
	waitbutton
	closetext
	end

Route39CowgirlAnnieScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_PP_MAX_FROM_ROUTE_39_LEADER
	iftrue .GotPPMax
	checkevent EVENT_BEAT_COWGIRL_ANNIE
	iftrue .Beaten
	checkevent EVENT_BEAT_BIRD_KEEPER_TOBY
	iffalse .RouteNotCleared
	checkevent EVENT_BEAT_SAILOR_HARRY
	iffalse .RouteNotCleared
	checkevent EVENT_BEAT_LASS_DANA
	iffalse .RouteNotCleared
	checkevent EVENT_BEAT_SCHOOLBOY_CHAD
	iffalse .RouteNotCleared
	checkevent EVENT_BEAT_BEAUTY_VALENCIA
	iffalse .RouteNotCleared
	checkevent EVENT_BEAT_BEAUTY_OLIVIA
	iffalse .RouteNotCleared
	checkevent EVENT_BEAT_POKEFANM_DEREK
	iffalse .RouteNotCleared
	checkevent EVENT_BEAT_POKEFANF_RUTH
	iffalse .RouteNotCleared
	checkevent EVENT_BEAT_SAILOR_EUGENE
	iffalse .RouteNotCleared
	checkevent EVENT_BEAT_PSYCHIC_NORMAN
	iffalse .RouteNotCleared
	checkevent EVENT_BEAT_POKEFANF_JAIME
	iffalse .RouteNotCleared
	writetext .QuestionText
	yesorno
	iffalse .NoBattle
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE39_COWGIRL
	loadtrainer COWGIRL, ANNIE
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COWGIRL_ANNIE
	opentext
.Beaten:
	writetext .AfterText1
	buttonsound
	verbosegiveitem PP_MAX
	iffalse .Done
	setevent EVENT_GOT_PP_MAX_FROM_ROUTE_39_LEADER
.GotPPMax:
	writetext .AfterText2
	waitbutton
.Done:
	closetext
	end

.RouteNotCleared:
	writetext .IntroText
	waitbutton
	closetext
	end

.NoBattle:
	writetext .RefusedText
	waitbutton
	closetext
	end

.IntroText:
	text "Hey! Don't scare"
	line "the Miltank!"

	para "…Oh, you want to"
	line "battle?"

	para "I'm doing farm"
	line "work right now…"

	para "Tell ya what--"
	line "beat everyone else"

	para "from Ecruteak to"
	line "Olivine and I'll"
	cont "fight ya."
	done

.QuestionText:
	text "I'm done with my"
	line "chores, and you're"

	para "done clearing"
	line "these routes."

	para "Now then, my team"
	line "beat Morty, and I"

	para "reckon we can beat"
	line "you."

	para "What do you say?"
	done

.RefusedText:
	text "Shucks. Back to"
	line "tending the Mil-"
	cont "tank, then."
	done

.SeenText:
	text "I'll show ya what"
	line "a Cowgirl can do!"
	done

.BeatenText:
	text "I spilled some"
	line "milk…"
	done

.AfterText1:
	text "Whew! That was an"
	line "intense break!"

	para "Thanks for the"
	line "fun, partner."

	para "Take this with"
	line "ya!"
	done

.AfterText2:
	text "We make cheese"
	line "and yogurt out"
	cont "of Miltank milk."
	done

TrainerSailorEugene:
	trainer EVENT_BEAT_SAILOR_EUGENE, SAILOR, EUGENE, SailorEugeneSeenText, SailorEugeneBeatenText, 0, SailorEugeneScript

SailorEugeneScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a5c4d
	waitbutton
	closetext
	end

TrainerPsychicNorman:
	trainer EVENT_BEAT_PSYCHIC_NORMAN, PSYCHIC_T, NORMAN, PsychicNormanSeenText, PsychicNormanBeatenText, 0, PsychicNormanScript

PsychicNormanScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a5e57
	waitbutton
	closetext
	end

PokefanFScript_0x1a5bbe:
	faceplayer
	opentext
	checknite
	iffalse UnknownScript_0x1a5be5
	checkevent EVENT_BEAT_POKEFANF_JAIME
	iftrue UnknownScript_0x1a5bdf
	writetext UnknownText_0x1a5ee8
	waitbutton
	closetext
	winlosstext UnknownText_0x1a5f17, 0
	loadtrainer POKEFANF, JAIME
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_POKEFANF_JAIME
	closetext
	end

UnknownScript_0x1a5bdf:
	writetext UnknownText_0x1a5f31
	waitbutton
	closetext
	end

UnknownScript_0x1a5be5:
	writetext UnknownText_0x1a5ec4
	waitbutton
	closetext
	end

Route39BeautyScript:
	jumptextfaceplayer Route39BeautyText

Route39Sign:
	jumptext Route39SignText

MoomooFarmSign:
	jumptext MoomooFarmSignText

Route39TrainerTips:
	jumptext Route39TrainerTipsText

FruitTreeScript_0x1a5bf4:
	fruittree FRUITTREE_ROUTE_39

Route39HiddenNugget:
	dwb EVENT_ROUTE_39_HIDDEN_NUGGET, NUGGET

Route39MiltankText:
	text "Miltank: Mooo!"
	done

SailorEugeneSeenText:
	text "I just got back to"
	line "Olivine."

	para "So how about a"
	line "#mon battle?"
	done

SailorEugeneBeatenText:
	text "Awaaargh!"
	done

UnknownText_0x1a5c4d:
	text "My #mon were"
	line "caught and raised"
	cont "overseas."

	para "They're my compan-"
	line "ions on those long"
	cont "voyages."
	done

PokefanmDerek1SeenText:
	text "This is a good"
	line "time to brag about"
	cont "my Pikachu!"
	done

PokefanmDerek1BeatenText:
	text "I had no time to"
	line "show off Pikachu…"
	done

UnknownText_0x1a5cf8:
	text "I'm not listening"
	line "to your bragging!"

	para "We # Fans have"
	line "a policy of not"

	para "listening to other"
	line "people brag!"
	done

PokefanfRuthSeenText:
	text "Such darling"
	line "#mon."

	para "Let's show our"
	line "#mon together"
	cont "at the same time."
	done

PokefanfRuthBeatenText:
	text "I don't mind"
	line "losing."
	done

UnknownText_0x1a5db2:
	text "Do you know about"
	line "baby #mon?"

	para "I bet they're just"
	line "adorable!"
	done

UnknownText_0x1a5dec:
	text "Pikachu is it!"
	line "Don't you agree?"
	done

PsychicNormanSeenText:
	text "Let me see what"
	line "your #mon are"
	cont "capable of."
	done

PsychicNormanBeatenText:
	text "Ooh, your #mon"
	line "have potential."
	done

UnknownText_0x1a5e57:
	text "You know how #-"
	line "mon have different"
	cont "abilities?"

	para "People are like"
	line "that too. Every-"
	cont "one has different"
	cont "potential."
	done

UnknownText_0x1a5ec4:
	text "Ufufufu… I hope it"
	line "gets dark soon."
	done

UnknownText_0x1a5ee8:
	text "You came at just"
	line "the right time."

	para "Let's battle."
	done

UnknownText_0x1a5f17:
	text "Oh, how disap-"
	line "pointing…"
	done

UnknownText_0x1a5f31:
	text "I met my Meowth at"
	line "night, right here"
	cont "on Route 39."

	para "I'm not sure why,"
	line "but it seems to"

	para "like it when I"
	line "train here."

	para "It seems to become"
	line "friendlier by"

	para "training here than"
	line "anywhere else."
	done

Route39BeautyText:
	text "Which is taller:"
	line "the Bell Tower in"
	cont "Ecruteak City,"

	para "or the Lighthouse"
	line "in Olivine City?"

	para "The Bell Tower,"
	line "no doubt!"
	done

Route39SignText:
	text "Route 39"

	para "Olivine City -"
	line "Ecruteak City"
	done

MoomooFarmSignText:
	text "Moomoo Farm"

	para "Enjoy Our Fresh"
	line "and Tasty Milk"
	done

Route39TrainerTipsText:
	text "Trainer Tips"

	para "Use Headbutt on"
	line "trees to shake"
	cont "#mon out."

	para "Different kinds of"
	line "#mon drop out"
	cont "of trees."

	para "Use Headbutt on"
	line "any tree you see!"
	done

Route39_MapEventHeader:
.Warps:
	db 2
	warp_def $3, $1, 1, ROUTE_39_BARN
	warp_def $3, $5, 1, ROUTE_39_FARMHOUSE

.XYTriggers:
	db 0

.Signposts:
	db 4
	signpost 31, 5, SIGNPOST_READ, Route39TrainerTips
	signpost 5, 9, SIGNPOST_READ, MoomooFarmSign
	signpost 7, 15, SIGNPOST_READ, Route39Sign
	signpost 13, 5, SIGNPOST_ITEM, Route39HiddenNugget

.PersonEvents:
	db 12
	person_event SPRITE_SAILOR, 29, 13, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerSailorEugene, -1
	person_event SPRITE_POKEFAN_M, 22, 10, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerPokefanmDerek1, -1
	person_event SPRITE_POKEFAN_F, 19, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerPokefanfRuth, -1
	person_event SPRITE_MILTANK, 12, 3, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route39Miltank, -1
	person_event SPRITE_MILTANK, 11, 6, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route39Miltank, -1
	person_event SPRITE_MILTANK, 15, 4, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route39Miltank, -1
	person_event SPRITE_MILTANK, 13, 8, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route39Miltank, -1
	person_event SPRITE_YOUNGSTER, 7, 13, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 1, TrainerPsychicNorman, -1
	person_event SPRITE_BALL_CUT_FRUIT, 3, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FruitTreeScript_0x1a5bf4, -1
	person_event SPRITE_POKEFAN_F, 22, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, PokefanFScript_0x1a5bbe, -1
	person_event SPRITE_OLIVINE_RIVAL, 14, 7, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, Route39CowgirlAnnieScript, -1
	person_event SPRITE_BEAUTY, 30, 4, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, Route39BeautyScript, -1
