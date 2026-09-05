; Walking uses the VRAM BG map as its persistent screen cache. Only the
; entering edge and the walked 2x4 patch need fresh tile/attribute data.
; wTilemap/wAttrmap are not maintained while walking; LoadMapPart rebuilds
; them (map entry, reanchoring for text/menus/battles, or explicit refreshmap).
; Do not use this path for those full-screen consumers.

_LoadMapPartForStep::
	call CheckPlayerCoastSandColl
	ld a, 0 ; no-optimize a = 0 (preserve the coast-sand Z flag)
	jr z, .got_patch
	inc a
.got_patch
	ldh [hStreamMapWalkedPatch], a
	ldh a, [rWBK]
	push af
	ld a, [wMapBorderBlock]
	ldh [hMapBorderBlock], a
	ld a, [wMapWidth]
	add 6
	ldh [hMapWidthPlus6], a
	ld a, BANK(wDecompressedMetatiles)
	ldh [rWBK], a
	ld hl, wBGMapBuffer
	call StreamMapPlane
	ld a, BANK(wDecompressedAttributes)
	ldh [rWBK], a
	ld hl, wBGMapPalBuffer
	call StreamMapPlane
	pop af
	ldh [rWBK], a
	ret

StreamMapPlane:
; Decode straight into the VBlank upload queue. A row has two 20-byte
; scanlines; a column (and the walked patch) has packed 2-byte scanlines.
	push hl
	ldh a, [hStreamMapWalkedPatch]
	and a
	jr z, .edge
	ld de, 8
	add hl, de
.edge
	ldh a, [hPlayerStepDirection]
	and a
	jr z, .down
	dec a
	jr z, .up
	dec a
	jr z, .left
; right
	lb bc, 0, (SCREEN_WIDTH - 2) / 2
	jr .column
.left
	lb bc, 0, 0
.column
	ld a, SCREEN_HEIGHT / 2
	call StreamMapColumn
	jr .walked
.down
	lb bc, (SCREEN_HEIGHT - 2) / 2, 0
	jr .row
.up
	lb bc, 0, 0
.row
	ld a, SCREEN_WIDTH / 2
	call StreamMapRow
.walked
	pop hl
	; Same 2x4 patch as the old ReloadWalkedTile. Coast sand preserves tracks.
	ldh a, [hStreamMapWalkedPatch]
	and a
	ret z
	lb bc, 6 / 2, 8 / 2
	ld a, 4 / 2
	jr StreamMapColumn

StreamMapSetup:
; hl: destination; b,c: screen y,x in 2x2 units; a: number of 2x2s.
; Both decompressed tables start at $d000 in their respective WRAM banks.
	assert wDecompressedMetatiles == wDecompressedAttributes
	assert LOW(wDecompressedMetatiles) == 0
	push af
	push hl
	ldh a, [hMetatileStandingX]
	add c
	ld c, a
	ldh a, [hMetatileStandingY]
	add b
	ld b, a
	; Quarter offset within a 4x4 block: (y & 1) * 8 + (x & 1) * 2.
	and 1
	add a
	add a
	add a
	ld h, a
	ld a, c
	and 1
	add a
	or h
	push af
	ldh a, [hOverworldMapAnchor]
	ld l, a
	ldh a, [hOverworldMapAnchor + 1]
	ld h, a
	srl c
	ld e, c
	ld d, 0
	add hl, de
	srl b
	jr z, .got_block
	ldh a, [hMapWidthPlus6]
	ld e, a
.block_row
	add hl, de
	dec b
	jr nz, .block_row
.got_block
	ld d, h
	ld e, l
	pop af
	ld c, a
	pop hl
	pop af
	ld b, a
	ret

MACRO stream_map_quarters
	assert "\1" === "row" || "\1" === "column"
.quarter
	ld a, [de]
	and a
	jr nz, .not_border
	ldh a, [hMapBorderBlock]
.not_border
	push de
	swap a
	ld d, a
	and $f0
	or c
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	ld a, [de]
	inc e
	ld [hli], a
	ld a, [de]
	inc e
	inc e
	inc e
	ld [hl], a
if "\1" === "column"
	inc hl ; packed column: second scanline immediately follows the first
else
	ld a, SCREEN_WIDTH - 1
	add l
	ld l, a
	adc h
	sub l
	ld h, a
endc
	ld a, [de]
	inc e
	ld [hli], a
	ld a, [de]
	ld [hl], a
	pop de
if "\1" === "column" ; column: advance two packed rows and select the next vertical quarter
	inc hl
	ld a, c
	xor 8
	ld c, a
	and 8
	jr nz, .same_block
	ldh a, [hMapWidthPlus6]
	add e
	ld e, a
	adc d
	sub e
	ld d, a
else ; row: advance two columns and select the next horizontal quarter
	ld a, l
	sub SCREEN_WIDTH - 1
	ld l, a
	jr nc, .same_page
	dec h
.same_page
	ld a, c
	xor 2
	ld c, a
	and 2
	jr nz, .same_block
	inc de
endc
.same_block
	dec b
	jr nz, .quarter
	ret
ENDM

StreamMapRow:
	call StreamMapSetup
	stream_map_quarters row

StreamMapColumn:
	call StreamMapSetup
	stream_map_quarters column
