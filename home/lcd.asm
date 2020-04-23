LCD::
	push af
	ldh a, [hMPState]
	inc a
	jr z, .bill_pc
	dec a
	jr nz, .musicplayer
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

.musicplayer
	ldh a, [rLY]
	cp PIANO_ROLL_HEIGHT_PX
	jr nc, .donemp

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

if 0 ; if LOW(wMPNotes)
	ld a, l
	add LOW(wMPNotes)
	ld l, a
	ld a, h
	adc HIGH(wMPNotes)
	ld h, a
else
	ld a, h
	add HIGH(wMPNotes)
	ld h, a
endc

	ld a, [hli]
	ld [oamSprite00XCoord], a
	ld a, [hli]
	ld [oamSprite01XCoord], a
	ld a, [hli]
	ld [oamSprite02XCoord], a
	pop hl

.donemp
	pop af
	reti

.bill_pc
	ld a, [rSTAT]
	bit 2, a
	jr z, .donepc
	jr .donepc
	push hl
	push bc
	ld c, LOW(rBGPD)
	ld hl, wBillsPC_CurMonPals

	; start of VRAM writes
	; first mon
	ld a, $82
	ldh [rBGPI], a
rept 4
	ld a, [hli]
	ld [c], a
endr

	; second mon
	ld a, $8a
	ldh [rBGPI], a
rept 4
	ld a, [hli]
	ld [c], a
endr

	; third mon
	ld a, $92
	ldh [rBGPI], a
rept 4
	ld a, [hli]
	ld [c], a
endr

	; fourth mon
	ld a, $9a
	ldh [rBGPI], a
rept 4
	ld a, [hli]
	ld [c], a
endr
	; end of VRAM writes

	; prepare for next write
	push de
	ldh a, [rLYC]
	cp 115
	jr nz, .increase_lyc
	sub 32
.increase_lyc
	add 8
	ldh [rLYC], a
	add a
	ld b, 0
	ld c, a
	ld hl, wBillsPC_MonPals1 - 182
	add hl, bc
	ld de, wBillsPC_CurMonPals
	ld c, 16
	jr .finished
	rst CopyBytes
.finished
	pop de
	pop bc
	pop hl
.donepc
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
