; Tilesets indexes (see data/tilesets.asm)
	const_def 1
	const TILESET_JOHTO_TRADITIONAL    ; 01
	const TILESET_JOHTO_MODERN         ; 02
	const TILESET_BATTLE_TOWER_OUTSIDE ; 03
	const TILESET_JOHTO_OVERCAST       ; 04
	const TILESET_KANTO                ; 05
	const TILESET_INDIGO_PLATEAU       ; 06
	const TILESET_SHAMOUTI_ISLAND      ; 07
	const TILESET_VALENCIA_ISLAND      ; 08
	const TILESET_FARAWAY_ISLAND       ; 09
	const TILESET_JOHTO_HOUSE          ; 0a
	const TILESET_KANTO_HOUSE          ; 0b
	const TILESET_TRADITIONAL_HOUSE    ; 0c
	const TILESET_POKECENTER           ; 0d
	const TILESET_POKECOM_CENTER       ; 0e
	const TILESET_MART                 ; 0f
	const TILESET_GATE                 ; 10
	const TILESET_GYM                  ; 11
	const TILESET_MAGNET_TRAIN         ; 12
	const TILESET_CHAMPIONS_ROOM       ; 13
	const TILESET_PORT                 ; 14
	const TILESET_LAB                  ; 15
	const TILESET_FACILITY             ; 16
	const TILESET_CELADON_MANSION      ; 17
	const TILESET_GAME_CORNER          ; 18
	const TILESET_HOME_DECOR_STORE     ; 19
	const TILESET_MUSEUM               ; 1a
	const TILESET_HOTEL                ; 1b
	const TILESET_SPROUT_TOWER         ; 1c
	const TILESET_BATTLE_TOWER_INSIDE  ; 1d
	const TILESET_RADIO_TOWER          ; 1e
	const TILESET_LIGHTHOUSE           ; 1f
	const TILESET_UNDERGROUND          ; 20
	const TILESET_CAVE                 ; 21
	const TILESET_QUIET_CAVE           ; 22
	const TILESET_ICE_PATH             ; 23
	const TILESET_TUNNEL               ; 24
	const TILESET_FOREST               ; 25
	const TILESET_PARK                 ; 26
	const TILESET_SAFARI_ZONE          ; 27
	const TILESET_RUINS_OF_ALPH        ; 28
	const TILESET_ALPH_WORD_ROOM       ; 29
	const TILESET_POKEMON_MANSION      ; 2a
	const TILESET_BATTLE_FACTORY       ; 2b
NUM_TILESETS EQU const_value - 1

; wTileset struct size
TILESET_LENGTH EQU 20

; roof length (see gfx/tilesets/roofs)
ROOF_LENGTH EQU 9

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
