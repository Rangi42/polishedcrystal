RockTunnel2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

RockTunnel2F_MapEventHeader:

.Warps: db 2
	warp_def 19, 25, 3, ROUTE_10_NORTH
	warp_def 15, 7, 8, ROCK_TUNNEL_1F

.XYTriggers: db 0

.Signposts: db 1
	signpost 19, 15, SIGNPOST_ITEM + MAX_ETHER, EVENT_ROCK_TUNNEL_2F_HIDDEN_MAX_ETHER

.PersonEvents: db 15
	person_event SPRITE_BALL_CUT_FRUIT, 12, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, RockTunnel2FElectrode, EVENT_ROCK_TUNNEL_2F_ELECTRODE
	itemball_event 23, 2, THUNDERSTONE, 1, EVENT_ROCK_TUNNEL_2F_THUNDERSTONE
	tmhmball_event 9, 25, TM_THUNDER_WAVE, EVENT_ROCK_TUNNEL_2F_TM_THUNDER_WAVE
	itemball_event 3, 21, ELECTIRIZER, 1, EVENT_ROCK_TUNNEL_2F_ELECTIRIZER
	strengthboulder_event 2, 12
	strengthboulder_event 3, 12
	strengthboulder_event 3, 13
	person_event SPRITE_SNES, 5, 1, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, EndEvent, -1
	person_event SPRITE_SNES, 19, 1, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, EndEvent, -1
	person_event SPRITE_SNES, 9, 13, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, EndEvent, -1
	person_event SPRITE_SNES, 18, 13, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, EndEvent, -1
	person_event SPRITE_SNES, 6, 16, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, EndEvent, -1
	person_event SPRITE_SNES, 13, 18, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, EndEvent, -1
	person_event SPRITE_SNES, 15, 28, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, EndEvent, -1
	person_event SPRITE_SNES, 22, 22, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, EndEvent, -1

RockTunnel2FElectrode:
	cry ELECTRODE
	loadwildmon ELECTRODE, 50
	startbattle
	disappear LAST_TALKED
	reloadmapafterbattle
	end
