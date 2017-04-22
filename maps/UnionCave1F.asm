const_value set 2
	const UNIONCAVE1F_POKEFAN_M1
	const UNIONCAVE1F_SUPER_NERD
	const UNIONCAVE1F_POKEFAN_M2
	const UNIONCAVE1F_FISHER1
	const UNIONCAVE1F_FISHER2
	const UNIONCAVE1F_POKEFAN_M3
	const UNIONCAVE1F_POKE_BALL1
	const UNIONCAVE1F_POKE_BALL2
	const UNIONCAVE1F_POKE_BALL3
	const UNIONCAVE1F_POKE_BALL4

UnionCave1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerPokemaniacLarry:
	trainer EVENT_BEAT_POKEMANIAC_LARRY, POKEMANIAC, LARRY, PokemaniacLarrySeenText, PokemaniacLarryBeatenText, 0, PokemaniacLarryScript

PokemaniacLarryScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x59d31
	waitbutton
	closetext
	end

TrainerHikerRussell:
	trainer EVENT_BEAT_HIKER_RUSSELL, HIKER, RUSSELL, HikerRussellSeenText, HikerRussellBeatenText, 0, HikerRussellScript

HikerRussellScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x59c6c
	waitbutton
	closetext
	end

TrainerHikerDaniel:
	trainer EVENT_BEAT_HIKER_DANIEL, HIKER, DANIEL, HikerDanielSeenText, HikerDanielBeatenText, 0, HikerDanielScript

HikerDanielScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x59dc9
	waitbutton
	closetext
	end

TrainerFirebreatherBill:
	trainer EVENT_BEAT_FIREBREATHER_BILL, FIREBREATHER, BILL, FirebreatherBillSeenText, FirebreatherBillBeatenText, 0, FirebreatherBillScript

FirebreatherBillScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x59e6f
	waitbutton
	closetext
	end

TrainerFirebreatherRay:
	trainer EVENT_BEAT_FIREBREATHER_RAY, FIREBREATHER, RAY, FirebreatherRaySeenText, FirebreatherRayBeatenText, 0, FirebreatherRayScript

FirebreatherRayScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x59efc
	waitbutton
	closetext
	end

TrainerRuin_maniacJones:
	trainer EVENT_BEAT_RUIN_MANIAC_JONES, RUIN_MANIAC, JONES, Ruin_maniacJonesSeenText, Ruin_maniacJonesBeatenText, 0, Ruin_maniacJonesScript

Ruin_maniacJonesScript:
	end_if_just_battled
	opentext
	writetext Ruin_maniacJonesAfterText
	waitbutton
	closetext
	end

UnionCave1FGreatBall:
	itemball GREAT_BALL

UnionCave1FXAttack:
	itemball X_ATTACK

UnionCave1FPotion:
	itemball POTION

UnionCave1FAwakening:
	itemball AWAKENING

UnknownScript_0x59c08:
	jumptext UnknownText_0x59f29

UnionCave1FHiddenGreatBall:
	dwb EVENT_UNION_CAVE_1F_HIDDEN_GREAT_BALL, GREAT_BALL

UnionCave1FHiddenBigPearl:
	dwb EVENT_UNION_CAVE_1F_HIDDEN_BIG_PEARL, BIG_PEARL

UnionCave1FHiddenParlyzHeal:
	dwb EVENT_UNION_CAVE_1F_HIDDEN_PARLYZ_HEAL, PARLYZ_HEAL

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

UnknownText_0x59f29:
	text "Union Cave"
	done

UnionCave1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $3, $3, 3, UNION_CAVE_B1F_NORTH
	warp_def $2d, $3, 1, UNION_CAVE_B1F_SOUTH
	warp_def $2b, $11, 1, ROUTE_33
	warp_def $f, $11, 4, ROUTE_32

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 19, 7, SIGNPOST_ITEM, UnionCave1FHiddenGreatBall
	signpost 33, 2, SIGNPOST_ITEM, UnionCave1FHiddenBigPearl
	signpost 33, 8, SIGNPOST_ITEM, UnionCave1FHiddenParlyzHeal

.PersonEvents:
	db 10
	person_event SPRITE_POKEFAN_M, 18, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerHikerDaniel, -1
	person_event SPRITE_SUPER_NERD, 37, 7, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerPokemaniacLarry, -1
	person_event SPRITE_POKEFAN_M, 20, 11, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerHikerRussell, -1
	person_event SPRITE_FISHER, 39, 15, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerFirebreatherRay, -1
	person_event SPRITE_FISHER, 32, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerFirebreatherBill, -1
	person_event SPRITE_POKEFAN_M, 3, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerRuin_maniacJones, -1
	person_event SPRITE_BALL_CUT_FRUIT, 33, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, UnionCave1FGreatBall, EVENT_UNION_CAVE_1F_GREAT_BALL
	person_event SPRITE_BALL_CUT_FRUIT, 8, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, UnionCave1FXAttack, EVENT_UNION_CAVE_1F_X_ATTACK
	person_event SPRITE_BALL_CUT_FRUIT, 28, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, UnionCave1FPotion, EVENT_UNION_CAVE_1F_POTION
	person_event SPRITE_BALL_CUT_FRUIT, 45, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, UnionCave1FAwakening, EVENT_UNION_CAVE_1F_AWAKENING
