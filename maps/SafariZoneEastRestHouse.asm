SafariZoneEastRestHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, SAFARI_ZONE_EAST, 5
	warp_event  3,  7, SAFARI_ZONE_EAST, 5

	def_coord_events

	def_bg_events
	bg_event  4,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  5,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  6,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  7,  1, BGEVENT_READ, PokemonJournalKogaScript

	def_object_events
	pokemon_event  3,  1, NIDORINA, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_TEAL, SafariZoneEastRestHouseNidorinaText, -1
	pokemon_event  2,  2, NIDORINO, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_PURPLE, SafariZoneEastRestHouseNidorinoText, -1
	pokemon_event  2,  4, NIDORAN_F, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_TEAL, SafariZoneEastRestHouseNidoranFText, -1
	pokemon_event  5,  5, NIDORAN_M, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_PURPLE, SafariZoneEastRestHouseNidoranMText, -1

SafariZoneEastRestHouseNidorinaText:
	text "Nidorina: Gyaan!"
	done

SafariZoneEastRestHouseNidorinoText:
	text "Nidorino: Gyuun!"
	done

SafariZoneEastRestHouseNidoranFText:
	text "Nidoran: Kyaoo!"
	done

SafariZoneEastRestHouseNidoranMText:
	text "Nidorino: Gauu!"
	done
