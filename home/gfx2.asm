HBlankCopy2bpp::
	di
	ld [hSPBuffer], sp
	ld hl, hRequestedVTileDest
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a ; destination

	ld a, [hli] ; source
	ld h, [hl]
	ld l, a
	ld sp, hl ; set source to sp
	ld a, h ; save source high byte for later
	ld h, d ; exchange hl and de
	ld l, e
; vram to vram copy check:
	cp HIGH(vTiles0) ; is source in RAM?
	jr c, .innerLoop
	cp HIGH(SRAM_Begin) ; is source past VRAM
	jr nc, .innerLoop
	jmp VRAMToVRAMCopy
.outerLoop
	ldh a, [rLY]
	cp $88
	jmp nc, ContinueHBlankCopy
.innerLoop
	pop bc
	pop de
.waitNoHBlank
	ldh a, [rSTAT]
	and 3
	jr z, .waitNoHBlank
.waitHBlank
	ldh a, [rSTAT]
	and 3
	jr nz, .waitHBlank
; preloads r us
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
rept 6
	pop de
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
endr
	ldh a, [hTilesPerCycle]
	dec a
	ldh [hTilesPerCycle], a
	jr nz, .outerLoop
	jmp DoneHBlankCopy
