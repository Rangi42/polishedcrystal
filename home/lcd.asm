LCD:: ; 552
	push af
	ld a, [hMPState]
	and a
	jr nz, .musicplayer
	ld a, [hLCDCPointer]
	and a
	jr z, .done

; At this point it's assumed we're in WRAM bank 5!
	push bc
	ld a, [rLY]
	ld c, a
	ld b, LYOverrides >> 8
	ld a, [bc]
	ld b, a
	ld a, [hLCDCPointer]
	ld c, a
	ld a, b
	ld [$ff00+c], a
	pop bc

.done
	pop af
	reti

.musicplayer
	ld a, [rLY]
	cp PIANO_ROLL_HEIGHT_PX
	jr nc, .donemp

	push hl

	ld l, a
	add SCREEN_HEIGHT - 1
	ld [$fe00+4*0], a ; OAM 0 y
	ld [$fe00+4*1], a ; OAM 1 y
	ld [$fe00+4*2], a ; OAM 2 y

	ld a, [hMPState]
	inc a
	add l
	jr nc, .ok
	sub SCREEN_HEIGHT_PX
.ok

	ld h, 0
	ld l, a
	add hl, hl
	add hl, hl

if 0 ; if wMPNotes % $100
	ld a, l
	add wMPNotes % $100
	ld l, a
	ld a, h
	adc wMPNotes / $100
	ld h, a
else
	ld a, h
	add wMPNotes / $100
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
; 568


DisableLCD:: ; 568
; Turn the LCD off

; Don't need to do anything if the LCD is already off
	ld a, [rLCDC]
	bit 7, a ; lcd enable
	ret z

	xor a
	ld [rIF], a
	ld a, [rIE]
	ld b, a

; Disable VBlank
	res 0, a ; vblank
	ld [rIE], a

.wait
; Wait until VBlank would normally happen
	ld a, [rLY]
	cp 145
	jr nz, .wait

	ld a, [rLCDC]
	and %01111111 ; lcd enable off
	ld [rLCDC], a

	xor a
	ld [rIF], a
	ld a, b
	ld [rIE], a
	ret
; 58a


EnableLCD:: ; 58a
	ld a, [rLCDC]
	set 7, a ; lcd enable
	ld [rLCDC], a
	ret
; 591
