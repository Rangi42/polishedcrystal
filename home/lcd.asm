LCDGeneric::
	push af
	ldh a, [hLCDCPointer]
	and a
	jr z, .done

; At this point it's assumed we're in WRAM bank 5!
	push bc
	ldh a, [rLY]
	ld c, a
	ld b, HIGH(wLYOverrides)
	ld a, [bc]
	ld b, a
	ldh a, [hLCDCPointer]
	ld c, a
	ld a, b
	ldh [c], a
	pop bc

.done
	pop af
	reti

LCDMusicPlayer::
	push af
	ldh a, [rLY]
	cp PIANO_ROLL_HEIGHT_PX
	jr nc, .done

	push hl

	ld l, a
	add SCREEN_HEIGHT - 1
	ld [oamSprite00YCoord], a
	ld [oamSprite01YCoord], a
	ld [oamSprite02YCoord], a

	ldh a, [hMPState]
	inc a
	add l
	jr nc, .ok
	sub SCREEN_HEIGHT_PX
.ok

	ld h, 0
	ld l, a
	add hl, hl
	add hl, hl

	assert LOW(wMPNotes) == 0
	ld a, h
	add HIGH(wMPNotes)
	ld h, a

	ld a, [hli]
	ld [oamSprite00XCoord], a
	ld a, [hli]
	ld [oamSprite01XCoord], a
	ld a, [hli]
	ld [oamSprite02XCoord], a
	pop hl

.done
	pop af
	reti

LCDBillsPC1::
	push af

	; Write boxmon palettes
	ldh a, [rSTAT]
	bit 2, a
	jr z, .donepc
	push hl
	push bc
	ld c, LOW(rBGPD)
	ld hl, wBillsPC_CurMonPals + 4

	; start of VRAM writes
	; second box mon
	ld a, $80 | $2a
	ldh [rBGPI], a
rept 4
	ld a, [hli]
	ld [c], a
endr

	; third box mon
	ld a, $80 | $32
	ldh [rBGPI], a
rept 4
	ld a, [hli]
	ld [c], a
endr

	; fourth box mon
	ld a, $80 | $3a
	ldh [rBGPI], a
rept 4
	ld a, [hli]
	ld [c], a
endr
	; end of VRAM writes

	; prepare for partymon write
	ld a, LOW(LCDBillsPC2)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDBillsPC2)
	ldh [hFunctionTargetHi], a
	pop bc
	pop hl
.donepc
	pop af
	reti

LCDBillsPC2::
	push af
	push hl
	push bc
	ld c, LOW(rBGPD)
	ld hl, wBillsPC_CurPartyPals

	; start of VRAM writes
	; first party mon
	ld a, $80 | $12
	ldh [rBGPI], a
rept 4
	ld a, [hli]
	ld [c], a
endr

	; second party mon
	ld a, $80 | $1a
	ldh [rBGPI], a
rept 4
	ld a, [hli]
	ld [c], a
endr

	; first box mon
	ld a, $80 | $22
	ldh [rBGPI], a
rept 4
	ld a, [hli]
	ld [c], a
endr
	; end of VRAM writes

	; prepare for next write
	push de
	ldh a, [rLYC]
	cp 135
	jr nz, .increase_lyc
	sub 16 * 5
.increase_lyc
	add 16
	ldh [rLYC], a

	; Since we write the next palette at the bottom row, we actually want to
	; copy not the upcoming palette, but the one after that.
	sub 55
	cp $50
	jr c, .got_result
	xor a
.got_result
	rrca
	ld c, a
	add a
	add c
	ld c, a
	ld b, 0

	; Copies party+mon palettes
	ld hl, wBillsPC_PalList
	add hl, bc
	ld de, wBillsPC_CurPals
	ld c, 24
	rst CopyBytes
	ld a, LOW(LCDBillsPC3)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDBillsPC3)
	ldh [hFunctionTargetHi], a
	pop de
	pop bc
	pop hl
	pop af
	reti

LCDBillsPC3:
; Writes white or box background to color0 for BG3
	push af
	push hl
	push bc
	push de
	ldh a, [rSVBK]
	push af
	ld a, BANK("GBC Video")
	ldh [rSVBK], a

	ld c, LOW(rBGPD)
	ldh a, [rLY]
	cp $8a
	ld hl, wBGPals1
	jr nc, .got_pal
	ld hl, wBGPals1 palette $4
.got_pal

	; start of VRAM writes
	; BG3 color 0
	ld a, $80 | $18
	ldh [rBGPI], a
rept 2
	ld a, [hli]
	ld [c], a
endr
	; end of VRAM writes

	pop af
	ldh [rSVBK], a
	ld a, LOW(LCDBillsPC1)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDBillsPC1)
	ldh [hFunctionTargetHi], a
	pop de
	pop bc
	pop hl
	pop af
	reti

DisableLCD::
; Turn the LCD off

; Don't need to do anything if the LCD is already off
	ldh a, [rLCDC]
	bit 7, a ; lcd enable
	ret z

	xor a
	ldh [rIF], a
	ldh a, [rIE]
	ld b, a

; Disable VBlank
	res VBLANK, a
	ldh [rIE], a

.wait
; Wait until VBlank would normally happen
	ldh a, [rLY]
	cp $90
	jr c, .wait
	cp $99
	jr z, .wait

	ldh a, [rLCDC]
	and %01111111 ; lcd enable off
	ldh [rLCDC], a

	xor a
	ldh [rIF], a
	ld a, b
	ldh [rIE], a
	ret

EnableLCD::
	ldh a, [rLCDC]
	set 7, a ; lcd enable
	ldh [rLCDC], a
	ret
