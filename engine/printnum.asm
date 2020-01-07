PrintHLNum:
; Possibly print a number at hl and increase it.
; [de] contains a BCD-encoded number that we print from.
; c is the loop counter (how many digits are left).
; b & $f contains the maximum string length. (b & $e0 is flags).
; hl is where we print to (usually the screen).
	bit 0, c
	jr nz, .c_odd
	swap a
	jr .c_ok
.c_odd
	inc de
.c_ok
	and $f
	jr z, .maybe_not_yet
	set PRINTNUM_LEADINGZEROS_F, b
.maybe_not_yet
	push af

	; We might still be higher bytewise than we're printing
	ld a, b
	and $f
	cp c
	jr nc, .ok
	pop af
	ret

.ok
	; Now print the number in a
	pop af
	jr nz, .check_money

	; just print a zero if we're in zero-mode
	bit PRINTNUM_LEADINGZEROS_F, b
	jr nz, .check_money

	; for the last digit, print 0 anyway
	ld a, c
	dec a
	jr z, .check_money

	; if we're left-aligning the number, don't print anything
	bit PRINTNUM_LEFTALIGN_F, b
	ret nz

	; print a space
	ld a, " "
	jr .got_value

.check_money
	bit PRINTNUM_MONEY_F, b
	jr z, .got_number
	res PRINTNUM_MONEY_F, b
	push af
	ld a, "¥"
	ld [hli], a
	pop af

.got_number
	add "0"
.got_value
	ld [hli], a
	ret

_PrintNum:: ; c4c7
; Print c digits of the b-byte value from de to hl.
; Works on up to 1-8 digits and up to 4 bytes (up to 99999999).
; The higher b nibble has some flags:
; Bit 5: Print a pokedollar sign before the number itself
; Bit 6: Left-aligned number instead of right-aligned
; Bit 7: Print leading zeros
; Preserves bc.
	push bc
	; Extend the number at de to 32bit into hPrintNum
	push hl
	ld hl, hPrintNum
	push bc
	push hl
	ld c, 4
	ld a, b
	and $1f
	ld b, a
.loop
	ld a, b
	cp c
	ld a, 0
	jr c, .loopnext
	ld a, [de]
	inc de
.loopnext
	ld [hli], a
	dec c
	jr nz, .loop
	pop hl

	; Zero hPrintNum, moving its content to bcde
	push de
	xor a
	ld b, [hl]
	ld [hli], a
	ld c, [hl]
	ld [hli], a
	ld d, [hl]
	ld [hli], a
	ld e, [hl]
	ld [hl], a
	ld h, 32

.loop2
	push hl
	ld hl, hPrintNum + 3
	sla e
	rl d
	rl c
	rl b
rept 4
	ld a, [hl]
	adc a
	daa
	ld [hld], a
endr
	pop hl
	dec h
	jr nz, .loop2
	pop de
	pop bc
	pop hl

	; At this point, hPrintNum has zerofilled BCD-format numbers.
	; Now print the number to the screen.
	; Store maximum string length in the lower b nibble instead of c.
	; Use c as a loop counter instead. This simplifies code a bit.
	ld a, b
	and $e0
	add c
	ld c, 8
	ld b, a
	ld de, hPrintNum
.loop3
	ld a, [de]
	call PrintHLNum
	dec c
	jr nz, .loop3
	pop bc
	ret
