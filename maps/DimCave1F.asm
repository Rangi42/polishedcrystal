DimCave1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 30, 2, DIM_CAVE_2F, 5
	warp_event 5, 17, DIM_CAVE_2F, 6
	warp_event 28, 18, DIM_CAVE_2F, 7
	warp_event 24, 32, DIM_CAVE_2F, 8

	db 0 ; coord events

	db 1 ; bg events
	bg_event 28, 2, SIGNPOST_ITEM + FULL_HEAL, EVENT_DIM_CAVE_1F_HIDDEN_FULL_HEAL

	db 5 ; object events
	object_event 30, 7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerSuper_nerdGregg, -1
	object_event 12, 18, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerScientistDexter, -1
	object_event 27, 21, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerGuitaristmBiff, -1
	itemball_event 3, 20, DUSK_BALL, 1, EVENT_DIM_CAVE_1F_DUSK_BALL
	itemball_event 28, 31, RARE_BONE, 1, EVENT_DIM_CAVE_1F_RARE_BONE

TrainerSuper_nerdGregg:
	trainer SUPER_NERD, GREGG, EVENT_BEAT_SUPER_NERD_GREGG, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "These carts are"
	line "lame! They can't"
	cont "drift at all!"
	done

.BeatenText:
	text "I don't care!"
	done

.AfterText:
	text "The Magnet Train"
	line "is fast, but it"
	cont "can't drift."
	done

TrainerScientistDexter:
	trainer SCIENTIST, DEXTER, EVENT_BEAT_SCIENTIST_DEXTER, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I'm a hydrologist"
	line "first, and a"
	cont "trainer second."
	done

.BeatenText:
	text "I should stick to"
	line "hydrology…"
	done

.AfterText:
	text "I work for the"
	line "Power Plant."

	para "We use the water-"
	line "fall from this"
	cont "cave for clean,"
	cont "renewable energy!"
	done

TrainerGuitaristmBiff:
	trainer GUITARISTM, BIFF, EVENT_BEAT_GUITARISTM_BIFF, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I dig rock and"
	line "dig rock!"
	done

.BeatenText:
	text "Ground into the"
	line "ground!"
	done

.AfterText:
	text "I love heavy metal"
	line "and heavy metals!"
	done
