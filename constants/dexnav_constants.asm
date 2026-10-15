; DexNav species list (see engine/dexnav/dexnav.asm)
; Evening lists can combine the day and night grass tables.
DEF DEXNAV_LIST_MAX  EQU NUM_GRASSMON * 2
; The list's box spans x 7-19, y 0-10, above the text box (rows 12-17).
; Width fits the cursor plus a 10-character name.
DEF DEXNAV_MENU_ROWS EQU 4
DEF DEXNAV_MENU_LEFT EQU 8

; Target tile for a hunt (DexNav_StartHunt). Offsets keep it on screen.
DEF DEXNAV_MIN_DISTANCE EQU 3
DEF DEXNAV_MAX_DISTANCE EQU 6
DEF DEXNAV_MAX_OFFSET   EQU 4
DEF DEXNAV_TILE_TRIES   EQU 24
