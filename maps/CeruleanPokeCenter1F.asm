CeruleanPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, CERULEAN_CITY, 4
	warp_event  6,  7, CERULEAN_CITY, 4
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalMistyScript

	def_object_events
	pc_nurse_event  5, 1
	object_event  1,  5, SPRITE_GYM_GUY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeruleanPokeCenter1FGymGuyScript, -1
	object_event  8,  4, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanPokeCenter1FSuperNerdText, -1

PokemonJournalMistyScript:
	setflag ENGINE_READ_MISTY_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Misty!"

	para "Misty is said to"
	line "worship Lorelei,"

	para "a former member of"
	line "the Elite Four."
	done

CeruleanPokeCenter1FGymGuyScript:
	checkunits
	iftrue_jumptextfaceplayer .MetricText
	jumpthistextfaceplayer

	text "The Magnet Train"
	line "travels at over"

	para "340 mph. It goes"
	line "between Kanto and"

	para "Johto in almost no"
	line "time at all."

	para "It really makes"
	line "Johto accessible."
	done

.MetricText:
	text "The Magnet Train"
	line "travels at over"

	para "550 kph. It goes"
	line "between Kanto and"

	para "Johto in almost no"
	line "time at all."

	para "It really makes"
	line "Johto accessible."
	done

CeruleanPokeCenter1FSuperNerdText:
	text "For battles, I'd"
	line "much rather use"

	para "#mon I've been"
	line "raising, even if"

	para "they're weaker"
	line "than some newly"
	cont "caught #mon."
	done
