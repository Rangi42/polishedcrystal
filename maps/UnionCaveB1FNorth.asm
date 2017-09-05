UnionCaveB1FNorth_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

UnionCaveB1FNorth_MapEventHeader:

.Warps: db 3
	warp_def 3, 3, 7, RUINS_OF_ALPH_OUTSIDE
	warp_def 11, 3, 8, RUINS_OF_ALPH_OUTSIDE
	warp_def 23, 15, 1, UNION_CAVE_1F

.XYTriggers: db 0

.Signposts: db 2
	signpost 23, 11, SIGNPOST_ITEM + X_SPEED, EVENT_UNION_CAVE_B1F_NORTH_HIDDEN_X_SPEED
	signpost 4, 13, SIGNPOST_ITEM + REVIVE, EVENT_UNION_CAVE_B1F_NORTH_HIDDEN_REVIVE

.PersonEvents: db 5
	person_event SPRITE_POKEFAN_M, 4, 9, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerRuin_maniacLeland, -1
	person_event SPRITE_POKEFAN_M, 10, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerRuin_maniacPetry, -1
	tmhmball_event 22, 5, TM_SWIFT, EVENT_UNION_CAVE_B1F_NORTH_TM_SWIFT
	itemball_event 21, 17, X_DEFEND, 1, EVENT_UNION_CAVE_B1F_NORTH_X_DEFEND
	strengthboulder_event 10, 7

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
