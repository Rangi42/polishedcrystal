GetDEValue:
	ld c, 0
	ret c
	ld a, [de]
	inc de
	ld c, a
	ld a, b
	ret

PrintHLNum:
; Possibly print a number at hl and increase it
	bit 0, b
	jr nz, .b_odd
	swap a
	jr .b_ok
.b_odd
	inc de
.b_ok
	and $f
	jr z, .maybe_not_yet
	set PRINTNUM_LEADINGZEROS_F, b
.maybe_not_yet
	ld [hPrintNum + 4], a

	; We might still be higher bytewise than we're printing
	ld a, b
	and $f
	cp c
	jr z, .ok
	ret nc

.ok
	; Now print the number stored in hPrintNum5
	ld a, [hPrintNum + 4]
	and a
	jr nz, .check_money

	; just print a zero if we're in zero-mode
	bit PRINTNUM_LEADINGZEROS_F, b
	jr nz, .check_money

	; if we're left-aligning the number, don't print anything
	bit PRINTNUM_LEFTALIGN_F, b
	ret nz

	; print a space
	ld a, b
	and $f
	dec a
	jr z, .check_money
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
; Allows 2 to 7 digits. For 1-digit numbers, add
; the value to char "0" instead of calling PrintNum.
; Some extra flags can be given in bits 5-7 of b.
; Bit 5: money if set (unless left-aligned without leading zeros)
; Bit 6: right-aligned if set
; Bit 7: print leading zeros if set

	push bc

	bit PRINTNUM_LEADINGZEROS_F, b
	jr z, .main
	res PRINTNUM_LEFTALIGN_F, b

.main
	; Zerofill printnum data
	push hl
	ld hl, hPrintNum
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl

	; Initialize registers, reading from de bytes, or 0 if unused.
	push bc
	push de
	push hl
	ld a, b
	and $1f
	ld b, a
	cp 4
	call GetDEValue
	ld l, c
	cp 3
	call GetDEValue
	ld h, c
	cp 2
	call GetDEValue
	push bc
	cp 1
	call GetDEValue
	ld a, c
	pop bc
	ld b, a
	ld e, l
	ld d, h
	ld a, 32
	ld [hPrintNum + 4], a

.loop
	ld hl, hPrintNum + 3
	sla b
	rl c
	rl d
	rl e
rept 4
	ld a, [hl]
	adc a
	daa
	ld [hld], a
endr
	ld a, [hPrintNum + 4]
	dec a
	ld [hPrintNum + 4], a
	jr nz, .loop
	pop hl
	pop de
	pop bc

	; At this point, hPrintNum+0 to +3 has zerofilled BCD-format numbers.
	; Figure out the size of the number.
	ld a, b
	and $e0
	add 8
	ld b, a
	ld de, hPrintNum
.loop2
	ld a, [de]
	call PrintHLNum
	dec b
	ld a, b
	and $7
	jr nz, .loop2
	pop bc
	ret
