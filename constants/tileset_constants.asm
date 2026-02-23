; Tilesets indexes (see data/tilesets.asm)
	const_def 1
	const TILESET_JOHTO_TRADITIONAL    ; 01
	const TILESET_JOHTO_MODERN         ; 02
	const TILESET_JOHTO_OUTLANDS       ; 03
	const TILESET_JOHTO_ANCIENT        ; 04
	const TILESET_BATTLE_TOWER_OUTSIDE ; 05
	const TILESET_ECRUTEAK_SHRINE      ; 06
DEF NO_ROOF_TILESETS EQU const_value
	const TILESET_KANTO                ; 07
	const TILESET_KANTO_NORTH          ; 08
	const TILESET_INDIGO_PLATEAU       ; 09
	const TILESET_SHAMOUTI_ISLAND      ; 0a
	const TILESET_VALENCIA_ISLAND      ; 0b
	const TILESET_FARAWAY_ISLAND       ; 0c
	const TILESET_JOHTO_HOUSE          ; 0d
	const TILESET_KANTO_HOUSE          ; 0e
	const TILESET_TRADITIONAL_HOUSE    ; 0f
	const TILESET_POKECENTER           ; 10
	const TILESET_POKECOM_CENTER       ; 11
	const TILESET_MART                 ; 12
	const TILESET_GATE                 ; 13
	const TILESET_GYM                  ; 14
	const TILESET_MAGNET_TRAIN         ; 15
	const TILESET_CHAMPIONS_ROOM       ; 16
	const TILESET_PORT                 ; 17
	const TILESET_LAB                  ; 18
	const TILESET_FACILITY             ; 19
	const TILESET_CELADON_MANSION      ; 1a
	const TILESET_GAME_CORNER          ; 1b
	const TILESET_HOME_DECOR_STORE     ; 1c
	const TILESET_MUSEUM               ; 1d
	const TILESET_HOTEL                ; 1e
	const TILESET_SPROUT_TOWER         ; 1f
	const TILESET_BATTLE_TOWER_INSIDE  ; 20
	const TILESET_RADIO_TOWER          ; 21
	const TILESET_LIGHTHOUSE           ; 22
	const TILESET_UNDERGROUND          ; 23
	const TILESET_CAVE                 ; 24
	const TILESET_QUIET_CAVE           ; 25
	const TILESET_ICE_PATH             ; 26
	const TILESET_TUNNEL               ; 27
	const TILESET_FOREST               ; 28
	const TILESET_PARK                 ; 29
	const TILESET_SAFARI_ZONE          ; 2a
	const TILESET_RUINS_OF_ALPH        ; 2b
	const TILESET_POKEMON_MANSION      ; 2c
	const TILESET_BATTLE_FACTORY       ; 2d
	const TILESET_SNOWTOP_MOUNTAIN     ; 2e
	const TILESET_HIDDEN_GROTTO        ; 2f
	const TILESET_PEAKS                ; 30
	const TILESET_HIDEOUT              ; 31
	const TILESET_KANTO_GYM            ; 32
DEF NUM_TILESETS EQU const_value - 1

; wTileset struct size
DEF TILESET_LENGTH EQU 18

; MapGroupRoofs values (see data/maps/roofs.asm)
; MapGroupRoofGFX indexes (see engine/tilesets/mapgroup_roofs.asm)
	const_def
	const ROOF_NEW_BARK  ; 0
	const ROOF_VIOLET    ; 1
	const ROOF_AZALEA    ; 2
	const ROOF_OLIVINE   ; 3
	const ROOF_GOLDENROD ; 4
DEF NUM_ROOFS EQU const_value

; roof length (see gfx/tilesets/roofs)
DEF ROOF_LENGTH EQU 9

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
