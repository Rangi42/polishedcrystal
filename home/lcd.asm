LCD::
	push af
	ldh a, [hMPState]
	and a
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
	ld [$fe00+4*0], a ; OAM 0 y
	ld [$fe00+4*1], a ; OAM 1 y
	ld [$fe00+4*2], a ; OAM 2 y

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
	ld [$fe00+4*0+1], a ; OAM 0 x
	ld a, [hli]
	ld [$fe00+4*1+1], a ; OAM 1 x
	ld a, [hli]
	ld [$fe00+4*2+1], a ; OAM 2 x
	pop hl

.donemp
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
	res 0, a ; vblank
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
