const_value set 2
	const ROUTE10_ZAPDOS

Route10North_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_ROCK_TUNNEL
	return

Route10Zapdos:
	faceplayer
	cry ZAPDOS
	loadwildmon ZAPDOS, 60
	startbattle
	disappear ROUTE10_ZAPDOS
	setevent EVENT_ROUTE_10_ZAPDOS
	reloadmapafterbattle
	end

PowerPlantSign:
	jumptext PowerPlantSignText

Route10PokeCenterSign:
	jumpstd pokecentersign

PowerPlantSignText:
	text "Kanto Power Plant"
	done

Route10North_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $1, $b, 1, ROUTE_10_POKECENTER_1F
	warp_def $9, $3, 1, POWER_PLANT
	warp_def $3, $2, 1, ROCK_TUNNEL_2F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 11, 5, SIGNPOST_READ, PowerPlantSign
	signpost 1, 12, SIGNPOST_READ, Route10PokeCenterSign

.PersonEvents:
	db 1
	person_event SPRITE_BIRD, 5, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route10Zapdos, EVENT_ROUTE_10_ZAPDOS
