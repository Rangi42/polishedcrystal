RedsHouse2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  0, REDS_HOUSE_1F, 3

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPTEXT, RedsHouse2FPCText
	bg_event  3,  5, BGEVENT_JUMPTEXT, RedsHouse2FSNESText
	bg_event  4,  1, BGEVENT_READ, PokemonJournalProfOakScript
	bg_event  5,  1, BGEVENT_READ, PokemonJournalProfOakScript

	def_object_events

PokemonJournalProfOakScript:
	setflag ENGINE_READ_PROF_OAK_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "#mon Prof.Oak!"

	para "Samuel Oak's grand-"
	line "children, Blue and"

	para "Daisy, live near"
	line "his lab in Pallet"
	cont "Town."

	para "His cousin Samson"
	line "is rumored to live"

	para "in the far-off"
	line "Alola region."
	done

RedsHouse2FPCText:
	text "It looks like it"
	line "hasn't been used"
	cont "in a long time…"
	done

RedsHouse2FSNESText:
	text "<PLAYER> played the"
	line "SNES."

	para "Better get going--"
	line "no time to lose!"
	done
