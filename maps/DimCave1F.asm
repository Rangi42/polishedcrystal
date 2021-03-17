DimCave1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 30,  2, DIM_CAVE_2F, 5
	warp_event  5, 17, DIM_CAVE_2F, 6
	warp_event 28, 18, DIM_CAVE_2F, 7
	warp_event 24, 32, DIM_CAVE_2F, 8

	def_coord_events

	def_bg_events
	bg_event 28,  2, BGEVENT_ITEM + FULL_HEAL, EVENT_DIM_CAVE_1F_HIDDEN_FULL_HEAL

	def_object_events
	object_event 30,  7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSuper_nerdGregg, -1
	object_event 12, 18, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerScientistDexter, -1
	object_event 27, 21, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerGuitaristmBiff, -1
	itemball_event  3, 20, DUSK_BALL, 1, EVENT_DIM_CAVE_1F_DUSK_BALL
	itemball_event 28, 31, RARE_BONE, 1, EVENT_DIM_CAVE_1F_RARE_BONE

GenericTrainerSuper_nerdGregg:
	generictrainer SUPER_NERD, GREGG, EVENT_BEAT_SUPER_NERD_GREGG, .SeenText, .BeatenText

	text "The Magnet Train"
	line "is fast, but it"
	cont "can't drift."
	done

.SeenText:
	text "These carts are"
	line "lame! They can't"
	cont "drift at all!"
	done

.BeatenText:
	text "I don't care!"
	done

GenericTrainerScientistDexter:
	generictrainer SCIENTIST, DEXTER, EVENT_BEAT_SCIENTIST_DEXTER, .SeenText, .BeatenText

	text "I work for the"
	line "Power Plant."

	para "We use the water-"
	line "fall from this"
	cont "cave for clean,"
	cont "renewable energy!"
	done

.SeenText:
	text "I'm a hydrologist"
	line "first, and a"
	cont "trainer second."
	done

.BeatenText:
	text "I should stick to"
	line "hydrology…"
	done

GenericTrainerGuitaristmBiff:
	generictrainer GUITARISTM, BIFF, EVENT_BEAT_GUITARISTM_BIFF, .SeenText, .BeatenText

	text "I love heavy metal"
	line "and heavy metals!"
	done

.SeenText:
	text "I dig rock and"
	line "dig rock!"
	done

.BeatenText:
	text "Ground into the"
	line "ground!"
	done

