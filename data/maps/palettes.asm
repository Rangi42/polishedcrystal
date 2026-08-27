MACRO special_bg_pal
	if "\1" === "map"
		db PAL_FOR_MAP
		map_id \2 ; map id
		shift
	elif "\1" === "landmark"
		db PAL_FOR_LANDMARK
		db \2 ; landmark
		shift
	elif "\1" === "tileset"
		db PAL_FOR_TILESET
		db \2 ; tileset
		shift
	elif "\1" === "overcast"
		db PAL_FOR_OVERCAST
	elif "\1" === "darkness"
		db PAL_FOR_DARKNESS
	else
		fail "Invalid constraint for 'special_bg_pal'."
	endc
	db (PALTYPE_\2 << 6) | (PAL_BG_\3 << 3) | (\4 - 1) ; type, first pal, pal count
	dw \5 ; source
ENDM

SpecialBGPalettes:
	special_bg_pal darkness,                              SINGLE,      GRAY,   7, DarknessBGPalette
	special_bg_pal map,      SILVER_CAVE_ROOM_1,          SINGLE,      YELLOW, 2, SilverCavePalette
	special_bg_pal map,      SILVER_CAVE_ROOM_2,          SINGLE,      YELLOW, 2, SilverCavePalette
	special_bg_pal map,      SILVER_CAVE_ROOM_3,          TIMEOFDAY,   GRAY,   7, MountSilverPeakPalette
	special_bg_pal map,      SILVER_CAVE_ITEM_ROOMS,      SINGLE,      YELLOW, 2, SilverCavePalette
	special_bg_pal map,      DRAGON_SHRINE,               SINGLE,      RED,    3, DragonShrinePalette
	special_bg_pal map,      ECRUTEAK_CITY,               TIMEWEATHER, RED,    3, VioletEcruteakPalette
	special_bg_pal map,      VIOLET_GYM,                  SINGLE,      GREEN,  1, VioletGymPalette
	special_bg_pal map,      ECRUTEAK_GYM,                SINGLE,      YELLOW, 1, EcruteakGymPalette
	special_bg_pal map,      MAHOGANY_GYM,                SINGLE,      GRAY,   4, MahoganyGymPalette
	special_bg_pal map,      BLACKTHORN_GYM_1F,           SINGLE,      GRAY,   7, BlackthornGymPalette
	special_bg_pal map,      BLACKTHORN_GYM_2F,           SINGLE,      GRAY,   7, BlackthornGymPalette
	special_bg_pal map,      CINNABAR_LAB,                SINGLE,      GREEN,  1, CinnabarLabPalette
	special_bg_pal map,      PEWTER_GYM,                  SINGLE,      RED,    5, PewterGymPalette
	special_bg_pal map,      CERULEAN_GYM,                SINGLE,      ROOF,   1, CeruleanGymPalette
	special_bg_pal map,      VERMILION_GYM,               SINGLE,      YELLOW, 1, VermilionGymPalette
	special_bg_pal map,      CELADON_GYM,                 SINGLE,      GREEN,  5, CeladonGymPalette
	special_bg_pal map,      FUCHSIA_GYM,                 SINGLE,      ROOF,   1, FuchsiaGymPalette
	special_bg_pal map,      SAFFRON_GYM,                 SINGLE,      GREEN,  5, SaffronGymPalette
	special_bg_pal map,      VIRIDIAN_GYM,                SINGLE,      GRAY,   6, ViridianGymPalette
	special_bg_pal map,      FIGHTING_DOJO,               SINGLE,      GREEN,  5, FightingDojoPalette
	special_bg_pal map,      VIOLET_CITY,                 TIMEWEATHER, RED,    3, VioletEcruteakPalette
	special_bg_pal map,      MURKY_SWAMP,                 SINGLE,      GRAY,   7, MurkySwampPalette
	special_bg_pal map,      GOLDENROD_DEPT_STORE_ROOF,   TIMEWEATHER, GRAY,   7, GoldenrodDeptStoreRoofPalette
	special_bg_pal map,      GOLDENROD_MUSEUM_1F,         SINGLE,      YELLOW, 1, GoldenrodMuseumPalette
	special_bg_pal map,      GOLDENROD_MUSEUM_2F,         SINGLE,      YELLOW, 1, GoldenrodMuseumPalette
	special_bg_pal map,      FUCHSIA_AQUARIUM_1F,         SINGLE,      GREEN,  5, FuchsiaAquariumPalette
	special_bg_pal map,      FUCHSIA_AQUARIUM_2F,         SINGLE,      GREEN,  5, FuchsiaAquariumPalette
	special_bg_pal map,      MAGNET_TUNNEL_INSIDE,        SINGLE,      RED,    4, MagnetTunnelPalette
	special_bg_pal map,      OAKS_LAB,                    SINGLE,      GREEN,  1, OaksLabPalette
	special_bg_pal map,      TIN_TOWER_ROOF,              TIMEWEATHER, RED,    6, TinTowerRoofPalette
	special_bg_pal map,      WILLS_ROOM,                  SINGLE,      GREEN,  1, WillsRoomPalette
	special_bg_pal map,      KOGAS_ROOM,                  SINGLE,      GREEN,  1, KogasRoomPalette
	special_bg_pal map,      BRUNOS_ROOM,                 SINGLE,      GRAY,   7, BrunosRoomPalette
	special_bg_pal map,      KARENS_ROOM,                 SINGLE,      WATER,  4, KarensRoomPalette
	special_bg_pal map,      LANCES_ROOM,                 SINGLE,      WATER,  3, LancesRoomPalette
	special_bg_pal map,      HALL_OF_FAME,                SINGLE,      WATER,  3, LancesRoomPalette
	special_bg_pal map,      BELLCHIME_TRAIL,             TIMEWEATHER, RED,    6, BellchimeTrailPalette
	special_bg_pal map,      HAUNTED_RADIO_TOWER_2F,      SINGLE,      GREEN,  3, HauntedRadioTowerPalette
	special_bg_pal map,      HAUNTED_RADIO_TOWER_3F,      SINGLE,      GREEN,  3, HauntedRadioTowerPalette
	special_bg_pal map,      HAUNTED_RADIO_TOWER_4F,      SINGLE,      GREEN,  2, HauntedPokemonTowerPalette
	special_bg_pal map,      HAUNTED_RADIO_TOWER_5F,      SINGLE,      GREEN,  2, HauntedPokemonTowerPalette
	special_bg_pal map,      HAUNTED_RADIO_TOWER_6F,      SINGLE,      GREEN,  2, HauntedPokemonTowerPalette
	special_bg_pal map,      NAVEL_ROCK_INSIDE,           SINGLE,      GRAY,   7, NavelRockPalette
	special_bg_pal map,      NAVEL_ROCK_ROOF,             TIMEOFDAY,   GRAY,   7, NavelRockPalette
	special_bg_pal map,      FARAWAY_ISLAND_SOUTH,        TIMEOFDAY,   GRAY,   7, FarawayIslandSouthPalette
	special_bg_pal map,      YELLOW_FOREST,               TIMEWEATHER, GRAY,   7, YellowForestPalette
	special_bg_pal map,      VIRIDIAN_FOREST,             SINGLE,      RED,    5, ViridianForestPalette
	special_bg_pal map,      CELADON_MANSION_ROOF,        TIMEWEATHER, WATER,  1, CeladonMansionRoofPalette
	special_bg_pal map,      CELADON_HOME_DECOR_STORE_4F, SINGLE,      YELLOW, 1, CeladonHomeDecorStore4FPalette
	special_bg_pal map,      LIGHTNING_ISLAND,            SINGLE,      GRAY,   6, LightningIslandPalette
	special_bg_pal map,      IVYS_LAB,                    SINGLE,      BROWN,  1, wBGPals1 palette PAL_BG_GRAY
	special_bg_pal map,      RUGGED_ROAD_SOUTH,           TIMEOFDAY,   GREEN,  1, RuggedRoadSouthPalette
	special_bg_pal map,      RUGGED_ROAD_NORTH,           TIMEOFDAY,   RED,    4, RuggedRoadNorthPalette
	special_bg_pal map,      SNOWTOP_MOUNTAIN_INSIDE,     TIMEOFDAY,   GREEN,  1, SnowtopMountainInsidePalette
	special_bg_pal map,      SINJOH_RUINS,                TIMEWEATHER, GRAY,   4, SinjohRuinsPalette
	special_bg_pal map,      MYSTRI_STAGE,                SINGLE,      GREEN,  5, MystriStagePalette
	special_bg_pal map,      EMBEDDED_TOWER,              SINGLE,      GREEN,  2, EmbeddedTowerPalette
	special_bg_pal landmark, SPROUT_TOWER,                SINGLE,      GREEN,  3, SproutTowerPalette
	special_bg_pal landmark, WHIRL_ISLANDS,               SINGLE,      GRAY,   6, WhirlIslandsPalette
	special_bg_pal landmark, MT_MORTAR,                   SINGLE,      GRAY,   6, DarkCavePalette
	special_bg_pal landmark, DARK_CAVE,                   SINGLE,      GRAY,   6, DarkCavePalette
	special_bg_pal landmark, CERULEAN_CAVE,               SINGLE,      GRAY,   7, CeruleanCavePalette
	special_bg_pal landmark, DIM_CAVE,                    SINGLE,      GRAY,   6, DimCavePalette
	special_bg_pal landmark, SCARY_CAVE,                  SINGLE,      GRAY,   6, ScaryCavePalette
	special_bg_pal landmark, CINNABAR_VOLCANO,            SINGLE,      GRAY,   6, CinnabarVolcanoPalette
	special_bg_pal tileset,  TILESET_SHAMOUTI_ISLAND,     TIMEOFDAY,   RED,    5, ShamoutiIslandPalette
	special_bg_pal tileset,  TILESET_VALENCIA_ISLAND,     TIMEOFDAY,   WATER,  1, ValenciaIslandPalette
	special_bg_pal tileset,  TILESET_FARAWAY_ISLAND,      TIMEOFDAY,   GRAY,   7, FarawayIslandPalette
	special_bg_pal tileset,  TILESET_POKECENTER,          SPECIAL,     WATER,  4, PokeCenterSpecialCase ; *
	special_bg_pal tileset,  TILESET_POKECOM_CENTER,      SINGLE,      WATER,  2, PokeComPalette
	special_bg_pal tileset,  TILESET_MART,                SPECIAL,     YELLOW, 1, MartSpecialCase ; *
	special_bg_pal tileset,  TILESET_GATE,                SINGLE,      YELLOW, 1, GatePalette
	special_bg_pal tileset,  TILESET_MAGNET_TRAIN,        SPECIAL,     YELLOW, 1, MagnetTrainSpecialCase ; *
	special_bg_pal tileset,  TILESET_PORT,                TIMEOFDAY,   YELLOW, 1, PortPalette
	special_bg_pal tileset,  TILESET_GAME_CORNER,         SINGLE,      YELLOW, 1, GameCornerPalette
	special_bg_pal tileset,  TILESET_HOTEL,               SINGLE,      YELLOW, 3, HotelPalette
	special_bg_pal tileset,  TILESET_BATTLE_TOWER_INSIDE, SINGLE,      RED,    6, BattleTowerPalette
	special_bg_pal tileset,  TILESET_BATTLE_FACTORY,      SINGLE,      GRAY,   7, BattleFactoryPalette
	special_bg_pal tileset,  TILESET_RADIO_TOWER,         SINGLE,      GREEN,  5, RadioTowerPalette
	special_bg_pal tileset,  TILESET_QUIET_CAVE,          SINGLE,      GRAY,   6, QuietCavePalette
	special_bg_pal tileset,  TILESET_ICE_PATH,            SINGLE,      GREEN,  5, IcePathPalette
	special_bg_pal tileset,  TILESET_HIDEOUT,             SINGLE,      GRAY,   7, HideoutPalette
	special_bg_pal tileset,  TILESET_SAFARI_ZONE,         TIMEOFDAY,   RED,    5, SafariZonePalette
	special_bg_pal tileset,  TILESET_RUINS_OF_ALPH,       SINGLE,      WATER,  3, RuinsOfAlphPalette
	special_bg_pal tileset,  TILESET_SNOWTOP_MOUNTAIN,    TIMEOFDAY,   GRAY,   7, SnowtopMountainPalette
	special_bg_pal tileset,  TILESET_HIDDEN_GROTTO,       SPECIAL,     GRAY,   7, HiddenGrottoSpecialCase ; *
	special_bg_pal overcast,                              TIMEOFDAY,   GRAY,   7, OvercastBGPalette
	db 0 ; end

BlindingFlashPalette:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 08, 19, 28
	RGB 05, 05, 16
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc

LinkTradePalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/link_trade.pal"
else
rept 6
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
endr
endc

PokeComPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/pokecom_center.pal"
else
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
endc

BattleTowerPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/battle_tower_inside.pal"
else
rept 4
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME LIGHT, WHITE, DARK, BLACK
	MONOCHROME_RGB_FOUR
endc

BattleFactoryPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/battle_factory.pal"
else
rept 5
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME LIGHT, WHITE, DARK, BLACK
	MONOCHROME_RGB_FOUR
endc

IcePathPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/ice_path.pal"
else
	RGB_MONOCHROME WHITE, LIGHT, WHITE, BLACK ; green
rept 4
	MONOCHROME_RGB_FOUR
endr
endc

HideoutPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/hideout.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
endc

GatePalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/gate.pal"
else
	MONOCHROME_RGB_FOUR ; yellow
endc

PortPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/port.pal"
else
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR_NIGHT
	MONOCHROME_RGB_FOUR
endc

HotelPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/hotel.pal"
else
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
	MONOCHROME_RGB_FOUR ; roof
endc

QuietCavePalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/quiet_cave.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK
	MONOCHROME_RGB_FOUR_NIGHT
endc

RuinsOfAlphPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/ruins_of_alph.pal"
else
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
endc

SafariZonePalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/safari_zone.pal"
else
; morn
rept 5
	MONOCHROME_RGB_FOUR
endr
; day
rept 5
	MONOCHROME_RGB_FOUR
endr
; nite
rept 3
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK
	MONOCHROME_RGB_FOUR_NIGHT
; eve
rept 5
	MONOCHROME_RGB_FOUR
endr
endc

SnowtopMountainPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/snowtop_mountain.pal"
else
; morn
rept 7
	MONOCHROME_RGB_FOUR
endr
; day
rept 7
	MONOCHROME_RGB_FOUR
endr
; nite
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK
	MONOCHROME_RGB_FOUR_NIGHT
	MONOCHROME_RGB_FOUR_NIGHT
; eve
rept 7
	MONOCHROME_RGB_FOUR
endr
endc

HiddenGrottoPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/hidden_grotto.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR_NIGHT
	MONOCHROME_RGB_FOUR_NIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

PokeCenterPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/pokecenter.pal"
else
rept 4
	MONOCHROME_RGB_FOUR
endr
endc

FarawayIslandPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/faraway_island.pal"
else
; morn
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME LIGHT, WHITE, DARK, BLACK
; day
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME LIGHT, WHITE, DARK, BLACK
; nite
rept 6
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME DARK, LIGHT, DARK, BLACK
; eve
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME LIGHT, WHITE, DARK, BLACK
endc

FarawayIslandSouthPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/FarawayIslandSouth.pal"
else
; morn
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME LIGHT, WHITE, DARK, BLACK
; day
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME LIGHT, WHITE, DARK, BLACK
; nite
rept 6
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME DARK, LIGHT, DARK, BLACK
; eve
rept 6
	MONOCHROME_RGB_FOUR_EVE
endr
	RGB_MONOCHROME LIGHT, WHITE, DARK, BLACK
endc

ShamoutiIslandPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/shamouti_island.pal"
else
; morn
rept 5
	MONOCHROME_RGB_FOUR
endr
; day
rept 5
	MONOCHROME_RGB_FOUR
endr
; nite
rept 3
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK
	MONOCHROME_RGB_FOUR_NIGHT
; eve
rept 3
	MONOCHROME_RGB_FOUR_EVE
endr
	RGB_MONOCHROME WHITE, LIGHT, DARK, BLACK
	MONOCHROME_RGB_FOUR_EVE
endc

ValenciaIslandPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/valencia_island.pal"
else
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR_NIGHT
	MONOCHROME_RGB_FOUR
endc

RadioTowerPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/radio_tower.pal"
else
	RGB_MONOCHROME LIGHT, LIGHT, DARK, BLACK ; green
rept 4
	MONOCHROME_RGB_FOUR
endr
endc

HauntedRadioTowerPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/haunted_radio_tower.pal"
else
	RGB_MONOCHROME DARK, DARK, DARK, BLACK ; green
	MONOCHROME_RGB_FOUR_NIGHT ; water
	MONOCHROME_RGB_FOUR_NIGHT ; yellow
endc

HauntedPokemonTowerPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/haunted_pokemon_tower.pal"
else
	MONOCHROME_RGB_FOUR_NIGHT ; green
	MONOCHROME_RGB_FOUR_NIGHT ; water
endc

WillsRoomPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/WillsRoom.pal"
else
	MONOCHROME_RGB_FOUR ; green
endc

KogasRoomPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/KogasRoom.pal"
else
	MONOCHROME_RGB_FOUR ; green
endc

BrunosRoomPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/BrunosRoom.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
endc

KarensRoomPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/KarensRoom.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
endc

LancesRoomPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/LancesRoom.pal"
else
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
endc

PewterGymPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/PewterGym.pal"
else
	MONOCHROME_RGB_FOUR ; red
	MONOCHROME_RGB_FOUR ; green
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
endc

CeruleanGymPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/CeruleanGym.pal"
else
	MONOCHROME_RGB_FOUR ; roof
endc

SaffronGymPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/SaffronGym.pal"
else
	MONOCHROME_RGB_FOUR ; green
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
	MONOCHROME_RGB_FOUR ; roof
endc

FightingDojoPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/FightingDojo.pal"
else
	MONOCHROME_RGB_FOUR ; green
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
	MONOCHROME_RGB_FOUR ; roof
endc

ViridianGymPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/ViridianGym.pal"
else
	MONOCHROME_RGB_FOUR ; gray
	MONOCHROME_RGB_FOUR ; red
	MONOCHROME_RGB_FOUR ; green
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
endc

FuchsiaGymPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/FuchsiaGym.pal"
else
	MONOCHROME_RGB_FOUR ; roof
endc

VermilionGymPalette:
GameCornerPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/game_corner.pal"
else
	MONOCHROME_RGB_FOUR ; yellow
endc

CeladonGymPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/CeladonGym.pal"
else
	MONOCHROME_RGB_FOUR ; green
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
	MONOCHROME_RGB_FOUR ; roof
endc

OaksLabPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/OaksLab.pal"
else
	MONOCHROME_RGB_FOUR ; green
endc

DragonShrinePalette:
if !DEF(MONOCHROME)
INCLUDE "maps/DragonShrine.pal"
else
	MONOCHROME_RGB_FOUR ; red
	MONOCHROME_RGB_FOUR ; green
	MONOCHROME_RGB_FOUR ; water
endc

LightningIslandPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/LightningIsland.pal"
else
	MONOCHROME_RGB_FOUR_NIGHT ; gray
	MONOCHROME_RGB_FOUR_NIGHT ; red
	RGB_MONOCHROME DARK, DARK, BLACK, BLACK ; green
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
endc

MagnetTunnelPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/MagnetTunnelInside.pal"
else
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK ; red
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK ; green
	MONOCHROME_RGB_FOUR_NIGHT ; water
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK ; yellow
endc

MystriStagePalette:
if !DEF(MONOCHROME)
INCLUDE "maps/MystriStage.pal"
else
rept 5
	MONOCHROME_RGB_FOUR_NIGHT
endr
endc

EmbeddedTowerPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/EmbeddedTower.pal"
else
	MONOCHROME_RGB_FOUR_NIGHT ; green
	MONOCHROME_RGB_FOUR_NIGHT ; water
endc

SproutTowerPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/sprout_tower.pal"
else
	MONOCHROME_RGB_FOUR ; green
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
endc

TinTowerRoofPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/TinTowerRoof.pal"
INCLUDE "maps/TinTowerRoof_overcast.pal"
else
rept 2
	; morn
	RGB_MONOCHROME WHITE, LIGHT, DARK, DARK ; red
	RGB_MONOCHROME LIGHT, DARK, DARK, BLACK ; green
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
	MONOCHROME_RGB_FOUR ; roof
	; day
	RGB_MONOCHROME WHITE, LIGHT, DARK, DARK ; red
	RGB_MONOCHROME LIGHT, DARK, DARK, BLACK ; green
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
	MONOCHROME_RGB_FOUR ; roof
	; nite
	RGB_MONOCHROME LIGHT, DARK, DARK, DARK ; red
	RGB_MONOCHROME DARK, DARK, DARK, BLACK ; green
	MONOCHROME_RGB_FOUR_NIGHT ; water
	MONOCHROME_RGB_FOUR_NIGHT ; yellow
	MONOCHROME_RGB_FOUR_NIGHT ; brown
	MONOCHROME_RGB_FOUR_NIGHT ; roof
	; eve
	RGB_MONOCHROME WHITE, LIGHT, DARK, DARK ; red
	RGB_MONOCHROME LIGHT, DARK, DARK, BLACK ; green
	MONOCHROME_RGB_FOUR ; water
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
	MONOCHROME_RGB_FOUR ; roof
endr
endc

CinnabarLabPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/CinnabarLab.pal"
else
	MONOCHROME_RGB_FOUR ; green
endc

GoldenrodMuseumPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/goldenrod_museum.pal"
else
	MONOCHROME_RGB_FOUR ; yellow
endc

FuchsiaAquariumPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/fuchsia_aquarium.pal"
else
	MONOCHROME_RGB_FOUR_NIGHT ; green
	MONOCHROME_RGB_FOUR_NIGHT ; water
	RGB_MONOCHROME WHITE, LIGHT, LIGHT, DARK ; yellow
	MONOCHROME_RGB_FOUR_NIGHT ; brown
	MONOCHROME_RGB_FOUR_NIGHT ; roof
endc

CeladonMansionRoofPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/CeladonMansionRoof.pal"
INCLUDE "maps/CeladonMansionRoof_overcast.pal"
else
rept 2
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR_NIGHT
	MONOCHROME_RGB_FOUR_EVE
endr
endc

MartPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/mart.pal"
else
	MONOCHROME_RGB_FOUR ; yellow
endc

MartBluePalette:
if !DEF(MONOCHROME)
	RGB 20, 27, 28
	RGB 06, 22, 25
	RGB 04, 17, 19
	RGB 07, 07, 07
else
	MONOCHROME_RGB_FOUR ; green
endc

GoldenrodDeptStoreRoofPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/GoldenrodDeptStoreRoof.pal"
INCLUDE "maps/GoldenrodDeptStoreRoof_overcast.pal"
else
rept 2
	; morn
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME WHITE, WHITE, LIGHT, BLACK
	; day
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME WHITE, WHITE, LIGHT, BLACK
	; nite
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK
	MONOCHROME_RGB_FOUR_NIGHT
	MONOCHROME_RGB_FOUR_NIGHT
	; eve
rept 7
	MONOCHROME_RGB_FOUR
endr
endr
endc

CeladonHomeDecorStore4FPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/CeladonHomeDecorStore4F.pal"
else
	RGB_MONOCHROME DARK, WHITE, LIGHT, BLACK ; yellow
endc

RuggedRoadSouthPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/RuggedRoadSouth.pal"
else
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR_NIGHT
	MONOCHROME_RGB_FOUR_EVE
endc

RuggedRoadNorthPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/RuggedRoadNorth.pal"
else
	; TODO
endc

SnowtopMountainInsidePalette:
if !DEF(MONOCHROME)
INCLUDE "maps/SnowtopMountainInside.pal"
else
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR_NIGHT
	MONOCHROME_RGB_FOUR_EVE
endc

SinjohRuinsPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/SinjohRuins.pal"
INCLUDE "maps/SinjohRuins_overcast.pal"
else
rept 2
rept 4
	MONOCHROME_RGB_FOUR
endr
rept 4
	MONOCHROME_RGB_FOUR
endr
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
rept 4
	MONOCHROME_RGB_FOUR_EVE
endr
endr
endc

VioletEcruteakPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/violet_ecruteak.pal"
INCLUDE "gfx/tilesets/violet_ecruteak_overcast.pal"
else
rept 2
; morn/day
rept 3
	MONOCHROME_RGB_FOUR ; red
	MONOCHROME_RGB_FOUR ; green
	MONOCHROME_RGB_FOUR ; water
endr
; nite
	MONOCHROME_RGB_FOUR_NIGHT ; red
	MONOCHROME_RGB_FOUR_NIGHT ; green
	MONOCHROME_RGB_FOUR_NIGHT ; water
; eve
	MONOCHROME_RGB_FOUR ; red
	MONOCHROME_RGB_FOUR ; green
	MONOCHROME_RGB_FOUR ; water
endr
endc

VioletGymPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/VioletGym.pal"
else
	MONOCHROME_RGB_FOUR ; green
endc

EcruteakGymPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/EcruteakGym.pal"
else
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK ; yellow
endc

MahoganyGymPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/MahoganyGym.pal"
else
	MONOCHROME_RGB_FOUR ; gray
	MONOCHROME_RGB_FOUR ; red
	MONOCHROME_RGB_FOUR ; green
	MONOCHROME_RGB_FOUR ; water
endc

BlackthornGymPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/BlackthornGym1F.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
endc

BellchimeTrailPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/BellchimeTrail.pal"
INCLUDE "maps/BellchimeTrail_overcast.pal"
else
rept 2
rept 6
	MONOCHROME_RGB_FOUR
endr
rept 6
	MONOCHROME_RGB_FOUR
endr
rept 3
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK
	MONOCHROME_RGB_FOUR_NIGHT
	MONOCHROME_RGB_FOUR_NIGHT
rept 6
	MONOCHROME_RGB_FOUR
endr
endr
endc

YellowForestPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/YellowForest.pal"
INCLUDE "maps/YellowForest_overcast.pal"
else
rept 2
rept 7
	MONOCHROME_RGB_FOUR
endr
rept 7
	MONOCHROME_RGB_FOUR
endr
rept 7
	MONOCHROME_RGB_FOUR_NIGHT
endr
rept 7
	MONOCHROME_RGB_FOUR_EVE
endr
endr
endc

ViridianForestPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/ViridianForest.pal"
else
	MONOCHROME_RGB_FOUR_NIGHT ; red
	MONOCHROME_RGB_FOUR_NIGHT ; green
	RGB_MONOCHROME WHITE, WHITE, LIGHT, LIGHT ; water
	MONOCHROME_RGB_FOUR_NIGHT ; yellow
	MONOCHROME_RGB_FOUR_NIGHT ; brown
endc

MurkySwampPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/MurkySwamp.pal"
else
rept 7
	MONOCHROME_RGB_FOUR_NIGHT
endr
endc

DimCavePalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/dim_cave.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK
	MONOCHROME_RGB_FOUR_NIGHT
endc

WhirlIslandsPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/whirl_islands.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK
	MONOCHROME_RGB_FOUR_NIGHT
endc

ScaryCavePalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/scary_cave.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK
	MONOCHROME_RGB_FOUR_NIGHT
endc

CinnabarVolcanoPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/cinnabar_volcano.pal"
else
	MONOCHROME_RGB_FOUR_NIGHT ; gray
	RGB_MONOCHROME WHITE, LIGHT, DARK, BLACK ; red
	MONOCHROME_RGB_FOUR_NIGHT ; green
	MONOCHROME_RGB_FOUR_NIGHT ; water
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK ; yellow
	MONOCHROME_RGB_FOUR_NIGHT ; brown
endc

CeruleanCavePalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/cerulean_cave.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK
	MONOCHROME_RGB_FOUR_NIGHT
	MONOCHROME_RGB_FOUR_NIGHT
endc

SilverCavePalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/silver_cave.pal"
else
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK ; yellow
	MONOCHROME_RGB_FOUR_NIGHT ; brown
endc

MountSilverPeakPalette:
if !DEF(MONOCHROME)
INCLUDE "maps/SilverCaveRoom3.pal"
else
	; morn/day
rept 2
	RGB_MONOCHROME DARK, LIGHT, DARK, BLACK ; gray
	RGB_MONOCHROME LIGHT, WHITE, LIGHT, BLACK ; red
	MONOCHROME_RGB_FOUR ; green
	MONOCHROME_RGB_FOUR ; water
	RGB_MONOCHROME LIGHT, LIGHT, DARK, BLACK ; yellow
	MONOCHROME_RGB_FOUR ; brown
	MONOCHROME_RGB_FOUR ; roof
endr
	; nite
	RGB_MONOCHROME DARK, DARK, DARK, BLACK ; gray
	RGB_MONOCHROME DARK, LIGHT, DARK, BLACK ; red
	MONOCHROME_RGB_FOUR_NIGHT ; green
	MONOCHROME_RGB_FOUR_NIGHT ; water
	RGB_MONOCHROME DARK, DARK, DARK, BLACK ; yellow
	MONOCHROME_RGB_FOUR_NIGHT ; brown
	RGB_MONOCHROME WHITE, DARK, DARK, BLACK ; roof
	; eve
	RGB_MONOCHROME DARK, LIGHT, DARK, BLACK ; gray
	RGB_MONOCHROME LIGHT, LIGHT, LIGHT, BLACK ; red
	MONOCHROME_RGB_FOUR_EVE ; green
	MONOCHROME_RGB_FOUR_EVE ; water
	RGB_MONOCHROME LIGHT, LIGHT, DARK, BLACK ; yellow
	MONOCHROME_RGB_FOUR_EVE ; brown
	RGB_MONOCHROME WHITE, LIGHT, DARK, BLACK ; roof
endc

DarkCavePalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/dark_cave.pal"
else
rept 4
	RGB_MONOCHROME LIGHT, DARK, BLACK, BLACK
endr
	RGB_MONOCHROME WHITE, DARK, BLACK, BLACK
	RGB_MONOCHROME LIGHT, DARK, BLACK, BLACK
endc

NavelRockPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/navel_rock.pal"
else
; morn/day
rept 2
	MONOCHROME_RGB_FOUR ; gray
	RGB_MONOCHROME DARK, LIGHT, DARK, BLACK ; red
	RGB_MONOCHROME LIGHT, LIGHT, DARK, BLACK ; green
	RGB_MONOCHROME WHITE, LIGHT, LIGHT, BLACK ; water
	MONOCHROME_RGB_FOUR ; yellow
	MONOCHROME_RGB_FOUR ; brown
	MONOCHROME_RGB_FOUR ; roof
endr
; nite
	MONOCHROME_RGB_FOUR_NIGHT ; gray
	RGB_MONOCHROME DARK, DARK, DARK, BLACK ; red
	RGB_MONOCHROME DARK, DARK, DARK, BLACK ; green
	RGB_MONOCHROME WHITE, LIGHT, DARK, BLACK ; water
	MONOCHROME_RGB_FOUR_NIGHT ; yellow
	MONOCHROME_RGB_FOUR_NIGHT ; brown
	MONOCHROME_RGB_FOUR_NIGHT ; roof
; eve
	MONOCHROME_RGB_FOUR_EVE ; gray
	RGB_MONOCHROME DARK, LIGHT, DARK, BLACK ; red
	RGB_MONOCHROME LIGHT, LIGHT, DARK, BLACK ; green
	RGB_MONOCHROME WHITE, LIGHT, LIGHT, BLACK ; water
	MONOCHROME_RGB_FOUR_EVE ; yellow
	MONOCHROME_RGB_FOUR_EVE ; brown
	MONOCHROME_RGB_FOUR_EVE ; roof
endc

DarknessBGPalette:
if !DEF(MONOCHROME)
INCLUDE "gfx/tilesets/darkness.pal"
else
	RGB_MONOCHROME BLACK, BLACK, BLACK, BLACK ; gray
	RGB_MONOCHROME BLACK, BLACK, BLACK, BLACK ; red
	RGB_MONOCHROME BLACK, BLACK, BLACK, BLACK ; green
	RGB_MONOCHROME BLACK, BLACK, BLACK, BLACK ; water
	RGB_MONOCHROME WHITE, BLACK, BLACK, BLACK ; yellow
	RGB_MONOCHROME BLACK, BLACK, BLACK, BLACK ; brown
	RGB_MONOCHROME BLACK, BLACK, BLACK, BLACK ; roof
endc

OvercastBGPalette:
INCLUDE "gfx/tilesets/bg_tiles_overcast.pal"
