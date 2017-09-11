DanceTheatre_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

DanceTheatre_MapEventHeader:

.Warps: db 2
	warp_def 13, 5, 8, ECRUTEAK_CITY
	warp_def 13, 6, 8, ECRUTEAK_CITY

.XYTriggers: db 0

.Signposts: db 2
	signpost 6, 5, SIGNPOST_UP, MapDanceTheatreSignpost1Script
	signpost 6, 6, SIGNPOST_UP, MapDanceTheatreSignpost1Script

.PersonEvents: db 10
	person_event SPRITE_KIMONO_GIRL, 2, 0, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 0, TrainerKimono_girlNaoko, -1
	person_event SPRITE_KIMONO_GIRL, 1, 2, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 0, TrainerKimono_girlSayo, -1
	person_event SPRITE_KIMONO_GIRL, 2, 6, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 0, TrainerKimono_girlZuki, -1
	person_event SPRITE_KIMONO_GIRL, 1, 9, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 0, TrainerKimono_girlKuni, -1
	person_event SPRITE_KIMONO_GIRL, 2, 11, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 0, TrainerKimono_girlMiki, -1
	person_event SPRITE_GENTLEMAN, 10, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GentlemanScript_0x994c6, -1
	person_event SPRITE_RHYDON, 8, 6, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_POKEMON, RHYDON, UnknownText_0x99a0a, -1
	person_event SPRITE_COOLTRAINER_M, 10, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x99a24, -1
	person_event SPRITE_GRANNY, 6, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x99aaa, -1
	person_event SPRITE_LADY, 10, 1, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, DanceTheatreLadyText, -1

TrainerKimono_girlNaoko:
	trainer EVENT_BEAT_KIMONO_GIRL_NAOKO, KIMONO_GIRL, NAOKO, Kimono_girlNaokoSeenText, Kimono_girlNaokoBeatenText, 0, Kimono_girlNaokoScript

Kimono_girlNaokoScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x99579

TrainerKimono_girlSayo:
	trainer EVENT_BEAT_KIMONO_GIRL_SAYO, KIMONO_GIRL, SAYO, Kimono_girlSayoSeenText, Kimono_girlSayoBeatenText, 0, Kimono_girlSayoScript

Kimono_girlSayoScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x9960b

TrainerKimono_girlZuki:
	trainer EVENT_BEAT_KIMONO_GIRL_ZUKI, KIMONO_GIRL, ZUKI, Kimono_girlZukiSeenText, Kimono_girlZukiBeatenText, 0, Kimono_girlZukiScript

Kimono_girlZukiScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x99688

TrainerKimono_girlKuni:
	trainer EVENT_BEAT_KIMONO_GIRL_KUNI, KIMONO_GIRL, KUNI, Kimono_girlKuniSeenText, Kimono_girlKuniBeatenText, 0, Kimono_girlKuniScript

Kimono_girlKuniScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x99714

TrainerKimono_girlMiki:
	trainer EVENT_BEAT_KIMONO_GIRL_MIKI, KIMONO_GIRL, MIKI, Kimono_girlMikiSeenText, Kimono_girlMikiBeatenText, 0, Kimono_girlMikiScript

Kimono_girlMikiScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x997a8

GentlemanScript_0x994c6:
	faceplayer
	opentext
	writetext UnknownText_0x9980a
	buttonsound
	checkevent EVENT_GOT_HM03_SURF
	iftrue UnknownScript_0x99515
	checkevent EVENT_BEAT_KIMONO_GIRL_NAOKO
	iffalse UnknownScript_0x994f3
	checkevent EVENT_BEAT_KIMONO_GIRL_SAYO
	iffalse UnknownScript_0x994f3
	checkevent EVENT_BEAT_KIMONO_GIRL_ZUKI
	iffalse UnknownScript_0x994f3
	checkevent EVENT_BEAT_KIMONO_GIRL_KUNI
	iffalse UnknownScript_0x994f3
	checkevent EVENT_BEAT_KIMONO_GIRL_MIKI
	iffalse UnknownScript_0x994f3
	jump UnknownScript_0x99505

UnknownScript_0x994f3:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue UnknownScript_0x994ff
	jumpopenedtext UnknownText_0x99891

UnknownScript_0x994ff:
	jumpopenedtext UnknownText_0x998d4

UnknownScript_0x99505:
	writetext UnknownText_0x9991a
	buttonsound
	verbosegivetmhm HM_SURF
	setevent EVENT_GOT_HM03_SURF
	jumpopenedtext UnknownText_0x9999b

UnknownScript_0x99515:
	jumpopenedtext UnknownText_0x999d5

MapDanceTheatreSignpost1Script:
	jumptext UnknownText_0x99b79

Kimono_girlNaokoSeenText:
	text "You have lovely"
	line "#mon. May I see"
	cont "them in battle?"
	done

Kimono_girlNaokoBeatenText:
	text "Oh, you are very"
	line "strong."
	done

UnknownText_0x99579:
	text "I enjoyed that"
	line "bout. I would like"
	cont "to see you again."
	done

Kimono_girlSayoSeenText:
	text "I always dance"
	line "with my #mon."

	para "Of course, I also"
	line "train them."
	done

Kimono_girlSayoBeatenText:
	text "Oh, so close!"
	line "I almost had you."
	done

UnknownText_0x9960b:
	text "Rhythm is impor-"
	line "tant for both"

	para "dancing and #-"
	line "mon."
	done

Kimono_girlZukiSeenText:
	text "Isn't my barrette"
	line "pretty?"

	para "Oh. A #mon"
	line "battle?"
	done

Kimono_girlZukiBeatenText:
	text "I don't have any"
	line "#mon left…"
	done

UnknownText_0x99688:
	text "I put a different"
	line "flower in my bar-"
	cont "rette every month."
	done

Kimono_girlKuniSeenText:
	text "Oh, you're a cute"
	line "trainer. Would you"
	cont "like to battle?"
	done

Kimono_girlKuniBeatenText:
	text "You're stronger"
	line "than you look."
	done

UnknownText_0x99714:
	text "I trained a lot,"
	line "so I thought I was"

	para "a capable trainer."
	line "I guess I'm not."
	done

Kimono_girlMikiSeenText:
	text "Do you like my"
	line "dancing? I'm good"
	cont "at #mon too."
	done

Kimono_girlMikiBeatenText:
	text "Ooh, you're good"
	line "at #mon too."
	done

UnknownText_0x997a8:
	text "I can keep dancing"
	line "because there are"

	para "people who enjoy"
	line "what I do."

	para "My #mon keep my"
	line "spirits up too."
	done

UnknownText_0x9980a:
	text "Not only are the"
	line "Kimono Girls great"

	para "dancers, they're"
	line "also skilled at"
	cont "#mon."

	para "I always challenge"
	line "them, but I've"

	para "never even left a"
	line "scratch…"
	done

UnknownText_0x99891:
	text "Lad! If you can"
	line "defeat all the"

	para "Kimono Girls, I'll"
	line "give you a gift."
	done

UnknownText_0x998d4:
	text "Lassie, if you can"
	line "defeat all the"

	para "Kimono Girls, I'll"
	line "give you a gift."
	done

UnknownText_0x9991a:
	text "The way you bat-"
	line "tled, it was like"
	cont "watching a dance."

	para "It was a rare"
	line "treat to see!"

	para "I want you to have"
	line "this. Don't worry"
	cont "--take it!"
	done

UnknownText_0x9999b:
	text "That's Surf."

	para "It's a move that"
	line "lets #mon swim"
	cont "across water."
	done

UnknownText_0x999d5:
	text "I wish my #mon"
	line "were as elegant as"
	cont "the Kimono Girls"
	done

UnknownText_0x99a0a:
	text "Rhydon: Gugooh"
	line "gugogooh!"
	done

UnknownText_0x99a24:
	text "That man's always"
	line "with his Rhydon."

	para "Says he wants a"
	line "#mon that can"
	cont "Surf and dance."

	para "Is he trying to"
	line "make a synchro-"
	cont "nized swimming"
	cont "#mon?"
	done

UnknownText_0x99aaa:
	text "The Kimono Girls"
	line "are so beautiful…"

	para "But they have to"
	line "go through rigor-"
	cont "ous training."

	para "And they have to"
	line "learn to follow"

	para "customs before ap-"
	line "pearing in public."

	para "But if you love"
	line "something, any-"
	cont "thing is possible."
	done

DanceTheatreLadyText:
	text "Eevee can evolve"
	line "into Leafeon, Gla-"
	cont "ceon, or Sylveon,"

	para "but none of the"
	line "Kimono Girls use"
	cont "those #mon."

	para "I wonder why?"
	done

UnknownText_0x99b79:
	text "It's a fancy panel"
	line "that's decorated"
	cont "with flowers."
	done
