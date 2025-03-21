GetSRAMBank::
; load sram bank a
; if invalid bank, sram is disabled
	cp NUM_SRAM_BANKS
	jr nc, CloseSRAM

	; switch to sram bank a
	push af

	; latch clock data
	ld a, 1
	ld [MBC3LatchClock], a

	; enable sram/clock write
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a

	; verify integrity of sram
	; if wSRAMAccessCount != sSRAMAccessCount + 1,
	; crash the game
	ld a, BANK(sSRAMAccessCount)
	ld [MBC3SRamBank], a
	push hl
	ld hl, sSRAMAccessCount
	inc [hl]
	ld a, [wSRAMAccessCount]
	cp [hl]
	pop hl
	jr nz, .crash
	inc a
	ld [wSRAMAccessCount], a

	; select sram bank
	pop af
	ld [MBC3SRamBank], a
	ret

.crash
	pop af
	call CloseSRAM
	ld a, ERR_CORRUPTED_SAVESTATE
	di
	jmp Crash

CloseSRAM::
	push af
	ld a, SRAM_DISABLE
; reset clock latch for next time
	ld [MBC3LatchClock], a
; disable sram/clock write
	ld [MBC3SRamEnable], a
	pop af
	ret
