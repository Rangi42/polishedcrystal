const_value set 2
	const DIMCAVE1F_SUPER_NERD
	const DIMCAVE1F_SCIENTIST
	const DIMCAVE1F_ROCKER
	const DIMCAVE1F_POKE_BALL1
	const DIMCAVE1F_POKE_BALL2

DimCave1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerSuper_nerdGregg:
	trainer EVENT_BEAT_SUPER_NERD_GREGG, SUPER_NERD, GREGG, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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

DimCave1FDuskBall:
	itemball DUSK_BALL

DimCave1FRareBone:
	itemball RARE_BONE

DimCave1FHiddenFullHeal:
	dwb EVENT_DIM_CAVE_1F_HIDDEN_FULL_HEAL, FULL_HEAL

DimCave1F_MapEventHeader:
.Warps:
	db 4
	warp_def $2, $1e, 5, DIM_CAVE_2F
	warp_def $11, $5, 6, DIM_CAVE_2F
	warp_def $12, $1c, 7, DIM_CAVE_2F
	warp_def $20, $18, 8, DIM_CAVE_2F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 2, 28, SIGNPOST_ITEM, DimCave1FHiddenFullHeal

.PersonEvents:
	db 5
	person_event SPRITE_SUPER_NERD, 7, 30, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerSuper_nerdGregg, -1
	person_event SPRITE_SCIENTIST, 18, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerScientistDexter, -1
	person_event SPRITE_ROCKER, 21, 27, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerGuitaristmBiff, -1
	person_event SPRITE_BALL_CUT_FRUIT, 20, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, DimCave1FDuskBall, EVENT_DIM_CAVE_1F_DUSK_BALL
	person_event SPRITE_BALL_CUT_FRUIT, 31, 28, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, DimCave1FRareBone, EVENT_DIM_CAVE_1F_RARE_BONE
