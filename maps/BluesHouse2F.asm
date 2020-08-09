BluesHouse2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  0, BLUES_HOUSE_1F, 3

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPTEXT, BluesHouse2FPCText
	bg_event  3,  5, BGEVENT_JUMPTEXT, BluesHouse2FSNESText
	bg_event  4,  1, BGEVENT_READ, PokemonJournalProfOakScript
	bg_event  5,  1, BGEVENT_READ, PokemonJournalProfOakScript

	def_object_events

BluesHouse2FPCText:
	text "There's a program"
	line "simulating a bat-"
	cont "tle between a"

	para "Blastoise and a"
	line "Dragonite."
	done

BluesHouse2FSNESText:
	text "<PLAYER> played the"
	line "SNES."

	para "Better get going--"
	line "no time to lose!"
	done
