SaffronGym_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  8, 17, SAFFRON_CITY, 2
	warp_event  9, 17, SAFFRON_CITY, 2
	warp_event 11, 14, SAFFRON_GYM, 18
	warp_event 19, 14, SAFFRON_GYM, 19
	warp_event 19, 10, SAFFRON_GYM, 20
	warp_event  0, 10, SAFFRON_GYM, 21
	warp_event  4,  2, SAFFRON_GYM, 22
	warp_event 11,  4, SAFFRON_GYM, 23
	warp_event  0, 14, SAFFRON_GYM, 24
	warp_event 19,  2, SAFFRON_GYM, 25
	warp_event 15, 16, SAFFRON_GYM, 26
	warp_event  4, 16, SAFFRON_GYM, 27
	warp_event  4,  8, SAFFRON_GYM, 28
	warp_event  8,  2, SAFFRON_GYM, 29
	warp_event 15,  8, SAFFRON_GYM, 30
	warp_event 15,  4, SAFFRON_GYM, 31
	warp_event  0,  4, SAFFRON_GYM, 32
	warp_event 19, 16, SAFFRON_GYM, 3
	warp_event 19,  8, SAFFRON_GYM, 4
	warp_event  0,  8, SAFFRON_GYM, 5
	warp_event  4,  4, SAFFRON_GYM, 6
	warp_event 11,  2, SAFFRON_GYM, 7
	warp_event  0, 16, SAFFRON_GYM, 8
	warp_event 19,  4, SAFFRON_GYM, 9
	warp_event 15, 14, SAFFRON_GYM, 10
	warp_event  4, 14, SAFFRON_GYM, 11
	warp_event  4, 10, SAFFRON_GYM, 12
	warp_event  8,  4, SAFFRON_GYM, 13
	warp_event 15, 10, SAFFRON_GYM, 14
	warp_event 15,  2, SAFFRON_GYM, 15
	warp_event  0,  2, SAFFRON_GYM, 16
	warp_event 11, 10, SAFFRON_GYM, 17
	warp_event  8, 10, SAFFRON_GYM, 3

	def_coord_events

	def_bg_events
	bg_event  8, 15, BGEVENT_READ, SaffronGymStatue

	def_object_events
	object_event  9,  8, SPRITE_SABRINA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SaffronGymSabrinaScript, -1
	object_event  2,  3, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerMediumDoris, -1
	object_event  9,  3, SPRITE_PSYCHIC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPsychicLeon, -1
	object_event 17,  3, SPRITE_PSYCHIC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPsychicJared, -1
	object_event  2,  9, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHexManiacLuna, -1
	object_event 17,  9, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHexManiacNatalie, -1
	object_event  2, 15, SPRITE_PSYCHIC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPsychicFranklin, -1
	object_event 17, 15, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerMediumRebecca, -1
	object_event  9, 14, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SaffronGymGuyScript, -1

SaffronGymSabrinaScript:
	faceplayer
	opentext
	checkflag ENGINE_SOULBADGE
	iftrue .FightDone
	writetext SabrinaIntroText
	waitbutton
	closetext
	winlosstext SabrinaWinLossText, 0
	loadtrainer SABRINA, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_SABRINA
	setevent EVENT_BEAT_MEDIUM_DORIS
	setevent EVENT_BEAT_PSYCHIC_LEON
	setevent EVENT_BEAT_PSYCHIC_JARED
	setevent EVENT_BEAT_HEX_MANIAC_LUNA
	setevent EVENT_BEAT_HEX_MANIAC_NATALIE
	setevent EVENT_BEAT_PSYCHIC_FRANKLIN
	setevent EVENT_BEAT_MEDIUM_REBECCA
	opentext
	writetext ReceivedMarshBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_SOULBADGE
	readvar VAR_BADGES
	ifequal 9, .FirstBadge
	ifequal 10, .SecondBadge
	ifequal 12, .LyrasEgg
	sjump .FightDone
.FirstBadge:
	specialphonecall SPECIALCALL_FIRSTBADGE
	sjump .FightDone
.SecondBadge:
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	iftrue .FightDone
	specialphonecall SPECIALCALL_SECONDBADGE
	sjump .FightDone
.LyrasEgg:
	specialphonecall SPECIALCALL_LYRASEGG
.FightDone:
	checkevent EVENT_GOT_TM29_PSYCHIC
	iftrue_jumpopenedtext SabrinaFightDoneText
	writetext SabrinaMarshBadgeText
	promptbutton
	verbosegivetmhm TM_PSYCHIC
	setevent EVENT_GOT_TM29_PSYCHIC
	jumpthisopenedtext

	text "TM29 is Psychic."

	para "It may lower the"
	line "target's Spcl.Def."

	para "You will become a"
	line "celebrated and"

	para "beloved Champion!"
	done

GenericTrainerMediumDoris:
	generictrainer MEDIUM, DORIS, EVENT_BEAT_MEDIUM_DORIS, MediumDorisSeenText, MediumDorisBeatenText

	text "Darn! I forgot"
	line "that I predicted I"
	cont "would lose to you."
	done

GenericTrainerPsychicLeon:
	generictrainer PSYCHIC_T, LEON, EVENT_BEAT_PSYCHIC_LEON, PsychicLeonSeenText, PsychicLeonBeatenText

	text "Sabrina's power is"
	line "greater than mine!"
	done

GenericTrainerPsychicJared:
	generictrainer PSYCHIC_T, JARED, EVENT_BEAT_PSYCHIC_JARED, PsychicJaredSeenText, PsychicJaredBeatenText

	text "Karate King, the"
	line "master of the"

	para "Fighting Dojo, was"
	line "just destroyed by"
	cont "Sabrina."
	done

GenericTrainerHexManiacLuna:
	generictrainer HEX_MANIAC, LUNA, EVENT_BEAT_HEX_MANIAC_LUNA, HexManiacLunaSeenText, HexManiacLunaBeatenText

	text "Alakazam is a pow-"
	line "erful #mon,"

	para "so Hex Maniacs use"
	line "its name for"
	cont "powerful spells."
	done

GenericTrainerHexManiacNatalie:
	generictrainer HEX_MANIAC, NATALIE, EVENT_BEAT_HEX_MANIAC_NATALIE, HexManiacNatalieSeenText, HexManiacNatalieBeatenText

	text "Maybe I'm not cut"
	line "out to be a Hex"
	cont "Maniac…"
	done

GenericTrainerPsychicFranklin:
	generictrainer PSYCHIC_T, FRANKLIN, EVENT_BEAT_PSYCHIC_FRANKLIN, PsychicFranklinSeenText, PsychicFranklinBeatenText

	text "You made your soul"
	line "stronger, not just"
	cont "your abilities."
	done

GenericTrainerMediumRebecca:
	generictrainer MEDIUM, REBECCA, EVENT_BEAT_MEDIUM_REBECCA, MediumRebeccaSeenText, MediumRebeccaBeatenText

	text "What is the source"
	line "of your power?"
	done

SaffronGymGuyScript:
	checkevent EVENT_BEAT_SABRINA
	iftrue_jumptextfaceplayer SaffronGymGuyWinText
	jumptextfaceplayer SaffronGymGuyText

SaffronGymStatue:
	gettrainername SABRINA, 1, $1
	checkflag ENGINE_SOULBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	jumpstd gymstatue2

SabrinaIntroText:
	text "Sabrina: I knew"
	line "you were coming…"

	para "Three years ago I"
	line "had a vision of"
	cont "your arrival."

	para "You're after my"
	line "Badge."

	para "I don't enjoy bat-"
	line "tling, but it's my"

	para "duty as a Leader"
	line "to confer Badges"

	para "on anyone who has"
	line "proven themselves"
	cont "worthy."

	para "Since you wish it,"
	line "I will show you my"
	cont "psychic powers!"
	done

SabrinaWinLossText:
	text "Sabrina: Your"
	line "power…"

	para "It far exceeds"
	line "what I foresaw…"

	para "Maybe it isn't"
	line "possible to fully"

	para "predict what the"
	line "future holds…"

	para "OK, you win. You"
	line "earned yourself"
if DEF(FAITHFUL)
	cont "the Marsh Badge."
else
	cont "the Soul Badge."
endc
	done

ReceivedMarshBadgeText:
	text "<PLAYER> received"
if DEF(FAITHFUL)
	line "the Marsh Badge."
else
	line "the Soul Badge."
endc
	done

SabrinaMarshBadgeText:
	text "Sabrina: I failed"
	line "to accurately pre-"

	para "dict your power."
	line "That means your"

	para "power is beyond my"
	line "psychic ability."

	para "You deserve this"
	line "TM, too!"
	done

SabrinaFightDoneText:
	text "Sabrina: Your love"
	line "for your #mon"

	para "overwhelmed my"
	line "psychic power…"

	para "The power of love,"
	line "I think, is also a"

	para "kind of psychic"
	line "power…"
	done

MediumDorisSeenText:
	text "Fufufufu…"
	line "I see it clearly."

	para "I can see into"
	line "your soul!"
	done

MediumDorisBeatenText:
	text "Though I read you,"
	line "I still lost…"
	done

PsychicLeonSeenText:
	text "You cannot resist"
	line "my psychic power!"
	done

PsychicLeonBeatenText:
	text "My prediction was"
	line "inaccurate…"
	done

PsychicJaredSeenText:
	text "The Fighting Dojo"
	line "next door was once"
	cont "this city's Gym."
	done

PsychicJaredBeatenText:
	text "I was no match…"
	done

HexManiacLunaSeenText:
	text "Abra, Kadabra,"
	line "Alakazam!"
	done

HexManiacLunaBeatenText:
	text "My curse failed?"
	done

HexManiacNatalieSeenText:
	text "Let us do battle!"
	line "Mwahaha!"
	done

HexManiacNatalieBeatenText:
	text "Mwaha--cough!"
	done

PsychicFranklinSeenText:
	text "Psychic power is"
	line "the power of your"
	cont "soul."
	done

PsychicFranklinBeatenText:
	text "Your soul has more"
	line "power than mine!"
	done

MediumRebeccaSeenText:
	text "The power of all"
	line "those you defeated"
	cont "comes to me!"
	done

MediumRebeccaBeatenText:
	text "Strong…"
	line "Far too strong…"
	done

SaffronGymGuyText:
	text "Yo, Champ in"
	line "making!"

	para "A trainer as"
	line "skilled as you"

	para "doesn't need to be"
	line "told how to deal"

	para "with Psychic-type"
	line "#mon, right?"

	para "I expect great"
	line "things from you!"

	para "Good luck!"
	done

SaffronGymGuyWinText:
	text "That was another"
	line "fantastic battle!"
	done
