	const_def
	const SUMMARY_PINK_PAGE   ; 0
	const SUMMARY_BLUE_PAGE   ; 1
	const SUMMARY_GREEN_PAGE  ; 2
	const SUMMARY_ORANGE_PAGE ; 3
DEF NUM_SUMMARY_PAGES EQU const_value

; Routines for hblank (see home/lcd.asm)
DEF SUMMARY_LCD_HIDE_WINDOW EQU 0
DEF SUMMARY_LCD_SHOW_WINDOW EQU 1
DEF SUMMARY_LCD_SCROLL_BACKGROUND EQU 2

; wSummaryScreenFlags
DEF SUMMARY_FLAGS_PLACE_FRONTPIC_F EQU 4
DEF SUMMARY_FLAGS_FINISH_ANIM_F    EQU 5
DEF SUMMARY_FLAGS_DO_ANIM_F        EQU 6

DEF SUMMARY_FLAGS_PAGE_MASK EQU %00000011

; vTiles0
DEF SUMMARY_TILE_OAM_START                  EQU $3C
DEF SUMMARY_TILE_OAM_PAGE                   EQU $3C
DEF SUMMARY_TILE_OAM_SELECTED_PAGE          EQU $3D
DEF SUMMARY_TILE_OAM_BALL_TOP_BORDER        EQU $3E
DEF SUMMARY_TILE_OAM_A_INFO                 EQU $40
DEF SUMMARY_TILE_OAM_TITLES                 EQU $44
DEF SUMMARY_TILE_OAM_EXP_TITLE              EQU $44
DEF SUMMARY_TILE_OAM_ABILITY_TITLE          EQU $48
DEF SUMMARY_TILE_OAM_ITEM_TITLE             EQU $4C
DEF SUMMARY_TILE_OAM_MOVE_TITLE             EQU $50
DEF SUMMARY_TILE_OAM_MET_TITLE              EQU $54
DEF SUMMARY_TILE_OAM_EGG_TITLE              EQU $58
DEF SUMMARY_TILE_OAM_ARROW                  EQU $5C
DEF SUMMARY_TILE_OAM_SWAP_ARROW             EQU $60
DEF SUMMARY_TILE_OAM_STATUS                 EQU $64

; vTiles2
DEF SUMMARY_TILE_START                      EQU $31
DEF SUMMARY_TILE_SIDE_WINDOW_TL             EQU $31
DEF SUMMARY_TILE_SIDE_WINDOW_L              EQU $32
DEF SUMMARY_TILE_SIDE_WINDOW_T              EQU $34
DEF SUMMARY_TILE_SIDE_WINDOW_BL             EQU $33
DEF SUMMARY_TILE_SIDE_WINDOW_B              EQU $35
DEF SUMMARY_TILE_BOTTOM_WINDOW_T            EQU $38
DEF SUMMARY_TILE_BOTTOM_WINDOW_B            EQU SUMMARY_TILE_SIDE_WINDOW_B
DEF SUMMARY_TILE_BOTTOM_WINDOW_CORNER       EQU $36
DEF SUMMARY_TILE_BOTTOM_WINDOW_INNER_CORNER EQU $37
DEF SUMMARY_TILE_BALL_SIDE_BORDER           EQU $39
DEF SUMMARY_TILE_TYPE_BG_LEFT               EQU $3A
DEF SUMMARY_TILE_TYPE_BG_MIDDLE             EQU $3B
DEF SUMMARY_TILE_TYPE_BG_RIGHT              EQU $3C
DEF SUMMARY_TILE_POKERUS                    EQU $3D
DEF SUMMARY_TILE_POKERUS_CURED              EQU $3E
DEF SUMMARY_TILE_HIDDEN_H                   EQU $3F
DEF SUMMARY_TILE_HYPER_TRAINING             EQU $40
DEF SUMMARY_TILE_LEFT_ARROW                 EQU $41
DEF SUMMARY_TILE_RIGHT_ARROW                EQU $42
DEF SUMMARY_TILE_BALL                       EQU $4F
DEF SUMMARY_TILE_CATEGORY_START             EQU $50
DEF SUMMARY_TILE_ITEM                       EQU $56

; vTiles3
DEF SUMMARY_TILE_TYPE_START                 EQU $00

; bg palettes
DEF SUMMARY_PAL_LOWER_WINDOW                EQU $00
DEF SUMMARY_PAL_POKEMON                     EQU $01
DEF SUMMARY_PAL_ITEM                        EQU $02
DEF SUMMARY_PAL_SIDE_WINDOW                 EQU $03
DEF SUMMARY_PAL_SHINY_POKERUS               EQU $04
DEF SUMMARY_PAL_NATURE_UP                   EQU $04
DEF SUMMARY_PAL_HP_BAR                      EQU $05
DEF SUMMARY_PAL_GENDER_MARKER               EQU $06
DEF SUMMARY_PAL_POKEBALL                    EQU $07
DEF SUMMARY_PAL_NATURE_DOWN                 EQU $07

DEF SUMMARY_PAL_A_INFO                      EQU $04
DEF SUMMARY_PAL_TOP_ARROW                   EQU $06
DEF SUMMARY_PAL_BOTTOM_ARROW                EQU $07
