SnowtopPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, SNOWTOP_MOUNTAIN_OUTSIDE, 2
	warp_event  6,  7, SNOWTOP_MOUNTAIN_OUTSIDE, 2
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalProfWillowScript

	def_object_events
	pc_nurse_event  5, 1

PokemonJournalProfWillowScript:
	setflag ENGINE_READ_PROF_WILLOW_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Prof.Willow!"

	para "It's been said that"
	line "Prof.Willow's dream"

	para "is to explore un-"
	line "charted lands and"

	para "document undis-"
	line "covered #mon"

	para "species in their"
	line "natural habitat."
	done
