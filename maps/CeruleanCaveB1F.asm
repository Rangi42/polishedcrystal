CeruleanCaveB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanCaveB1F_MapEventHeader:

.Warps: db 1
	warp_def $7, $5, 5, CERULEAN_CAVE_1F

.XYTriggers: db 0

.Signposts: db 2
	signpost 6, 8, SIGNPOST_ITEM, CeruleanCaveB1FHiddenMaxRevive
	signpost 11, 24, SIGNPOST_ITEM, CeruleanCaveB1FHiddenUltraBall

.PersonEvents: db 3
	person_event SPRITE_MEWTWO, 13, 7, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, CeruleanCaveMewtwo, EVENT_CERULEAN_CAVE_MEWTWO
	person_event SPRITE_BALL_CUT_FRUIT, 9, 26, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEBALL, PLAYEREVENT_ITEMBALL, MAX_ELIXER, 1, EVENT_CERULEAN_CAVE_B1F_MAX_ELIXER
	person_event SPRITE_BALL_CUT_FRUIT, 3, 26, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEBALL, PLAYEREVENT_ITEMBALL, ULTRA_BALL, 1, EVENT_CERULEAN_CAVE_B1F_ULTRA_BALL

const_value set 2
	const CERULEANCAVEB1F_MEWTWO

CeruleanCaveMewtwo:
	faceplayer
	opentext
	writetext MewtwoText
	cry MEWTWO
	pause 15
	closetext
	loadwildmon MEWTWO, 80
	writecode VAR_BATTLETYPE, BATTLETYPE_LEGENDARY
	startbattle
	disappear CERULEANCAVEB1F_MEWTWO
	setevent EVENT_CERULEAN_CAVE_MEWTWO
	reloadmapafterbattle
	end

CeruleanCaveB1FHiddenMaxRevive:
	dwb EVENT_CERULEAN_CAVE_B1F_HIDDEN_MAX_REVIVE, MAX_REVIVE

CeruleanCaveB1FHiddenUltraBall:
	dwb EVENT_CERULEAN_CAVE_B1F_HIDDEN_ULTRA_BALL, ULTRA_BALL

MewtwoText:
	text "Myuu!"
	done
