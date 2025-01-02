CheckEventChecksumRecalculate:
	ld hl, wEventChecksumFlags
	bit EVENT_CHECKSUM_FULL_DONE_F, [hl]
	ret nz
; fallthrough
RecalculateEventChecksum::
	ld hl, wEventChecksumFlags
	res EVENT_CHECKSUM_VBLANK_ROUTINE_RUNNING_F, [hl]
	res EVENT_CHECKSUM_FULL_DONE_F, [hl]
	call CalculateEventChecksum
	ld [wEventChecksum], a
	call ResetVBlankEventChecksum
	ld hl, wEventChecksumFlags
	set EVENT_CHECKSUM_VBLANK_ROUTINE_RUNNING_F, [hl]
	set EVENT_CHECKSUM_FULL_DONE_F, [hl]
	ret

CalculateEventChecksum:
	push hl
	push de
	push bc
	ld hl, wEventFlags
	ld bc, wEventFlagsEnd - wEventFlags
	xor a
	ld d, a
.loop
	ld a, [hli]
	add d
	ld d, a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ld a, d
	jmp PopBCDEHL

VBlankEventChecksum:
	push hl
	push de
	push bc

	ldh a, [rSVBK]
	push af
	ld a, BANK(wEventChecksumFlags)
	ld [rSVBK], a

	ld hl, wEventChecksumFlags
	bit EVENT_CHECKSUM_VBLANK_ROUTINE_RUNNING_F, [hl]
	jr z, .done

	ld hl, wEventChecksumCurAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	call z, ResetVBlankEventChecksum ; If the address is 0, reset the routine

	ld a, [wEventChecksumCurSummation]
	ld b, a
	ld a, [hli]
	add b
	ld c, a

	ld a, h
	cp HIGH(wEventFlagsEnd)
	jr nz, .store_done
	ld a, l
	cp LOW(wEventFlagsEnd)
	jr nz, .store_done
	ld a, [wEventChecksum]
	cp c
	jr nz, .error_checksum
	ld hl, wEventFlags
	ld c, 0
.store_done
	ld a, l
	ld [wEventChecksumCurAddress], a
	ld a, h
	ld [wEventChecksumCurAddress + 1], a
	ld a, c
	ld [wEventChecksumCurSummation], a

.done
	pop af
	ld [rSVBK], a
	jmp PopBCDEHL

.error_checksum
	ld hl, wEventChecksumFlags
	res EVENT_CHECKSUM_VBLANK_ROUTINE_RUNNING_F, [hl]
	pop af
	ld [rSVBK], a
	pop bc
	pop de
	pop hl
	ld a, ERR_CHECKSUM_MISMATCH
	jmp Crash

ResetVBlankEventChecksum:
	push hl
	ld a, LOW(wEventFlags)
	ld [wEventChecksumCurAddress], a
	ld a, HIGH(wEventFlags)
	ld [wEventChecksumCurAddress + 1], a
	xor a
	ld [wEventChecksumCurSummation], a
	pop hl
	ret
