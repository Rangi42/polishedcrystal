Route3PokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, ROUTE_3, 2
	warp_event  6,  7, ROUTE_3, 2
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalKarenScript

	def_object_events
	pc_nurse_event  5, 1
	object_event  9,  4, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route3PokeCenter1FPokefanM1Text, -1
	object_event  2,  5, SPRITE_HIKER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route3PokeCenter1FPokefanM2Text, -1
	object_event 11,  3, SPRITE_CAMPER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route3PokeCenter1FYoungsterText, -1

PokemonJournalKarenScript:
	setflag ENGINE_READ_KAREN_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Elite Four Karen!"

	para "Karen supposedly"
	line "began training"

	para "Dark-type #mon"
	line "to help overcome"

	para "their sinister"
	line "reputation."
	done

Route3PokeCenter1FPokefanM1Text:
	text "A few years ago"
	line "I sold a weird-"

	para "colored Magikarp"
	line "to this boy…"

	para "I thought there"
	line "was something"
	cont "wrong with it."

	para "Turns out it was"
	line "a rare shiny"
	cont "#mon!"

	para "I could have made"
	line "a lot more money!"
	done

Route3PokeCenter1FPokefanM2Text:
	text "I remember there"
	line "was nothing built"

	para "here when I climb-"
	line "ed the mountain."

	para "Things are more"
	line "convenient now."
	done

Route3PokeCenter1FYoungsterText:
	text "Many trainers are"
	line "on the mountain."

	para "Many wild #mon"
	line "too."

	para "You never know who"
	line "or what you'll en-"
	cont "counter."
	done
