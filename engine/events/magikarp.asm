Special_CheckMagikarpLength:
	; Returns 3 if you select a Magikarp that beats the previous record.
	; Returns 2 if you select a Magikarp, but the current record is longer.
	; Returns 1 if you press B in the Pokemon selection menu.
	; Returns 0 if the Pokemon you select is not a Magikarp.

	; Let's start by selecting a Magikarp.
	farcall SelectMonFromParty
	jr c, .declined
	ld a, [wCurPartySpecies]
	cp MAGIKARP
	jr nz, .not_magikarp

	; Now let's compute its length based on its DVs and ID.
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	push hl
	ld bc, MON_DVS
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, MON_ID
	add hl, bc
	ld b, h
	ld c, l
	call CalcMagikarpLength
	call PrintMagikarpLength
	ld hl, .MeasureItText
	call PrintText

	; Did we beat the record?
	ld hl, wMagikarpLengthMm
	ld de, wBestMagikarpLengthMm
	ld c, 2
	call StringCmp
	jr nc, .not_long_enough

	; NEW RECORD!!! Let's save that.
	ld hl, wMagikarpLengthMm
	ld de, wBestMagikarpLengthMm
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOT
	call SkipNames
	rst CopyBytes
	ld a, 3
	ldh [hScriptVar], a
	ret

.not_long_enough
	ld a, 2
	ldh [hScriptVar], a
	ret

.declined
	ld a, 1
	ldh [hScriptVar], a
	ret

.not_magikarp
	xor a
	ldh [hScriptVar], a
	ret

.MeasureItText:
	; Let me measure that MAGIKARP. …Hm, it measures @ .
	text_jump _MagikarpGuruMeasureText
	text_end

PrintMagikarpLength:
	ld a, [wOptions2]
	bit POKEDEX_UNITS, a
	jr z, .imperial
	ld hl, wStringBuffer1
	ld de, wMagikarpLengthMm
	lb bc, PRINTNUM_LEFTALIGN | 2, 4
	call PrintNum
	dec hl
	ld a, [hl]
	ld [hl], "."
	inc hl
	ld [hli], a
	ld [hl], "c"
	inc hl
	ld [hl], "m"
	inc hl
	ld [hl], "@"
	ret

.imperial
	ld a, [wMagikarpLengthMmHi]
	ld b, a
	ld a, [wMagikarpLengthMmLo]
	ld c, a
	ld de, 2580 ; (1/25.4) << 16
	xor a
	ldh [hTmpd], a
	ldh [hTmpe], a
	ld hl, 0
	ld a, 16
	ldh [hProduct], a
.loop
	add hl, hl
	ldh a, [hTmpe]
	rla
	ldh [hTmpe], a
	ldh a, [hTmpd]
	rla
	ldh [hTmpd], a
	sla e
	rl d
	jr nc, .noadd
	add hl, bc
	ldh a, [hTmpe]
	adc 0
	ldh [hTmpe], a
	ldh a, [hTmpd]
	adc 0
	ldh [hTmpd], a
.noadd
	ldh a, [hProduct]
	dec a
	ldh [hProduct], a
	jr nz, .loop
	ldh a, [hTmpd]
	ld h, a
	ldh a, [hTmpe]
	ld l, a
	ld bc, -12
	ld e, 0
.inchloop
	ld a, h
	and a
	jr nz, .inchloop2
	ld a, l
	cp 12
	jr c, .inchdone
.inchloop2
	add hl, bc
	inc e
	jr .inchloop
.inchdone
	ld a, e
	ld [wMagikarpLengthMmHi], a
	ld a, l
	ld [wMagikarpLengthMmLo], a
	ld hl, wStringBuffer1
	ld de, wMagikarpLengthMmHi
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	call PrintNum
	ld [hl], "′"
	inc hl
	ld de, wMagikarpLengthMmLo
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	call PrintNum
	ld [hl], "″"
	inc hl
	ld [hl], "@"
	ret

CalcMagikarpLength:
; Return Magikarp's length (in mm) at wMagikarpLengthMm (big endian).
;
; input:
;   de: wOTPartyMon1DVs
;   bc: wPlayerID

; This function is poorly commented.

; In short, it generates a value between 190 and 1786 using
; a Magikarp's DVs and its trainer ID. This value is further
; filtered in LoadEnemyMon to make longer Magikarp even rarer.

; The value is generated from a lookup table.
; The index is determined by the dv xored with the player's trainer id.

; bc = rrc(dv[0]) ++ rrc(dv[1]) ^ rrc(id)

; if bc < 10:    [wMagikarpLengthMm] = c + 190
; if bc ≥ $ff00: [wMagikarpLengthMm] = c + 1370
; else:          [wMagikarpLengthMm] = z × 100 + (bc − x) / y

; X, Y, and Z depend on the value of b as follows:

; if b = 0:        x =   310,  y =   2,  z =  3
; if b = 1:        x =   710,  y =   4,  z =  4
; if b = 2-9:      x =  2710,  y =  20,  z =  5
; if b = 10-29:    x =  7710,  y =  50,  z =  6
; if b = 30-68:    x = 17710,  y = 100,  z =  7
; if b = 69-126:   x = 32710,  y = 150,  z =  8
; if b = 127-185:  x = 47710,  y = 150,  z =  9
; if b = 186-224:  x = 57710,  y = 100,  z = 10
; if b = 225-243:  x = 62710,  y =  50,  z = 11
; if b = 244-251:  x = 64710,  y =  20,  z = 12
; if b = 252-253:  x = 65210,  y =   5,  z = 13
; if b = 254:      x = 65410,  y =   2,  z = 14

	; bc = rrc(dv[0]) ++ rrc(dv[1]) ^ rrc(id)

	; id
	ld h, b
	ld l, c
	ld a, [hli]
	ld b, a
	ld c, [hl]
	rrc b
	rrc c

	; dv
	ld a, [de]
	inc de
	rrca
	rrca
	xor b
	ld b, a

	ld a, [de]
	rrca
	rrca
	xor c
	ld c, a

	; if bc < 10:
	;     de = bc + 190
	;     break

	ld a, b
	and a
	jr nz, .no
	ld a, c
	cp 10
	jr nc, .no

	ld hl, 190
	add hl, bc
	ld d, h
	ld e, l
	jr .done

.no

	ld hl, MagikarpLengths
	ld a, 2
	ld [wd265], a

.read
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call .BCLessThanDE
	jr nc, .next

	; c = (bc - de) / [hl]
	call .BCMinusDE
	ld a, b
	ldh [hDividend + 0], a
	ld a, c
	ldh [hDividend + 1], a
	ld a, [hl]
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 2]
	ld c, a

	; de = c + 100 × (2 + i)
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, 100
	ldh [hMultiplicand + 2], a
	ld a, [wd265]
	ldh [hMultiplier], a
	call Multiply
	ld b, 0
	ldh a, [hProduct + 3]
	add c
	ld e, a
	ldh a, [hProduct + 2]
	adc b
	ld d, a
	jr .done

.next
	inc hl ; align to next triplet
	ld a, [wd265]
	inc a
	ld [wd265], a
	cp 16
	jr c, .read

	call .BCMinusDE
	ld hl, 1600
	add hl, bc
	ld d, h
	ld e, l

.done

;	; hl = de × 10
;	ld h, d
;	ld l, e
;rept 2
;	add hl, hl
;endr
;	add hl, de
;	add hl, hl
;
;	; hl = hl / 254
;	ld de, -254
;	ld a, -1
;.div_254
;	inc a
;	add hl, de
;	jr c, .div_254
;
;	; d, e = hl / 12, hl % 12
;	ld d, 0
;.mod_12
;	cp 12
;	jr c, .ok
;	sub 12
;	inc d
;	jr .mod_12
;.ok
;	ld e, a

	ld hl, wMagikarpLengthMm
	ld [hl], d
	inc hl
	ld [hl], e
	ret

.BCLessThanDE:
; return bc < de
	ld a, b
	cp d
	ret c
	ld a, c
	cp e
	ret

.BCMinusDE:
; bc -= de
	ld a, c
	sub e
	ld c, a
	ld a, b
	sbc d
	ld b, a
	ret

INCLUDE "data/events/magikarp_lengths.asm"

Special_MagikarpHouseSign:
	ld a, [wBestMagikarpLengthMmHi]
	ld [wMagikarpLengthMmHi], a
	ld a, [wBestMagikarpLengthMmLo]
	ld [wMagikarpLengthMmLo], a
	call PrintMagikarpLength
	ld hl, .CurrentRecordtext
	jp PrintText

.CurrentRecordtext:
	; "CURRENT RECORD"
	text_jump _KarpGuruRecordText
	text_end
