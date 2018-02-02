UnionCave1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 3, 3, UNION_CAVE_B1F_NORTH, 3
	warp_event 3, 45, UNION_CAVE_B1F_SOUTH, 1
	warp_event 17, 43, ROUTE_33, 1
	warp_event 17, 15, ROUTE_32, 4

	db 0 ; coord events

	db 3 ; bg events
	bg_event 7, 19, SIGNPOST_ITEM + GREAT_BALL, EVENT_UNION_CAVE_1F_HIDDEN_GREAT_BALL
	bg_event 2, 33, SIGNPOST_ITEM + BIG_PEARL, EVENT_UNION_CAVE_1F_HIDDEN_BIG_PEARL
	bg_event 8, 33, SIGNPOST_ITEM + PARLYZ_HEAL, EVENT_UNION_CAVE_1F_HIDDEN_PARLYZ_HEAL

	db 10 ; object events
	object_event 3, 18, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerHikerDaniel, -1
	object_event 7, 37, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerPokemaniacLarry, -1
	object_event 11, 20, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerHikerRussell, -1
	object_event 15, 39, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerFirebreatherRay, -1
	object_event 11, 32, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerFirebreatherBill, -1
	object_event 5, 3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerRuin_maniacJones, -1
	itemball_event 15, 33, GREAT_BALL, 1, EVENT_UNION_CAVE_1F_GREAT_BALL
	itemball_event 2, 8, X_ATTACK, 1, EVENT_UNION_CAVE_1F_X_ATTACK
	itemball_event 3, 28, POTION, 1, EVENT_UNION_CAVE_1F_POTION
	itemball_event 12, 45, AWAKENING, 1, EVENT_UNION_CAVE_1F_AWAKENING

TrainerPokemaniacLarry:
	trainer POKEMANIAC, LARRY, EVENT_BEAT_POKEMANIAC_LARRY, PokemaniacLarrySeenText, PokemaniacLarryBeatenText, 0, PokemaniacLarryScript

PokemaniacLarryScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x59d31

TrainerHikerRussell:
	trainer HIKER, RUSSELL, EVENT_BEAT_HIKER_RUSSELL, HikerRussellSeenText, HikerRussellBeatenText, 0, HikerRussellScript

HikerRussellScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x59c6c

TrainerHikerDaniel:
	trainer HIKER, DANIEL, EVENT_BEAT_HIKER_DANIEL, HikerDanielSeenText, HikerDanielBeatenText, 0, HikerDanielScript

HikerDanielScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x59dc9

TrainerFirebreatherBill:
	trainer FIREBREATHER, BILL, EVENT_BEAT_FIREBREATHER_BILL, FirebreatherBillSeenText, FirebreatherBillBeatenText, 0, FirebreatherBillScript

FirebreatherBillScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x59e6f

TrainerFirebreatherRay:
	trainer FIREBREATHER, RAY, EVENT_BEAT_FIREBREATHER_RAY, FirebreatherRaySeenText, FirebreatherRayBeatenText, 0, FirebreatherRayScript

FirebreatherRayScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x59efc

TrainerRuin_maniacJones:
	trainer RUIN_MANIAC, JONES, EVENT_BEAT_RUIN_MANIAC_JONES, Ruin_maniacJonesSeenText, Ruin_maniacJonesBeatenText, 0, Ruin_maniacJonesScript

Ruin_maniacJonesScript:
	end_if_just_battled
	jumptextfaceplayer Ruin_maniacJonesAfterText

HikerRussellSeenText:
	text "You're headed to"
	line "Azalea, are you?"

	para "Let my #mon see"
	line "if you are good"
	cont "enough to battle."
	done

HikerRussellBeatenText:
	text "Oh, oh, oh!"
	done

UnknownText_0x59c6c:
	text "All right, then!"
	line "I've decided."

	para "I'm not leaving"
	line "until my #mon"
	cont "get tougher!"
	done

PokemaniacLarrySeenText:
	text "I roam far and"
	line "wide in search of"
	cont "#mon."

	para "Are you looking"
	line "for #mon too?"

	para "Then you're my"
	line "collecting rival!"
	done

PokemaniacLarryBeatenText:
	text "Ugh. My poor #-"
	line "mon…"
	done

UnknownText_0x59d31:
	text "Every Friday, you"
	line "can hear #mon"

	para "roars from deep"
	line "inside the cave."
	done

HikerDanielSeenText:
	text "Whoa! What a"
	line "surprise!"

	para "I didn't expect to"
	line "see anyone here!"
	done

HikerDanielBeatenText:
	text "Whoa! I'm beaten"
	line "big time!"
	done

UnknownText_0x59dc9:
	text "I was conned into"
	line "buying a Slowpoke-"
	cont "Tail."

	para "I feel sorry for"
	line "the poor #mon."
	done

FirebreatherBillSeenText:
	text "Zubat's Supersonic"
	line "keeps confusing"
	cont "my #mon."

	para "I'm seriously"
	line "upset about that!"
	done

FirebreatherBillBeatenText:
	text "I flamed out!"
	done

UnknownText_0x59e6f:
	text "On weekends, you"
	line "can hear strange"

	para "roars from deep in"
	line "the cave."
	done

FirebreatherRaySeenText:
	text "If it's light, a"
	line "cave isn't scary."

	para "If you're strong,"
	line "#mon aren't"
	cont "scary."
	done

FirebreatherRayBeatenText:
	text "Flash!"
	done

UnknownText_0x59efc:
	text "It's my #mon's"
	line "fire that lights"
	cont "up this cave."
	done

Ruin_maniacJonesSeenText:
	text "Have you explored"
	line "the Ruins of Alph?"
	done

Ruin_maniacJonesBeatenText:
	text "Gahahah!"
	done

Ruin_maniacJonesAfterText:
	text "The Ruins are hid-"
	line "ing something…"
	cont "I just know it!"
	done
