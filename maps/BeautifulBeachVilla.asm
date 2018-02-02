BeautifulBeachVilla_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, BEAUTIFUL_BEACH, 3
	warp_event  3,  7, BEAUTIFUL_BEACH, 3

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
	object_event  5,  4, SPRITE_DARACH, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << MORN) | (1 << DAY), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, DarachMornDayText, -1
	object_event 10,  4, SPRITE_DARACH, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << NITE), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, DarachNiteText, -1
	object_event  1,  4, SPRITE_CAITLIN, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, (1 << MORN) | (1 << DAY), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CaitlinMornDayText, -1
	object_event  9,  2, SPRITE_WEIRD_TREE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << NITE), PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, CaitlinNiteScript, -1
	object_event 11,  4, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << NITE), 0, PERSONTYPE_COMMAND, jumptext, DarachsBookText, -1

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
	thistext

	text "TODO"
	done

DarachsBookText:
	text "TODO"
	done
