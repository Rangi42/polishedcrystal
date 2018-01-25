flypoint: MACRO
	const FLY_\1
	db \2, SPAWN_\1
ENDM

Flypoints:
; landmark, spawn point
	const_def
	flypoint NEW_BARK,    NEW_BARK_TOWN
	flypoint CHERRYGROVE, CHERRYGROVE_CITY
	flypoint VIOLET,      VIOLET_CITY
	flypoint UNION_CAVE,  UNION_CAVE
	flypoint AZALEA,      AZALEA_TOWN
	flypoint GOLDENROD,   GOLDENROD_CITY
	flypoint ECRUTEAK,    ECRUTEAK_CITY
	flypoint OLIVINE,     OLIVINE_CITY
	flypoint CIANWOOD,    CIANWOOD_CITY
	flypoint MAHOGANY,    MAHOGANY_TOWN
	flypoint LAKE,        LAKE_OF_RAGE
	flypoint BLACKTHORN,  BLACKTHORN_CITY
	flypoint MT_SILVER,   SILVER_CAVE
KANTO_FLYPOINT EQU const_value
	flypoint PALLET,      PALLET_TOWN
	flypoint VIRIDIAN,    VIRIDIAN_CITY
	flypoint PEWTER,      PEWTER_CITY
	flypoint MT_MOON,     MT_MOON
	flypoint CERULEAN,    CERULEAN_CITY
	flypoint VERMILION,   VERMILION_CITY
	flypoint ROCK_TUNNEL, ROCK_TUNNEL
	flypoint LAVENDER,    LAVENDER_TOWN
	flypoint CELADON,     CELADON_CITY
	flypoint SAFFRON,     SAFFRON_CITY
	flypoint FUCHSIA,     FUCHSIA_CITY
	flypoint CINNABAR,    CINNABAR_ISLAND
	flypoint INDIGO,      INDIGO_PLATEAU
	db -1
