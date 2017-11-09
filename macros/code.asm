lb: MACRO ; r, hi, lo
	ld \1, (\2 & $ff) << 8 + (\3 & $ff)
	ENDM

ln: MACRO ; r, hi, lo
	ld \1, (\2 & $f) << 4 + (\3 & $f)
	ENDM


bccoord equs "coord bc,"
decoord equs "coord de,"
hlcoord equs "coord hl,"

coord: MACRO
; register, x, y[, origin]
	if _NARG < 4
	ld \1, TileMap + SCREEN_WIDTH * (\3) + (\2)
	else
	ld \1, \4 + SCREEN_WIDTH * (\3) + (\2)
	endc
	ENDM

dwcoord: MACRO
	rept _NARG / 2
	dw TileMap + SCREEN_WIDTH * (\2) + (\1)
	shift
	shift
	endr
	ENDM

ldcoord_a: MACRO
	if _NARG < 3
	ld [TileMap + SCREEN_WIDTH * (\2) + (\1)], a
	else
	ld [\3 + SCREEN_WIDTH * (\2) + (\1)], a
	endc
	ENDM

lda_coord: MACRO
	if _NARG < 3
	ld a, [TileMap + SCREEN_WIDTH * (\2) + (\1)]
	else
	ld a, [\3 + SCREEN_WIDTH * (\2) + (\1)]
	endc
	ENDM


ldpixel: MACRO
if _NARG >= 5
	lb \1, \2 * 8 + \4, \3 * 8 + \5
else
	lb \1, \2 * 8, \3 * 8
endc
endm

depixel EQUS "ldpixel de,"
bcpixel EQUS "ldpixel bc,"


bgcoord: MACRO
IF _NARG >= 4
	ld \1, \3 * $20 + \2 + \4
ELSE
	ld \1, \3 * $20 + \2 + VBGMap0
ENDC
ENDM

hlbgcoord EQUS "bgcoord hl,"
debgcoord EQUS "bgcoord de,"
bcbgcoord EQUS "bgcoord bc,"

bgrows EQUS "* $20"


jumptable: MACRO
	ld a, [\2]
	ld e, a
	ld d, 0
	ld hl, \1
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
endm


eventflagset equs "flagset EventFlags,"
eventflagreset equs "flagreset EventFlags,"
eventflagcheck equs "flagcheck EventFlags,"

flagset: MACRO
	ld hl, \1 + (\2 >> 3)
	set (\2 & $7), [hl]
endm

flagreset: MACRO
	ld hl, \1 + (\2 >> 3)
	res (\2 & $7), [hl]
endm

flagcheck: MACRO
	ld hl, \1 + (\2 >> 3)
	bit (\2 & $7), [hl]
endm

changebridgeblock: macro
	; lb de, \1 + 4, \2 + 4
	; call GetBlockLocation
	ld hl, OverworldMap + (\2 / 2 + 3) * (\4_WIDTH + 6) + \1 / 2 + 3
	; hard-coding the above calculation for efficiency
	ld [hl], \3
endm
