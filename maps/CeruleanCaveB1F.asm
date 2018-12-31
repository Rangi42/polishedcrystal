CeruleanCaveB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanCaveB1F_MapEventHeader:

.Warps: db 1
	warp_def 7, 5, 5, CERULEAN_CAVE_1F

.XYTriggers: db 0

.Signposts: db 2
	signpost 6, 8, SIGNPOST_ITEM + MAX_REVIVE, EVENT_CERULEAN_CAVE_B1F_HIDDEN_MAX_REVIVE
	signpost 11, 24, SIGNPOST_ITEM + ULTRA_BALL, EVENT_CERULEAN_CAVE_B1F_HIDDEN_ULTRA_BALL

.PersonEvents: db 3
	person_event SPRITE_MEWTWO, 13, 7, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, CeruleanCaveMewtwo, EVENT_CERULEAN_CAVE_MEWTWO
	itemball_event 9, 26, MAX_ELIXER, 1, EVENT_CERULEAN_CAVE_B1F_MAX_ELIXER
	itemball_event 3, 26, ULTRA_BALL, 1, EVENT_CERULEAN_CAVE_B1F_ULTRA_BALL

const_value set 1
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

MewtwoText:
	text "Myuu!"
	done
