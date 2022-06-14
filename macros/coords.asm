DEF hlcoord EQUS "coord hl,"
DEF bccoord EQUS "coord bc,"
DEF decoord EQUS "coord de,"

coord: MACRO
; register, x, y[, origin]
	if _NARG < 4
		ld \1, (\3) * SCREEN_WIDTH + (\2) + wTilemap
	else
		ld \1, (\3) * SCREEN_WIDTH + (\2) + \4
	endc
ENDM

DEF hldexcoord EQUS "dexcoord hl,"
DEF bcdexcoord EQUS "dexcoord bc,"
DEF dedexcoord EQUS "dexcoord de,"

dexcoord: MACRO
; register, x, y[, origin]
	if _NARG < 4
		ld \1, (\3) * BG_MAP_WIDTH + (\2) + wDexTilemap
	else
		ld \1, (\3) * BG_MAP_WIDTH + (\2) + \4
	endc
ENDM

DEF hlbgcoord EQUS "bgcoord hl,"
DEF bcbgcoord EQUS "bgcoord bc,"
DEF debgcoord EQUS "bgcoord de,"

bgcoord: MACRO
; register, x, y[, origin]
	if _NARG < 4
		ld \1, (\3) * BG_MAP_WIDTH + (\2) + vBGMap0
	else
		ld \1, (\3) * BG_MAP_WIDTH + (\2) + \4
	endc
ENDM

dwcoord: MACRO
; x, y
	rept _NARG / 2
		dw (\2) * SCREEN_WIDTH + (\1) + wTilemap
		shift 2
	endr
ENDM

ldcoord_a: MACRO
; x, y[, origin]
	if _NARG < 3
		ld [(\2) * SCREEN_WIDTH + (\1) + wTilemap], a
	else
		ld [(\2) * SCREEN_WIDTH + (\1) + \3], a
	endc
ENDM

lda_coord: MACRO
; x, y[, origin]
	if _NARG < 3
		ld a, [(\2) * SCREEN_WIDTH + (\1) + wTilemap]
	else
		ld a, [(\2) * SCREEN_WIDTH + (\1) + \3]
	endc
ENDM

menu_coords: MACRO
; x1, y1, x2, y2
	db \2, \1 ; start coords
	db \4, \3 ; end coords
ENDM
