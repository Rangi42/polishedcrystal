const_value set 2
	const CERULEAN_CAVE_MEWTWO

CeruleanCaveB1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeruleanCaveMewtwo:
	faceplayer
	cry MEWTWO
	loadwildmon MEWTWO, 80
	startbattle
	disappear CERULEAN_CAVE_MEWTWO
	setevent EVENT_CERULEAN_CAVE_MEWTWO
	reloadmapafterbattle
	end

CeruleanCaveB1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $7, $5, 5, CERULEAN_CAVE_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_MONSTER, 13, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeruleanCaveMewtwo, EVENT_CERULEAN_CAVE_MEWTWO
