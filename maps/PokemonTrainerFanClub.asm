PokemonTrainerFanClub_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  9, SAFFRON_CITY, 16
	warp_event  5,  9, SAFFRON_CITY, 16

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, PokemonJournalBrunoScript
	bg_event  1,  1, BGEVENT_READ, PokemonJournalBrunoScript

	def_object_events

PokemonJournalBrunoScript:
	setflag ENGINE_READ_BRUNO_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Elite Four Bruno!"

	para "Bruno apparently"
	line "joined the Elite"

	para "Four out of his"
	line "burning ambition"

	para "to battle the"
	line "best trainers."
	done
