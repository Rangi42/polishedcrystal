DimCave1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

DimCave1F_MapEventHeader:

.Warps: db 4
	warp_def 2, 30, 5, DIM_CAVE_2F
	warp_def 17, 5, 6, DIM_CAVE_2F
	warp_def 18, 28, 7, DIM_CAVE_2F
	warp_def 32, 24, 8, DIM_CAVE_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 2, 28, SIGNPOST_ITEM + FULL_HEAL, EVENT_DIM_CAVE_1F_HIDDEN_FULL_HEAL

.PersonEvents: db 5
	person_event SPRITE_SUPER_NERD, 7, 30, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerSuper_nerdGregg, -1
	person_event SPRITE_SCIENTIST, 18, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerScientistDexter, -1
	person_event SPRITE_ROCKER, 21, 27, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerGuitaristmBiff, -1
	itemball_event 20, 3, DUSK_BALL, 1, EVENT_DIM_CAVE_1F_DUSK_BALL
	itemball_event 31, 28, RARE_BONE, 1, EVENT_DIM_CAVE_1F_RARE_BONE

TrainerSuper_nerdGregg:
	trainer EVENT_BEAT_SUPER_NERD_GREGG, SUPER_NERD, GREGG, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_SCIENTIST_DEXTER, SCIENTIST, DEXTER, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_GUITARISTM_BIFF, GUITARISTM, BIFF, .SeenText, .BeatenText, 0, .Script

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
