; Tilesets indexes (see data/tilesets.asm)
	const_def 1
	const TILESET_JOHTO_TRADITIONAL    ; 01
	const TILESET_JOHTO_MODERN         ; 02
	const TILESET_JOHTO_COAST          ; 03
	const TILESET_JOHTO_OUTLANDS       ; 04
	const TILESET_JOHTO_ANCIENT        ; 05
	const TILESET_JOHTO_SACRED         ; 06
	const TILESET_BATTLE_TOWER_OUTSIDE ; 07
	const TILESET_SNOWTOP_MOUNTAIN     ; 08
DEF NO_ROOF_TILESETS EQU const_value
	const TILESET_KANTO                ; 09
	const TILESET_KANTO_NORTH          ; 0a
	const TILESET_KANTO_URBAN          ; 0b
	const TILESET_INDIGO_PLATEAU       ; 0c
	const TILESET_SHAMOUTI_ISLAND      ; 0d
	const TILESET_VALENCIA_ISLAND      ; 0e
	const TILESET_FARAWAY_ISLAND       ; 0f
	const TILESET_JOHTO_HOUSE          ; 10
	const TILESET_KANTO_HOUSE          ; 11
	const TILESET_TRADITIONAL_HOUSE    ; 12
	const TILESET_POKECENTER           ; 13
	const TILESET_POKECOM_CENTER       ; 14
	const TILESET_MART                 ; 15
	const TILESET_GATE                 ; 16
	const TILESET_GYM                  ; 17
	const TILESET_MAGNET_TRAIN         ; 18
	const TILESET_CHAMPIONS_ROOM       ; 19
	const TILESET_PORT                 ; 1a
	const TILESET_LAB                  ; 1b
	const TILESET_FACILITY             ; 1c
	const TILESET_CELADON_MANSION      ; 1d
	const TILESET_GAME_CORNER          ; 1e
	const TILESET_HOME_DECOR_STORE     ; 1f
	const TILESET_MUSEUM               ; 20
	const TILESET_HOTEL                ; 21
	const TILESET_SPROUT_TOWER         ; 22
	const TILESET_BATTLE_TOWER_INSIDE  ; 23
	const TILESET_RADIO_TOWER          ; 24
	const TILESET_LIGHTHOUSE           ; 25
	const TILESET_UNDERGROUND          ; 26
	const TILESET_CAVE                 ; 27
	const TILESET_QUIET_CAVE           ; 28
	const TILESET_ICE_PATH             ; 29
	const TILESET_TUNNEL               ; 2a
	const TILESET_FOREST               ; 2b
	const TILESET_PARK                 ; 2c
	const TILESET_SAFARI_ZONE          ; 2d
	const TILESET_RUINS_OF_ALPH        ; 2e
	const TILESET_POKEMON_MANSION      ; 2f
	const TILESET_BATTLE_FACTORY       ; 30
	const TILESET_HIDDEN_GROTTO        ; 31
	const TILESET_PEAKS                ; 32
	const TILESET_HIDEOUT              ; 33
	const TILESET_KANTO_GYM            ; 34
DEF NUM_TILESETS EQU const_value - 1

; wTileset struct size
DEF TILESET_LENGTH EQU 18

; MapGroupRoofs values (see data/maps/roofs.asm)
; MapGroupRoofGFX indexes (see engine/tilesets/mapgroup_roofs.asm)
	const_def
	const ROOF_NEW_BARK ; 0
	const ROOF_VIOLET   ; 1
	const ROOF_AZALEA   ; 2
	const ROOF_OLIVINE  ; 3
	const ROOF_PARK     ; 4
	const ROOF_SINJOH   ; 5
DEF NUM_ROOFS EQU const_value

; roof length (see gfx/tilesets/roofs)
DEF ROOF_LENGTH EQU 9

; coast sand tile IDs in vTiles4
	const_def $f0
	const COAST_SAND_TILE         ; $f0
	const COAST_SAND_TILE_FOOT_V1 ; $f1
	const COAST_SAND_TILE_FOOT_V2 ; $f2
	const COAST_SAND_TILE_FOOT_H1 ; $f3
	const COAST_SAND_TILE_FOOT_H2 ; $f4
	const COAST_SAND_TILE_BIKE_H  ; $f5
	const COAST_SAND_TILE_BIKE_V  ; $f6
DEF NUM_COAST_SAND_TILES EQU const_value - COAST_SAND_TILE

; bg palette values
; TilesetBGPalette indexes (see gfx/tilesets/bg_tiles.pal)
	const_def
	const PAL_BG_GRAY   ; 0
	const PAL_BG_RED    ; 1
	const PAL_BG_GREEN  ; 2
	const PAL_BG_WATER  ; 3
	const PAL_BG_YELLOW ; 4
	const PAL_BG_BROWN  ; 5
	const PAL_BG_ROOF   ; 6
	const PAL_BG_TEXT   ; 7
