UnionCave1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

UnionCave1F_MapEventHeader:

.Warps: db 4
	warp_def 3, 3, 3, UNION_CAVE_B1F_NORTH
	warp_def 45, 3, 1, UNION_CAVE_B1F_SOUTH
	warp_def 43, 17, 1, ROUTE_33
	warp_def 15, 17, 4, ROUTE_32

.XYTriggers: db 0

.Signposts: db 3
	signpost 19, 7, SIGNPOST_ITEM + GREAT_BALL, EVENT_UNION_CAVE_1F_HIDDEN_GREAT_BALL
	signpost 33, 2, SIGNPOST_ITEM + BIG_PEARL, EVENT_UNION_CAVE_1F_HIDDEN_BIG_PEARL
	signpost 33, 8, SIGNPOST_ITEM + PARLYZ_HEAL, EVENT_UNION_CAVE_1F_HIDDEN_PARLYZ_HEAL

.PersonEvents: db 10
	person_event SPRITE_POKEFAN_M, 18, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerHikerDaniel, -1
	person_event SPRITE_SUPER_NERD, 37, 7, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerPokemaniacLarry, -1
	person_event SPRITE_POKEFAN_M, 20, 11, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerHikerRussell, -1
	person_event SPRITE_FISHER, 39, 15, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerFirebreatherRay, -1
	person_event SPRITE_FISHER, 32, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerFirebreatherBill, -1
	person_event SPRITE_POKEFAN_M, 3, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerRuin_maniacJones, -1
	itemball_event 33, 15, GREAT_BALL, 1, EVENT_UNION_CAVE_1F_GREAT_BALL
	itemball_event 8, 2, X_ATTACK, 1, EVENT_UNION_CAVE_1F_X_ATTACK
	itemball_event 28, 3, POTION, 1, EVENT_UNION_CAVE_1F_POTION
	itemball_event 45, 12, AWAKENING, 1, EVENT_UNION_CAVE_1F_AWAKENING

TrainerPokemaniacLarry:
	trainer EVENT_BEAT_POKEMANIAC_LARRY, POKEMANIAC, LARRY, PokemaniacLarrySeenText, PokemaniacLarryBeatenText, 0, PokemaniacLarryScript

PokemaniacLarryScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x59d31

TrainerHikerRussell:
	trainer EVENT_BEAT_HIKER_RUSSELL, HIKER, RUSSELL, HikerRussellSeenText, HikerRussellBeatenText, 0, HikerRussellScript

HikerRussellScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x59c6c

TrainerHikerDaniel:
	trainer EVENT_BEAT_HIKER_DANIEL, HIKER, DANIEL, HikerDanielSeenText, HikerDanielBeatenText, 0, HikerDanielScript

HikerDanielScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x59dc9

TrainerFirebreatherBill:
	trainer EVENT_BEAT_FIREBREATHER_BILL, FIREBREATHER, BILL, FirebreatherBillSeenText, FirebreatherBillBeatenText, 0, FirebreatherBillScript

FirebreatherBillScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x59e6f

TrainerFirebreatherRay:
	trainer EVENT_BEAT_FIREBREATHER_RAY, FIREBREATHER, RAY, FirebreatherRaySeenText, FirebreatherRayBeatenText, 0, FirebreatherRayScript

FirebreatherRayScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x59efc

TrainerRuin_maniacJones:
	trainer EVENT_BEAT_RUIN_MANIAC_JONES, RUIN_MANIAC, JONES, Ruin_maniacJonesSeenText, Ruin_maniacJonesBeatenText, 0, Ruin_maniacJonesScript

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
