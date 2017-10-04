BeautifulBeachVilla_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

BeautifulBeachVilla_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 3, BEAUTIFUL_BEACH
	warp_def 7, 3, 3, BEAUTIFUL_BEACH

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 0
	person_event SPRITE_DARACH, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << MORN) | (1 << DAY), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, DarachMornDayText, -1
	person_event SPRITE_DARACH, 4, 10, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << NITE), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, DarachNiteText, -1
	person_event SPRITE_CAITLIN, 4, 1, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, (1 << MORN) | (1 << DAY), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CaitlinMornDayText, -1
	person_event SPRITE_WEIRD_TREE, 2, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << NITE), (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CaitlinNiteScript, -1
	person_event SPRITE_BOOK, 4, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << NITE), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptext, DarachsBookText, -1

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
