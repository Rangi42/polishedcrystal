const_value set 2
	const SAFFRONGYM_SABRINA
	const SAFFRONGYM_GRANNY1
	const SAFFRONGYM_YOUNGSTER1
	const SAFFRONGYM_GRANNY2
	const SAFFRONGYM_YOUNGSTER2
	const SAFFRONGYM_GYM_GUY

SaffronGym_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SabrinaScript_0x189c2e:
	faceplayer
	opentext
	checkflag ENGINE_MARSHBADGE
	iftrue .FightDone
	writetext UnknownText_0x189cdf
	waitbutton
	closetext
	winlosstext UnknownText_0x189df4, 0
	loadtrainer SABRINA, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_SABRINA
	setevent EVENT_BEAT_MEDIUM_REBECCA
	setevent EVENT_BEAT_MEDIUM_DORIS
	setevent EVENT_BEAT_PSYCHIC_FRANKLIN
	setevent EVENT_BEAT_PSYCHIC_JARED
	opentext
	writetext UnknownText_0x189e95
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_MARSHBADGE
	writetext UnknownText_0x189ead
	waitbutton
	closetext
	end

.FightDone:
	writetext UnknownText_0x189f6c
	waitbutton
	closetext
	end

TrainerMediumRebecca:
	trainer EVENT_BEAT_MEDIUM_REBECCA, MEDIUM, REBECCA, MediumRebeccaSeenText, MediumRebeccaBeatenText, 0, MediumRebeccaScript

MediumRebeccaScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x18a034
	waitbutton
	closetext
	end

TrainerPsychicFranklin:
	trainer EVENT_BEAT_PSYCHIC_FRANKLIN, PSYCHIC_T, FRANKLIN, PsychicFranklinSeenText, PsychicFranklinBeatenText, 0, PsychicFranklinScript

PsychicFranklinScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x18a0a6
	waitbutton
	closetext
	end

TrainerMediumDoris:
	trainer EVENT_BEAT_MEDIUM_DORIS, MEDIUM, DORIS, MediumDorisSeenText, MediumDorisBeatenText, 0, MediumDorisScript

MediumDorisScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x18a136
	waitbutton
	closetext
	end

TrainerPsychicJared:
	trainer EVENT_BEAT_PSYCHIC_JARED, PSYCHIC_T, JARED, PsychicJaredSeenText, PsychicJaredBeatenText, 0, PsychicJaredScript

PsychicJaredScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x18a1b3
	waitbutton
	closetext
	end

SaffronGymGuyScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_SABRINA
	iftrue .SaffronGymGuyWinScript
	writetext SaffronGymGuyText
	waitbutton
	closetext
	end

.SaffronGymGuyWinScript:
	writetext SaffronGymGuyWinText
	waitbutton
	closetext
	end

SaffronGymStatue:
	checkflag ENGINE_MARSHBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	trainertotext SABRINA, 1, $1
	jumpstd gymstatue2

UnknownText_0x189cdf:
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
	line "proven him- or"
	cont "herself worthy."

	para "Since you wish it,"
	line "I will show you my"
	cont "psychic powers!"
	done

UnknownText_0x189df4:
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
	cont "the Marsh Badge."
	done

UnknownText_0x189e95:
	text "<PLAYER> received"
	line "the Marsh Badge."
	done

UnknownText_0x189ead:
	text "Sabrina: Although"
	line "I failed to accu-"
	cont "rately predict"

	para "your power, this"
	line "much I know to be"
	cont "true."

	para "You will become a"
	line "celebrated and"
	cont "beloved Champion!"
	done

UnknownText_0x189f6c:
	text "Sabrina: Your love"
	line "for your #mon"

	para "overwhelmed my"
	line "psychic power…"

	para "The power of love,"
	line "I think, is also a"

	para "kind of psychic"
	line "power…"
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

UnknownText_0x18a034:
	text "What is the source"
	line "of your power?"
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

UnknownText_0x18a0a6:
	text "You made your soul"
	line "stronger, not just"
	cont "your abilities."
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

UnknownText_0x18a136:
	text "Darn! I forgot"
	line "that I predicted I"
	cont "would lose to you."
	done

PsychicJaredSeenText:
	text "The Fighting Dojo"
	line "next door was once"
	cont "this city's Gym."
	done

PsychicJaredBeatenText:
	text "I was no match…"
	done

UnknownText_0x18a1b3:
	text "Karate King, the"
	line "master of the"

	para "Fighting Dojo, was"
	line "just destroyed by"
	cont "Sabrina."
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

SaffronGym_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 32
	warp_def $11, $8, 2, SAFFRON_CITY
	warp_def $11, $9, 2, SAFFRON_CITY
	warp_def $f, $b, 18, SAFFRON_GYM
	warp_def $f, $13, 19, SAFFRON_GYM
	warp_def $b, $13, 20, SAFFRON_GYM
	warp_def $b, $1, 21, SAFFRON_GYM
	warp_def $3, $5, 22, SAFFRON_GYM
	warp_def $5, $b, 23, SAFFRON_GYM
	warp_def $f, $1, 24, SAFFRON_GYM
	warp_def $3, $13, 25, SAFFRON_GYM
	warp_def $11, $f, 26, SAFFRON_GYM
	warp_def $11, $5, 27, SAFFRON_GYM
	warp_def $9, $5, 28, SAFFRON_GYM
	warp_def $3, $9, 29, SAFFRON_GYM
	warp_def $9, $f, 30, SAFFRON_GYM
	warp_def $5, $f, 31, SAFFRON_GYM
	warp_def $5, $1, 32, SAFFRON_GYM
	warp_def $11, $13, 3, SAFFRON_GYM
	warp_def $9, $13, 4, SAFFRON_GYM
	warp_def $9, $1, 5, SAFFRON_GYM
	warp_def $5, $5, 6, SAFFRON_GYM
	warp_def $3, $b, 7, SAFFRON_GYM
	warp_def $11, $1, 8, SAFFRON_GYM
	warp_def $5, $13, 9, SAFFRON_GYM
	warp_def $f, $f, 10, SAFFRON_GYM
	warp_def $f, $5, 11, SAFFRON_GYM
	warp_def $b, $5, 12, SAFFRON_GYM
	warp_def $5, $9, 13, SAFFRON_GYM
	warp_def $b, $f, 14, SAFFRON_GYM
	warp_def $3, $f, 15, SAFFRON_GYM
	warp_def $3, $1, 16, SAFFRON_GYM
	warp_def $9, $b, 17, SAFFRON_GYM

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 15, 8, SIGNPOST_READ, SaffronGymStatue

.PersonEvents:
	db 6
	person_event SPRITE_SABRINA, 8, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SabrinaScript_0x189c2e, -1
	person_event SPRITE_GRANNY, 16, 17, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerMediumRebecca, -1
	person_event SPRITE_YOUNGSTER, 16, 3, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerPsychicFranklin, -1
	person_event SPRITE_GRANNY, 4, 3, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerMediumDoris, -1
	person_event SPRITE_YOUNGSTER, 4, 17, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerPsychicJared, -1
	person_event SPRITE_GYM_GUY, 14, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SaffronGymGuyScript, -1
