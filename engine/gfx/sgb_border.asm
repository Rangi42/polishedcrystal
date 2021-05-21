SGBBorderMap:
INCBIN "gfx/sgb/sgb_border.bin"

InitSGBBorder::
	ldh a, [hCGB]
	and a
	ret nz

	ld hl, SGBBorderGFX
	ld a, BANK(SGBBorderGFX)
	call FarDecompress

	di
	ld hl, MaskEnFreezePacket
	call SendSGBPacket
	ei

	ld de, ChrTrnPacket
	ld hl, wDecompressScratch
	call CopyGfxToSuperNintendoVRAM

	ld de, PctTrnPacket
	ld hl, SGBBorderMap
	call CopyGfxToSuperNintendoVRAM

	ld hl, vTiles0
	ld bc, VRAM_End - vTiles0
	xor a
	rst ByteFill

	ld hl, MaskEnCancelPacket
	; fallthrough

SendSGBPacket:
	ld a, [hl]
	and $7
	ret z
	ld b, a
.loop2
	push bc
	ld a, 1
	ld [wInputFlags], a
	xor a
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	ld b, $10
.nextByte
	ld e, $8
	ld a, [hli]
	ld d, a
.nextBit0
	bit 0, d
	ld a, $10
	jr nz, .next0
	ld a, $20
.next0
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	rr d
	dec e
	jr nz, .nextBit0
	dec b
	jr nz, .nextByte
	ld a, $20
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	xor a
	ld [wInputFlags], a
	call SGBDelayCycles
	pop bc
	dec b
	ret z
	jr .loop2

SGBDelayCycles:
	ld de, 28000
.wait
	nop ; no-optimize nops
	nop ; no-optimize nops
	nop ; no-optimize nops
	dec de
	ld a, d
	or e
	jr nz, .wait
	ret

CopyGfxToSuperNintendoVRAM:
	di
	push de
	call DisableLCD
	ld a, $e4
	ldh [rBGP], a
	ld de, vTiles1
	ld bc, $1000
.copyData
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .copyData
	ld hl, vBGMap0
	ld de, $c
	ld a, $80
	ld c, $d
.loop
	ld b, $14
.innerLoop
	ld [hli], a
	inc a
	dec b
	jr nz, .innerLoop
	add hl, de
	dec c
	jr nz, .loop
	ld a, $e3
	ldh [rLCDC], a ; enables LCD
	pop hl
	call SendSGBPacket
	xor a
	ldh [rBGP], a
	reti

MaskEnFreezePacket:
	db $b9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
MaskEnCancelPacket:
	db $b9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

ChrTrnPacket:
	db $99, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PctTrnPacket:
	db $a1, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

	ds 9

SGBBorderPals:
INCLUDE "gfx/sgb/sgb_border.pal"

	assert SGBBorderMap + $80 tiles == SGBBorderPals
