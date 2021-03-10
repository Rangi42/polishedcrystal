DanceTheatre_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5, 13, ECRUTEAK_CITY, 8
	warp_event  6, 13, ECRUTEAK_CITY, 8

	def_coord_events

	def_bg_events
	bg_event  5,  6, BGEVENT_UP, MapDanceTheatreSignpost1Script
	bg_event  6,  6, BGEVENT_UP, MapDanceTheatreSignpost1Script

	def_object_events
	object_event  0,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 0, GenericTrainerKimono_girlNaoko, -1
	object_event  2,  1, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_GENERICTRAINER, 0, GenericTrainerKimono_girlSayo, -1
	object_event  6,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 0, GenericTrainerKimono_girlZuki, -1
	object_event  9,  1, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 0, GenericTrainerKimono_girlKuni, -1
	object_event 11,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_GENERICTRAINER, 0, GenericTrainerKimono_girlMiki, -1
	object_event  7, 10, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DanceTheaterSurfGuy, -1
	pokemon_event  6,  8, RHYDON, -1, -1, PAL_NPC_BROWN, RhydonText, -1
	object_event 10, 10, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, DanceTheatreCooltrainerMText, -1
	object_event  3,  6, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, DanceTheatreGrannyText, -1
	object_event  1, 10, SPRITE_LADY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, DanceTheatreLadyText, -1

GenericTrainerKimono_girlNaoko:
	generictrainer KIMONO_GIRL_1, NAOKO, EVENT_BEAT_KIMONO_GIRL_NAOKO, Kimono_girlNaokoSeenText, Kimono_girlNaokoBeatenText

	text "I enjoyed that"
	line "bout. I would like"
	cont "to see you again."
	done

GenericTrainerKimono_girlSayo:
	generictrainer KIMONO_GIRL_2, SAYO, EVENT_BEAT_KIMONO_GIRL_SAYO, Kimono_girlSayoSeenText, Kimono_girlSayoBeatenText

	text "Rhythm is impor-"
	line "tant for both"

	para "dancing and #-"
	line "mon."
	done

GenericTrainerKimono_girlZuki:
	generictrainer KIMONO_GIRL_3, ZUKI, EVENT_BEAT_KIMONO_GIRL_ZUKI, Kimono_girlZukiSeenText, Kimono_girlZukiBeatenText

	text "I put a different"
	line "flower in my bar-"
	cont "rette every month."
	done

GenericTrainerKimono_girlKuni:
	generictrainer KIMONO_GIRL_4, KUNI, EVENT_BEAT_KIMONO_GIRL_KUNI, Kimono_girlKuniSeenText, Kimono_girlKuniBeatenText

	text "I trained a lot,"
	line "so I thought I was"

	para "a capable trainer."
	line "I guess I'm not."
	done

GenericTrainerKimono_girlMiki:
	generictrainer KIMONO_GIRL_5, MIKI, EVENT_BEAT_KIMONO_GIRL_MIKI, Kimono_girlMikiSeenText, Kimono_girlMikiBeatenText

	text "I can keep dancing"
	line "because there are"

	para "people who enjoy"
	line "what I do."

	para "My #mon keep my"
	line "spirits up too."
	done

DanceTheaterSurfGuy:
	faceplayer
	opentext
	writetext SurfGuyNeverLeftAScratchText
	buttonsound
	checkevent EVENT_GOT_HM03_SURF
	iftrue_jumpopenedtext SurfGuyElegantKimonoGirlsText
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
	writetext SurfGuyLikeADanceText
	buttonsound
	verbosegivetmhm HM_SURF
	setevent EVENT_GOT_HM03_SURF
	jumpthisopenedtext

	text "That's Surf."

	para "It's a move that"
	line "lets #mon swim"
	cont "across water."
	done

UnknownScript_0x994f3:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue_jumpopenedtext SurfGuyLassieGiftText
	jumpthisopenedtext

SurfGuyLadGiftText:
	text "Lad! If you can"
	line "defeat all the"

	para "Kimono Girls, I'll"
	line "give you a gift."
	done

MapDanceTheatreSignpost1Script:
	jumptext DanceTheatreFancyPanelText

Kimono_girlNaokoSeenText:
	text "You have lovely"
	line "#mon. May I see"
	cont "them in battle?"
	done

Kimono_girlNaokoBeatenText:
	text "Oh, you are very"
	line "strong."
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

Kimono_girlKuniSeenText:
	text "Oh, you're a cute"
	line "trainer. Would you"
	cont "like to battle?"
	done

Kimono_girlKuniBeatenText:
	text "You're stronger"
	line "than you look."
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

SurfGuyNeverLeftAScratchText:
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

SurfGuyLassieGiftText:
	text "Lassie, if you can"
	line "defeat all the"

	para "Kimono Girls, I'll"
	line "give you a gift."
	done

SurfGuyLikeADanceText:
	text "The way you bat-"
	line "tled, it was like"
	cont "watching a dance."

	para "It was a rare"
	line "treat to see!"

	para "I want you to have"
	line "this. Don't worry"
	cont "--take it!"
	done

SurfGuyElegantKimonoGirlsText:
	text "I wish my #mon"
	line "were as elegant as"
	cont "the Kimono Girls."
	done

RhydonText:
	text "Rhydon: Gugooh"
	line "gugogooh!"
	done

DanceTheatreCooltrainerMText:
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

DanceTheatreGrannyText:
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

DanceTheatreFancyPanelText:
	text "It's a fancy panel"
	line "that's decorated"
	cont "with flowers."
	done
