; DexNav species list (see engine/dexnav/dexnav.asm)
; Evening lists can combine the day and night grass tables.
DEF DEXNAV_LIST_MAX  EQU NUM_GRASSMON * 2
; The list's box spans x 7-19, y 0-10, above the text box (rows 12-17).
; Width fits the cursor plus a 10-character name.
DEF DEXNAV_MENU_ROWS EQU 4
DEF DEXNAV_MENU_LEFT EQU 8
