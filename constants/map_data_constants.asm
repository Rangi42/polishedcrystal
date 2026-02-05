DEF GROUP_N_A  EQU -1
DEF MAP_N_A    EQU -1
DEF GROUP_NONE EQU 0
DEF MAP_NONE   EQU 0

; map struct members (see data/maps/maps.asm)
rsreset
DEF MAP_TILESET       rb ; 0
DEF MAP_ENVIRONMENT   rb ; 1
DEF MAP_MAPATTRIBUTES rw ; 2
DEF MAP_LOCATION      rb ; 4
DEF MAP_MUSIC         rb ; 5
DEF MAP_PALETTE       rb ; 6
DEF MAP_LENGTH EQU _RS   ; 7

; map landmark name signs
	const_def
	const SIGN_WOOD
	const SIGN_CITY
	const SIGN_FOREST
	const SIGN_CAVE
	const SIGN_ROUTE
	const SIGN_WATER
	const SIGN_BUILDING
DEF NUM_SIGNS EQU const_value

; map environments (wEnvironment)
; EnvironmentColorsPointers indexes (see data/maps/environment_colors.asm)
	const_def 1
	const TOWN
	const ROUTE
	const INDOOR
	const CAVE
	const ISOLATED
	const GATE
	const DUNGEON
DEF NUM_ENVIRONMENTS EQU const_value - 1

; map palettes (wEnvironment)
	const_def
	const PALETTE_AUTO
	const PALETTE_DAY
	const PALETTE_NITE
	const PALETTE_MORN
	const PALETTE_EVE
DEF NUM_MAP_PALETTES EQU const_value

DEF IN_DARKNESS EQU %1000
DEF DARKNESS_PALSET EQU %00011011 ; brightlevel 0, 1, 2, 3

; FishGroup indexes (see data/wild/fish.asm)
	const_def
	const FISHGROUP_SHORE
	const FISHGROUP_OCEAN
	const FISHGROUP_LAKE
	const FISHGROUP_WELL
	const FISHGROUP_RIVER
	const FISHGROUP_POND
	const FISHGROUP_DRATINI
	const FISHGROUP_QWILFISH_SWARM
	const FISHGROUP_REMORAID_SWARM
	const FISHGROUP_GYARADOS
	const FISHGROUP_DRATINI_2
	const FISHGROUP_WHIRL_ISLANDS
	const FISHGROUP_QWILFISH
	const FISHGROUP_REMORAID
	const FISHGROUP_HISUIAN_QWILFISH
	const FISHGROUP_STARYU
DEF NUM_FISHGROUPS EQU const_value

; wMapConnections
; connection directions (see data/maps/data.asm)
	const_def
	shift_const EAST
	shift_const WEST
	shift_const SOUTH
	shift_const NORTH

; GetOvercastIndex return values (see home/map.asm)
	const_def
	const NOT_OVERCAST
	const AZALEA_OVERCAST
	const LAKE_OF_RAGE_OVERCAST
	const STORMY_BEACH_OVERCAST
	const ROUTE_10_OVERCAST
	const GENERIC_OVERCAST

; SpawnPoints indexes (see data/maps/spawn_points.asm)
	const_def
	const SPAWN_HOME
; kanto
	const SPAWN_PALLET
	const SPAWN_VIRIDIAN
	const SPAWN_PEWTER
	const SPAWN_MT_MOON
	const SPAWN_CERULEAN
	const SPAWN_CERULEAN_CAPE
	const SPAWN_ROCK_TUNNEL
	const SPAWN_VERMILION
	const SPAWN_LAVENDER
	const SPAWN_SAFFRON
	const SPAWN_CELADON
	const SPAWN_FUCHSIA
	const SPAWN_CINNABAR
	const SPAWN_INDIGO
; johto
	const SPAWN_NEW_BARK
	const SPAWN_CHERRYGROVE
	const SPAWN_VIOLET
	const SPAWN_UNION_CAVE
	const SPAWN_AZALEA
	const SPAWN_CIANWOOD
	const SPAWN_GOLDENROD
	const SPAWN_OLIVINE
	const SPAWN_ECRUTEAK
	const SPAWN_SNOWTOP
	const SPAWN_MAHOGANY
	const SPAWN_YELLOW_FOREST
	const SPAWN_LAKE_OF_RAGE
	const SPAWN_BLACKTHORN
	const SPAWN_MT_SILVER
	const SPAWN_FAST_SHIP
; orange
	const SPAWN_SHAMOUTI
	const SPAWN_VALENCIA
	const SPAWN_NAVEL
DEF NUM_SPAWNS EQU const_value

DEF SPAWN_N_A EQU -1

; Flypoints indexes (see data/maps/flypoints.asm)
	const_def
; johto
	const FLY_NEW_BARK
	const FLY_CHERRYGROVE
	const FLY_VIOLET
	const FLY_UNION_CAVE
	const FLY_AZALEA
	const FLY_GOLDENROD
	const FLY_ECRUTEAK
	const FLY_SNOWTOP
	const FLY_OLIVINE
	const FLY_CIANWOOD
	const FLY_YELLOW_FOREST
	const FLY_MAHOGANY
	const FLY_LAKE_OF_RAGE
	const FLY_BLACKTHORN
	const FLY_MT_SILVER
; kanto
	const FLY_PALLET
	const FLY_VIRIDIAN
	const FLY_PEWTER
	const FLY_MT_MOON
	const FLY_CERULEAN
	const FLY_CERULEAN_CAPE
	const FLY_VERMILION
	const FLY_ROCK_TUNNEL
	const FLY_LAVENDER
	const FLY_CELADON
	const FLY_SAFFRON
	const FLY_FUCHSIA
	const FLY_CINNABAR
	const FLY_INDIGO
; orange
	const FLY_SHAMOUTI
	const FLY_VALENCIA
	const FLY_NAVEL
DEF NUM_FLYPOINTS EQU const_value
