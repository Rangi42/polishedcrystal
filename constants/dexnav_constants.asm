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

; Reachability grid around the player (wDexNavReach)
DEF DEXNAV_REACH_SIZE   EQU DEXNAV_MAX_OFFSET * 2 + 1
DEF DEXNAV_REACH_CENTER EQU DEXNAV_MAX_OFFSET * DEXNAV_REACH_SIZE + DEXNAV_MAX_OFFSET
; Cell bits; 0-3 are the side wall edges from GetSideWallDirectionMask
DEF SIDE_WALL_TOP_F    EQU 0
DEF SIDE_WALL_BOTTOM_F EQU 1
DEF SIDE_WALL_LEFT_F   EQU 2
DEF SIDE_WALL_RIGHT_F  EQU 3
DEF DEXNAV_WALKABLE_F  EQU 6
DEF DEXNAV_REACHED_F   EQU 7

; Sneaking (DexNav_StepCheck). Tunables; CFRU uses 5 tiles and a 15 s timer.
DEF DEXNAV_SNEAK_DISTANCE EQU 4  ; running/biking this close scares it off
DEF DEXNAV_HUNT_STEPS     EQU 20 ; steps before it gets away

; Spontaneous hidden Pokemon (D19): 1 in (mask + 1) steps
if DEF(DEBUG)
DEF DEXNAV_SPONTANEOUS_MASK EQU %00000111 ; 1 in 8, for testing
else
DEF DEXNAV_SPONTANEOUS_MASK EQU %00111111 ; 1 in 64
endc

; wDexNavHuntFlags
DEF DEXNAV_HUNT_SPONTANEOUS_F EQU 0

; Search level gained per DexNav battle (D21)
if DEF(DEBUG)
DEF DEXNAV_LEVEL_STEP EQU 5 ; reach the tiers quickly for testing
else
DEF DEXNAV_LEVEL_STEP EQU 1
endc

; Search level tiers (CFRU): levels 0, 5, 10, 25, 50, 100
DEF DEXNAV_NUM_TIERS EQU 6
; Boost chances per tier (DexNavBoostChances), in percent
	const_def
	const DEXNAV_CHANCE_EGG_MOVE
	const DEXNAV_CHANCE_HIDDEN_ABILITY
	const DEXNAV_CHANCE_ONE_STAR
	const DEXNAV_CHANCE_TWO_STAR
	const DEXNAV_CHANCE_THREE_STAR
DEF DEXNAV_CHANCE_SIZE EQU const_value
