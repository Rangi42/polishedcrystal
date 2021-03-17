BeautifulBeachVilla_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, BEAUTIFUL_BEACH, 3
	warp_event  3,  7, BEAUTIFUL_BEACH, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  4, SPRITE_DARACH, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << MORN) | (1 << DAY) | (1 << EVE), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, DarachMornDayText, -1
	object_event 10,  4, SPRITE_DARACH, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << NITE), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, DarachNiteText, -1
	object_event  1,  4, SPRITE_CAITLIN, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, (1 << MORN) | (1 << DAY) | (1 << EVE), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CaitlinMornDayText, -1
	object_event  9,  2, SPRITE_WEIRD_TREE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << NITE), PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CaitlinNiteScript, -1
	object_event 11,  4, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << NITE), 0, OBJECTTYPE_COMMAND, jumptext, DarachsBookText, -1

DarachMornDayText:
	text "TODO"
	done

DarachNiteText:
	text "TODO"
	done

CaitlinMornDayText:
	text "TODO"
	done

CaitlinNiteScript:
	jumpthistext

	text "TODO"
	done

DarachsBookText:
	text "TODO"
	done
