const_value set 2
	const QUIETCAVEB1F_BATTLE_GIRL
	const QUIETCAVEB1F_SUPER_NERD
	const QUIETCAVEB1F_POKE_BALL1
	const QUIETCAVEB1F_POKE_BALL2

QuietCaveB1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerBattleGirlKagami:
	trainer EVENT_BEAT_BATTLE_GIRL_KAGAMI, BATTLE_GIRL, KAGAMI, BattleGirlKagamiSeenText, BattleGirlKagamiBeatenText, 0, BattleGirlKagamiScript

BattleGirlKagamiScript:
	end_if_just_battled
	opentext
	writetext BattleGirlKagamiAfterText
	waitbutton
	closetext
	end

TrainerPokemaniacAidan:
	trainer EVENT_BEAT_POKEMANIAC_AIDAN, POKEMANIAC, AIDAN, PokemaniacAidanSeenText, PokemaniacAidanBeatenText, 0, PokemaniacAidanScript

PokemaniacAidanScript:
	end_if_just_battled
	opentext
	writetext PokemaniacAidanAfterText
	waitbutton
	closetext
	end

QuietCaveB1FBigPearl:
	itemball BIG_PEARL

QuietCaveB1FElixir:
	itemball ELIXER

QuietCaveB1FHiddenHyperPotion:
	dwb EVENT_QUIET_CAVE_B1F_HIDDEN_HYPER_POTION, HYPER_POTION

BattleGirlKagamiSeenText:
	text "Don't disturb my"
	line "training!"
	done

BattleGirlKagamiBeatenText:
	text "Not good enough…"
	done

BattleGirlKagamiAfterText:
	text "I come here to"
	line "train in peace"
	cont "and solitude."
	done

PokemaniacAidanSeenText:
	text "My #mon!"

	para "Let me show"
	line "you them!"
	done

PokemaniacAidanBeatenText:
	text "My #mon…"
	done

PokemaniacAidanAfterText:
	text "Sometimes a"
	line "#mon in a"

	para "certain area will"
	line "know a rare move."
	done

QuietCaveB1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 9
	warp_def $19, $5, 2, QUIET_CAVE_1F
	warp_def $17, $1d, 3, QUIET_CAVE_1F
	warp_def $b, $13, 4, QUIET_CAVE_1F
	warp_def $f, $3, 5, QUIET_CAVE_1F
	warp_def $f, $1f, 6, QUIET_CAVE_1F
	warp_def $3, $15, 1, QUIET_CAVE_B2F
	warp_def $19, $11, 2, QUIET_CAVE_B2F
	warp_def $21, $17, 3, QUIET_CAVE_B2F
	warp_def $2, $20, 4, QUIET_CAVE_B2F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 33, 26, SIGNPOST_ITEM, QuietCaveB1FHiddenHyperPotion

.PersonEvents:
	db 4
	person_event SPRITE_COOLTRAINER_F, 4, 25, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBattleGirlKagami, -1
	person_event SPRITE_SUPER_NERD, 17, 21, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 4, TrainerPokemaniacAidan, -1
	person_event SPRITE_BALL_CUT_FRUIT, 3, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, QuietCaveB1FBigPearl, EVENT_QUIET_CAVE_B1F_BIG_PEARL
	person_event SPRITE_BALL_CUT_FRUIT, 13, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, QuietCaveB1FElixir, EVENT_QUIET_CAVE_B1F_ELIXIR
