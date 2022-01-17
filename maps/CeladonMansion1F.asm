CeladonMansion1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6,  9, CELADON_CITY, 2
	warp_event  7,  9, CELADON_CITY, 2
	warp_event  3,  0, CELADON_CITY, 3
	warp_event  0,  0, CELADON_MANSION_2F, 1
	warp_event  7,  0, CELADON_MANSION_2F, 4

	def_coord_events

	def_bg_events
	bg_event  5,  8, BGEVENT_UP, CeladonMansionManagersSuiteSign
	bg_event  0,  3, BGEVENT_JUMPSTD, picturebookshelf
	bg_event  2,  3, BGEVENT_JUMPSTD, picturebookshelf

	def_object_events
	object_event  1,  5, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonMansionManagerText, -1
	pokemon_event  2,  6, MEOWTH, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_BROWN, CeladonMansion1FMeowthText, -1
	pokemon_event  3,  4, CLEFAIRY, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_RED, CeladonMansion1FClefairyText, -1
	pokemon_event  4,  4, NIDORAN_F, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_BLUE, CeladonMansion1FNidoranFText, -1

CeladonMansionManagersSuiteSign:
	jumpthistext

	ctxt "Celadon Condo"
	line "Manager's Suite"
	done

CeladonMansionManagerText:
	ctxt "My dear #mon"
	line "keep me company,"

	para "so I don't ever"
	line "feel lonely."

	para "Meowth even brings"
	line "money home."
	done

CeladonMansion1FMeowthText:
	ctxt "Meowth: Meow!"
	done

CeladonMansion1FClefairyText:
	ctxt "Clefairy: Clef"
	line "cleff!"
	done

CeladonMansion1FNidoranFText:
	ctxt "Nidoran: Kya"
	line "kyaoo!"
	done
