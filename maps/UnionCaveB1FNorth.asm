UnionCaveB1FNorth_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

UnionCaveB1FNorth_MapEventHeader:

.Warps: db 3
	warp_def $3, $3, 7, RUINS_OF_ALPH_OUTSIDE
	warp_def $b, $3, 8, RUINS_OF_ALPH_OUTSIDE
	warp_def $17, $f, 1, UNION_CAVE_1F

.XYTriggers: db 0

.Signposts: db 2
	signpost 23, 11, SIGNPOST_ITEM, UnionCaveB1FNorthHiddenXSpeed
	signpost 4, 13, SIGNPOST_ITEM, UnionCaveB1FNorthHiddenRevive

.PersonEvents: db 5
	person_event SPRITE_POKEFAN_M, 4, 9, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerRuin_maniacLeland, -1
	person_event SPRITE_POKEFAN_M, 10, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerRuin_maniacPetry, -1
	person_event SPRITE_BALL_CUT_FRUIT, 22, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TMHMBALL, 0, TM_SWIFT, EVENT_UNION_CAVE_B1F_NORTH_TM_SWIFT
	person_event SPRITE_BALL_CUT_FRUIT, 21, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, X_DEFEND, 1, EVENT_UNION_CAVE_B1F_NORTH_X_DEFEND
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 10, 7, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, strengthboulder, 0, -1

TrainerRuin_maniacLeland:
	trainer EVENT_BEAT_RUIN_MANIAC_LELAND, RUIN_MANIAC, LELAND, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I'm on the trail of"
	line "an ancient ruin"
	cont "site!"
	done

.BeatenText:
	text "I was distracted"
	line "by clues the"
	cont "ancients left."
	done

.AfterText:
	text "Someday I'll dis-"
	line "cover a new ruin"
	cont "and become famous."
	done

TrainerRuin_maniacPetry:
	trainer EVENT_BEAT_RUIN_MANIAC_PETRY, RUIN_MANIAC, PETRY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I'll go anywhere"
	line "to investigate"
	cont "old secrets and"
	cont "legends."
	done

.BeatenText:
	text "What is the secret"
	line "of your power?"
	done

.AfterText:
	text "Ancient history"
	line "is my passion,"

	para "but to investigate"
	line "it properly we use"
	cont "modern technology."
	done

UnionCaveB1FNorthHiddenXSpeed:
	dwb EVENT_UNION_CAVE_B1F_NORTH_HIDDEN_X_SPEED, X_SPEED

UnionCaveB1FNorthHiddenRevive:
	dwb EVENT_UNION_CAVE_B1F_NORTH_HIDDEN_REVIVE, REVIVE
