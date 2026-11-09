; The tilemap (32 * 28 * 2 = $700 bytes) is decompressed to wTilemap,
; and the palettes (32 colors = $40 bytes) are copied to wTilemap + $80 tiles.
; The tilemap spans the sections "Tilemap and Attrmap", "Misc 404", and part of
; "Misc 1300", and the palettes span more of "Misc 1300".
; This is harmless because WRAM0 was cleared before and after the SGB border is
; initialized, and any emulator which calls this will reset the game in CGB mode
; anyway. We only have to avoid writing to important WRAM -- sections "Stack",
; "ROM Checksum", and anything else that `_Init` uses before this.
; We could also leave the tilemap uncompressed in ROM, but it would spend
; 1480 more bytes.

InitSGBBorder::
	ldh a, [hCGB]
	and a
	ret nz

	ld hl, SGBBorderGFX
	ld a, BANK(SGBBorderGFX)
	call FarDecompress

	ld hl, SGBBorderMap
	ld a, BANK(SGBBorderMap)
	ld de, wTilemap
	call FarDecompressToDE

	ld hl, SGBBorderPals
	ld de, wTilemap + $80 tiles
	ld bc, 32 colors
	rst CopyBytes

	di
	ld hl, MaskEnFreezePacket
	call SendSGBPacket
	ei

	ld de, ChrTrnPacket
	ld hl, wDecompressScratch
	call CopyGfxToSuperNintendoVRAM

	ld de, PctTrnPacket
	ld hl, wTilemap
	call CopyGfxToSuperNintendoVRAM

	ld hl, vTiles0
	ld bc, STARTOF(VRAM) + SIZEOF(VRAM) - vTiles0
	xor a
	rst ByteFill

	ld hl, MaskEnCancelPacket
	call SendSGBPacket

	xor a
	ld hl, wTilemap
	ld bc, 32 * 28 * 2
	rst ByteFill
	ret

SendSGBPacket:
	ld a, [hl]
	and $7
	ret z
	ld b, a
.loop2
	push bc
	ld a, 1
	ld [wInputFlags], a
	xor a ; JOYP_SGB_START
	ldh [rJOYP], a
	ld a, JOYP_SGB_FINISH
	ldh [rJOYP], a
	ld b, JOYP_SGB_ONE
.nextByte
	ld e, 8
	ld a, [hli]
	ld d, a
.nextBit0
	bit 0, d
	ld a, JOYP_SGB_ONE
	jr nz, .next0
	ld a, JOYP_SGB_ZERO
.next0
	ldh [rJOYP], a
	ld a, JOYP_SGB_FINISH
	ldh [rJOYP], a
	rr d
	dec e
	jr nz, .nextBit0
	dec b
	jr nz, .nextByte
	ld a, JOYP_SGB_ZERO
	ldh [rJOYP], a
	ld a, JOYP_SGB_FINISH
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
	ld a, BGP_SGB_TRANSFER
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
	ld de, TILEMAP_WIDTH - SCREEN_WIDTH
	ld a, $80
	ld c, 13
.loop
	ld b, SCREEN_WIDTH
.innerLoop
	ld [hli], a
	inc a
	dec b
	jr nz, .innerLoop
	add hl, de
	dec c
	jr nz, .loop
	ld a, LCDC_DEFAULT
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

SGBBorderPals:
INCLUDE "gfx/sgb/sgb_border.pal"
