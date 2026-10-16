; DexNav species list (see engine/dexnav/dexnav.asm)
; Evening lists can combine the day and night grass tables.
DEF DEXNAV_LIST_MAX  EQU NUM_GRASSMON * 2
; Full-screen page: area name box (rows 0-2), list box (rows 3-13),
; prompt box (rows 14-17). Each list row is two tiles tall.
DEF DEXNAV_MENU_ROWS EQU 4
DEF DEXNAV_MENU_TOP  EQU 4
DEF DEXNAV_PROMPT_Y  EQU DEXNAV_MENU_TOP + DEXNAV_MENU_ROWS * 2 + 2

; Fishing species join the water list and hunts (D3): Old, Good and Super Rod
DEF NUM_DEXNAV_RODS          EQU 3
DEF DEXNAV_MAX_FISH_ENTRIES  EQU 3 + 4 + 4 ; entries per rod table

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

; Chain (D7). CFRU: the first win makes it 2, then +1, and 100 wraps to 1.
DEF DEXNAV_MAX_CHAIN EQU 100
if DEF(DEBUG)
DEF DEXNAV_CHAIN_START EQU 10 ; reach the milestones quickly for testing
DEF DEXNAV_CHAIN_STEP  EQU 10
else
DEF DEXNAV_CHAIN_START EQU 2
DEF DEXNAV_CHAIN_STEP  EQU 1
endc
; Chain boosts (CFRU): +chain/5 levels; extra shiny passes at exactly these
; chains; and a DEXNAV_CHAIN_BONUS_CHANCE% chance each of +10 levels and +4 passes
DEF DEXNAV_CHAIN_MILESTONE_1  EQU 50
DEF DEXNAV_CHAIN_PASSES_1     EQU 5
DEF DEXNAV_CHAIN_MILESTONE_2  EQU 100
DEF DEXNAV_CHAIN_PASSES_2     EQU 10
DEF DEXNAV_CHAIN_BONUS_CHANCE EQU 4
DEF DEXNAV_CHAIN_BONUS_LEVELS EQU 10
DEF DEXNAV_CHAIN_BONUS_PASSES EQU 4

; wDexNavHuntFlags
DEF DEXNAV_HUNT_SPONTANEOUS_F EQU 0

; Marks the saved search-level table as valid (D6)
DEF DEXNAV_SAVE_MAGIC EQU $DE

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
