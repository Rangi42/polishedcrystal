UnionCaveB1FNorth_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  3,  3, RUINS_OF_ALPH_OUTSIDE, 7
	warp_event  3, 11, RUINS_OF_ALPH_OUTSIDE, 8
	warp_event 15, 23, UNION_CAVE_1F, 1

	db 0 ; coord events

	db 2 ; bg events
	bg_event 11, 23, SIGNPOST_ITEM + X_SPEED, EVENT_UNION_CAVE_B1F_NORTH_HIDDEN_X_SPEED
	bg_event 13,  4, SIGNPOST_ITEM + REVIVE, EVENT_UNION_CAVE_B1F_NORTH_HIDDEN_REVIVE

	db 5 ; object events
	object_event  9,  4, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerRuin_maniacLeland, -1
	object_event 13, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerRuin_maniacPetry, -1
	tmhmball_event  5, 22, TM_SWIFT, EVENT_UNION_CAVE_B1F_NORTH_TM_SWIFT
	itemball_event 17, 21, X_DEFEND, 1, EVENT_UNION_CAVE_B1F_NORTH_X_DEFEND
	strengthboulder_event  7, 10

GenericTrainerRuin_maniacLeland:
	generictrainer RUIN_MANIAC, LELAND, EVENT_BEAT_RUIN_MANIAC_LELAND, .SeenText, .BeatenText

	text "Someday I'll dis-"
	line "cover a new ruin"
	cont "and become famous."
	done

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

GenericTrainerRuin_maniacPetry:
	generictrainer RUIN_MANIAC, PETRY, EVENT_BEAT_RUIN_MANIAC_PETRY, .SeenText, .BeatenText

	text "Ancient history"
	line "is my passion,"

	para "but to investigate"
	line "it properly we use"
	cont "modern technology."
	done

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

