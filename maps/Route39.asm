Route39_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  1, 17, ROUTE_39_BARN, 1
	warp_event  5, 17, ROUTE_39_FARMHOUSE, 1
	warp_event  9,  5, ROUTE_39_RUGGED_ROAD_GATE, 3

	def_coord_events

	def_bg_events
	bg_event  5, 45, BGEVENT_JUMPTEXT, Route39TrainerTipsText
	bg_event  9, 19, BGEVENT_JUMPTEXT, MoomooFarmSignText
	bg_event 11,  7, BGEVENT_JUMPTEXT, RuggedRoadAheadSignText
	bg_event 15, 21, BGEVENT_JUMPTEXT, Route39SignText
	bg_event  8,  9, BGEVENT_JUMPTEXT, Route39AdvancedTips1Text
	bg_event 10, 45, BGEVENT_JUMPTEXT, Route39AdvancedTips2Text
	bg_event  5, 27, BGEVENT_ITEM + NUGGET, EVENT_ROUTE_39_HIDDEN_NUGGET

	def_object_events
	object_event  7, 28, SPRITE_COWGIRL, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route39CowgirlAnnieScript, -1
	object_event 13, 43, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerSailorEugene, -1
	object_event 10, 36, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 4, TrainerPokefanmDerek1, -1
	object_event 11, 33, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPokefanfRuth, -1
	pokemon_event  3, 26, MILTANK, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_PINK, Route39MiltankText, -1
	pokemon_event  6, 25, MILTANK, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_PINK, Route39MiltankText, -1
	pokemon_event  4, 29, MILTANK, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_PINK, Route39MiltankText, -1
	pokemon_event  8, 27, MILTANK, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_PINK, Route39MiltankText, -1
	object_event 13, 21, SPRITE_PSYCHIC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerPsychicNorman, -1
	fruittree_event  9, 17, FRUITTREE_ROUTE_39, CHESTO_BERRY, PAL_NPC_PURPLE
	object_event  4, 36, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TrainerPokefanfJaime, -1
	object_event  4, 44, SPRITE_BEAUTY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route39BeautyText, -1
	object_event 15, 11, SPRITE_HIKER, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route39HikerText, -1
	tmhmball_event  1, 21, TM_BULLDOZE, EVENT_ROUTE_39_TM_BULLDOZE
	smashrock_event 12, 10
	smashrock_event 15,  8

	object_const_def
	const ROUTE39_COWGIRL

TrainerPokefanmDerek1:
	trainer POKEFANM, DEREK1, EVENT_BEAT_POKEFANM_DEREK, PokefanmDerek1SeenText, PokefanmDerek1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_POKEFANM_DEREK
	opentext
	checkflag ENGINE_DEREK_HAS_NUGGET
	iftruefwd .HasNugget
	checkcellnum PHONE_POKEFANM_DEREK
	iftruefwd .NumberAccepted
	checkpoke PIKACHU
	iffalsefwd .WantsPikachu
	checkevent EVENT_DEREK_ASKED_FOR_PHONE_NUMBER
	iftruefwd .AskedAlready
	writetext PokefanMDerekText_NotBragging
	promptbutton
	setevent EVENT_DEREK_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjumpfwd .AskForNumber

.AskedAlready:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_POKEFANM_DEREK
	ifequalfwd $1, .PhoneFull
	ifequalfwd $2, .NumberDeclined
	gettrainername POKEFANM, DEREK1, $0
	scall .RegisteredNumber
	sjumpfwd .NumberAccepted

.HasNugget:
	scall .Gift
	verbosegiveitem NUGGET
	iffalsefwd .NoRoom
	clearflag ENGINE_DEREK_HAS_NUGGET
	sjumpfwd .NumberAccepted

.NoRoom:
	sjumpfwd .PackFull

.WantsPikachu:
	jumpopenedtext PokefanMDerekPikachuIsItText

.AskNumber1:
	jumpstd asknumber1m

.AskNumber2:
	jumpstd asknumber2m

.RegisteredNumber:
	jumpstd registerednumberm

.NumberAccepted:
	jumpstd numberacceptedm

.NumberDeclined:
	jumpstd numberdeclinedm

.PhoneFull:
	jumpstd phonefullm

.Gift:
	jumpstd giftm

.PackFull:
	jumpstd packfullm

GenericTrainerPokefanfRuth:
	generictrainer POKEFANF, RUTH, EVENT_BEAT_POKEFANF_RUTH, PokefanfRuthSeenText, PokefanfRuthBeatenText

	text "Do you know about"
	line "baby #mon?"

	para "I bet they're just"
	line "adorable!"
	done

Route39CowgirlAnnieScript:
	checkevent EVENT_GOT_PP_MAX_FROM_ROUTE_39_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	checkevent EVENT_BEAT_COWGIRL_ANNIE
	iftruefwd .Beaten
	checkevent EVENT_BEAT_BIRD_KEEPER_TOBY
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_SAILOR_HARRY
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_LASS_DANA
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_SCHOOLBOY_CHAD
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BEAUTY_VALENCIA
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BEAUTY_OLIVIA
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_POKEFANM_DEREK
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_POKEFANF_RUTH
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_SAILOR_EUGENE
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_PSYCHIC_NORMAN
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_POKEFANF_JAIME
	iffalse_jumptext .IntroText
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE39_COWGIRL
	loadtrainer COWGIRL, ANNIE
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COWGIRL_ANNIE
.Beaten:
	opentext
	writetext .AfterText1
	promptbutton
	verbosegiveitem PP_MAX
	iffalse_endtext
	setevent EVENT_GOT_PP_MAX_FROM_ROUTE_39_LEADER
	jumpthisopenedtext

.AfterText2:
	text "We make cheese"
	line "and yogurt out"
	cont "of Miltank milk."
	done

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

	para "Some o' them"
	line "might only want"

	para "to battle ya when"
	line "it's dark out."
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

GenericTrainerSailorEugene:
	generictrainer SAILOR, EUGENE, EVENT_BEAT_SAILOR_EUGENE, SailorEugeneSeenText, SailorEugeneBeatenText

	text "My #mon were"
	line "caught and raised"
	cont "overseas."

	para "They're my compan-"
	line "ions on those long"
	cont "voyages."
	done

GenericTrainerPsychicNorman:
	generictrainer PSYCHIC_T, NORMAN, EVENT_BEAT_PSYCHIC_NORMAN, PsychicNormanSeenText, PsychicNormanBeatenText

	text "You know how #-"
	line "mon have different"
	cont "abilities?"

	para "People are like"
	line "that too. Every-"
	cont "one has different"
	cont "potential."
	done

TrainerPokefanfJaime:
	faceplayer
	opentext
	checktime 1 << NITE
	iffalsefwd .NotNight
	checkevent EVENT_BEAT_POKEFANF_JAIME
	iftruefwd .Beaten
	writetext PokefanfJaimeSeenText
	waitbutton
	closetext
	winlosstext PokefanfJaimeBeatenText, 0
	loadtrainer POKEFANF, JAIME
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_POKEFANF_JAIME
	endtext

.Beaten:
	jumpopenedtext PokefanfJaimeAfterBattleText

.NotNight:
	jumpopenedtext PokefanfJaimeHopeItGetsDarkText

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

PokefanmDerek1SeenText:
	text "This is a good"
	line "time to brag about"
	cont "my Pikachu!"
	done

PokefanmDerek1BeatenText:
	text "I had no time to"
	line "show off Pikachu…"
	done

PokefanMDerekText_NotBragging:
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

PokefanMDerekPikachuIsItText:
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

PokefanfJaimeHopeItGetsDarkText:
	text "Ufufufu… I hope it"
	line "gets dark soon."
	done

PokefanfJaimeSeenText:
	text "You came at just"
	line "the right time."

	para "Let's battle."
	done

PokefanfJaimeBeatenText:
	text "Oh, how disap-"
	line "pointing…"
	done

PokefanfJaimeAfterBattleText:
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

Route39HikerText:
	text "North of Olivine"
	line "is the frontier"
	cont "of Johto!"

	para "An intense hike"
	line "through rugged"

	para "terrain, then"
	line "scaling an icy"
	cont "mountain…"

	para "I've heard that"
	line "some #mon have"

	para "adapted to sur-"
	line "vive the harsh"
	cont "climate."

	para "…But without a"
	line "pair of Go-Goggles"
	cont "for safety,"

	para "I can't even start"
	line "on the hike…"
	done

Route39SignText:
	text "Route 39"

	para "Olivine City -"
	line "Ecruteak City"
	done

Route39AdvancedTips1Text:
	text "Advanced Tips!"

	para "Sandstorms boost"
	line "Special Defense of"
	cont "Rock-type #mon!"

	para "And, Hail boosts"
	line "the Defense of"
	cont "Ice-type #mon!"
	done

Route39AdvancedTips2Text:
	text "Advanced Tips!"

	para "A #mon with"
	line "the Compound Eyes"
	cont "ability, or one"

	para "holding an Amulet"
	line "Coin, is more li-"
	cont "kely to encounter"

	para "a wild #mon"
	line "holding an item!"
	done

RuggedRoadAheadSignText:
	text "Rugged Road"
	line "ahead"

	para "North to"
	line "Snowtop Mountain"
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
