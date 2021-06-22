; Syntactic sugar MACROs

lb: MACRO ; r, hi, lo
	ld \1, LOW(\2) << 8 | LOW(\3)
ENDM

ln: MACRO ; r, hi, lo[, hi, lo]
	if _NARG == 3
		ld \1, ((\2) & $f) << 4 | ((\3) & $f)
	else
		lb \1, ((\2) & $f) << 4 | ((\3) & $f), ((\4) & $f) << 4 | ((\5) & $f)
	endc
ENDM

maskbits: MACRO
; masks just enough bits to cover the first argument
; the second argument is an optional shift amount
; e.g. "maskbits 26" becomes "and %00011111" (since 26 - 1 = %00011001)
; and "maskbits 3, 2" becomes "and %00001100" (since "maskbits 3" becomes %00000011)
; example usage in rejection sampling:
; .loop
; 	call Random
; 	maskbits 26
; 	cp 26
; 	jr nc, .loop
	def x = 1
	rept 8
		if x + 1 < (\1)
			redef x = x << 1 | 1
		endc
	endr
	if _NARG == 2
		and x << (\2)
	else
		and x
	endc
ENDM

ldpixel: MACRO
	if _NARG >= 5
		lb \1, \2 * 8 + \4, \3 * 8 + \5
	else
		lb \1, \2 * 8, \3 * 8
	endc
ENDM

depixel EQUS "ldpixel de,"
bcpixel EQUS "ldpixel bc,"


; Design patterns

eventflagset   EQUS "flagset wEventFlags,"
eventflagreset EQUS "flagreset wEventFlags,"
eventflagcheck EQUS "flagcheck wEventFlags,"

flagset: MACRO
	ld hl, \1 + (\2 >> 3)
	set (\2 & $7), [hl]
ENDM

flagreset: MACRO
	ld hl, \1 + (\2 >> 3)
	res (\2 & $7), [hl]
ENDM

flagcheck: MACRO
	ld hl, \1 + (\2 >> 3)
	bit (\2 & $7), [hl]
ENDM

changebridgeblock: MACRO
	; lb de, \1 + 4, \2 + 4
	; call GetBlockLocation
	ld hl, wOverworldMapBlocks + (\2 / 2 + 3) * (\4_WIDTH + 6) + \1 / 2 + 3
	; hard-coding the above calculation for efficiency
	ld [hl], \3
ENDM
