; Functions dealing with VRAM.

PushOAM::
	ldh a, [hOAMUpdate]
	and a
	ret nz
ForcePushOAM:
	lb bc, 40 + 1, LOW(rDMA)
	ld a, HIGH(wShadowOAM)
	jmp hPushOAM

ContinueGDMACopy:
	push hl
	ld hl, rVDMA_DEST_HIGH
	jr _GDMACopy
GDMACopy:
; Copy a+1 tiles from de to bc. Preserves all registers. Assumes GDMA is valid.
	push hl
	ld hl, rVDMA_SRC_HIGH
	ld [hl], d ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], e ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
_GDMACopy:
	ld [hl], b ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], c
	ldh [rVDMA_LEN], a
	pop hl
	ret

DMATransfer::
; Return carry if the transfer is completed.

	ldh a, [hDMATransfer]
	and a
	ret z

; Start transfer
	ldh [rVDMA_LEN], a

; Execution is halted until the transfer is complete.

	xor a
	ldh [hDMATransfer], a
	scf
	ret

UpdateBGMapBuffer::
; Copy [hBGMapTileCount] 16x8 tiles from wBGMapBuffer
; to bg map addresses in wBGMapBufferPtrs.

; [hBGMapTileCount] must be even since this is done in pairs.

; Return carry on success.

	ldh a, [hBGMapUpdate]
	and a
	ret z

	ldh a, [rVBK]
	push af
	ld [hSPBuffer], sp

	ld hl, wBGMapBufferPtrs
	ld sp, hl

; We can now pop the addresses of affected spots on the BG Map

	ld bc, wBGMapPalBuffer
	ld de, wBGMapBuffer

; We increment the low byte of a pointer, so ensure these buffers
; dont cross a 256 byte boundary
assert HIGH(wBGMapBuffer) == HIGH(wBGMapBufferEnd)
assert HIGH(wBGMapPalBuffer) == HIGH(wBGMapPalBufferEnd)

.next
; Copy a pair of 16x8 blocks (one 16x16 block)

rept 2
; Get our BG Map address
	pop hl

; Palettes
	ld a, 1
	ldh [rVBK], a

	ld a, [bc]
	ld [hli], a
	inc c
	ld a, [bc]
	ld [hld], a
	inc c

; Tiles
	xor a
	ldh [rVBK], a

	ld a, [de]
	ld [hli], a
	inc e
	ld a, [de]
	ld [hl], a
	inc e
endr

; We've done 2 16x8 blocks
	ldh a, [hBGMapTileCount]
	dec a
	dec a
	ldh [hBGMapTileCount], a

	jr nz, .next

	ld sp, hSPBuffer
	pop hl
	ld sp, hl

	pop af
	ldh [rVBK], a

	xor a
	ldh [hBGMapUpdate], a
	scf
	ret

WaitTop::
; Wait until the top half of the BG Map is being updated.

	ldh a, [hBGMapMode]
	and a
	jr nz, .handleLoop
	ret
.loop
	call DelayFrame
.handleLoop
	ldh a, [hBGMapHalf]
	and a
	jr nz, .loop

	xor a
	ldh [hBGMapMode], a
	ret

DEF HALF_HEIGHT EQU SCREEN_HEIGHT / 2

UpdateBGMap::
; Update the BG Map, in halves, from wTilemap and wAttrmap.

	ldh a, [hBGMapMode]
	and $7f
	ret z

; BG Map 0
	dec a ; 1
	jr z, .DoTiles
	dec a ; 2
	jr z, .DoAttributes

; BG Map 1
	ld hl, vBGMap1
	dec a
	jr z, .DoBGMap1Tiles
	dec a
	jr z, .DoBGMap1Attributes
; Update from a specific row
; does not update hBGMapHalf
	dec a
	bccoord 0, 0
	jr z, .DoCustomSourceTiles
	dec a
	ret nz
	bccoord 0, 0, wAttrmap
	ld a, 1
	ldh [rVBK], a
	call .DoCustomSourceTiles
	xor a
	ldh [rVBK], a
	ret

.DoCustomSourceTiles
	ld [hSPBuffer], sp
	xor a
	ld h, a
	ld d, a
	ldh a, [hBGMapHalf] ; multiply by 20 to get the tilemap offset
	ld l, a
	ld e, a
	add hl, hl ; hl = hl * 2
	add hl, hl ; hl = hl * 4
	add hl, de ; hl = (hl*4) + de
	add hl, hl ; hl = (5*hl)*2
	add hl, hl ; hl = (5*hl)*4
	add hl, bc
	ld sp, hl
	ldh a, [hBGMapHalf] ; multiply by 32 to get the bg map offset
	; assumes [hBGMapHalf] < 16
	swap a
	add a
	ld l, a
	ld h, 0
	ldh a, [hBGMapAddress]
	add l
	ld l, a
	ldh a, [hBGMapAddress + 1]
	adc h
	ld h, a
	ldh a, [hTilesPerCycle]
	jr .startCustomCopy

.DoAttributes
	ldh a, [hBGMapAddress + 1]
	ld h, a
	ldh a, [hBGMapAddress]
	ld l, a
.DoBGMap1Attributes
	ld a, 1
	ldh [rVBK], a
	call .CopyAttributes
	xor a
	ldh [rVBK], a
	ret

.CopyAttributes
	ld [hSPBuffer], sp

; Which half?
	ldh a, [hBGMapHalf]
	and a ; 0
	jr z, .AttributeMapTop
; bottom row
	coord sp, 0, 9, wAttrmap
	ld de, HALF_HEIGHT * TILEMAP_WIDTH
	add hl, de
; Next time: top half
	xor a
	jr .startCopy
.AttributeMapTop
	coord sp, 0, 0, wAttrmap
; Next time: bottom half
	jr .AttributeMapTopContinue

.DoTiles
	ldh a, [hBGMapAddress + 1]
	ld h, a
	ldh a, [hBGMapAddress]
	ld l, a

.DoBGMap1Tiles
	ld [hSPBuffer], sp
; Which half?
	ldh a, [hBGMapHalf]
	and a ; 0
	jr z, .TileMapTop
; bottom row
	coord sp, 0, 9
	ld de, HALF_HEIGHT * TILEMAP_WIDTH
	add hl, de
; Next time: top half
	xor a
	jr .startCopy
.TileMapTop
	coord sp, 0, 0
; Next time: bottom half
.AttributeMapTopContinue
	inc a
.startCopy
; Which half to update next time
	ldh [hBGMapHalf], a
; Rows of tiles in a half
	ld a, SCREEN_HEIGHT / 2
.startCustomCopy
; Discrepancy between wTilemap and BGMap
	ld bc, TILEMAP_WIDTH - (SCREEN_WIDTH - 1)
.row
; Copy a row of 20 tiles
rept (SCREEN_WIDTH / 2) - 1
	pop de
	ld [hl], e
	inc l
	ld [hl], d
	inc l
endr
	pop de
	ld [hl], e
	inc l
	ld [hl], d

	add hl, bc
	dec a
	jr nz, .row

	ld sp, hSPBuffer
	pop hl
	ld sp, hl
	ret

Serve1bppRequest::
; Only call during the first fifth of VBlank

	ldh a, [hRequested1bpp]
	and a
	ret z

	ld b, a
; Back out if we're too far into VBlank
	ldh a, [rLY]
	cp 144
	ret c
	cp 146
	ret nc

	xor a
	ldh [hRequested1bpp], a

_Serve1bppRequest::
; Copy [hRequested1bpp] 1bpp tiles from [hRequestedVTileSource] to [hRequestedVTileDest]
	ld [hSPBuffer], sp
; Destination
	ld hl, hRequestedVTileDest
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
; Source
	ld sp, hl
	pop hl
	ld sp, hl
	ld h, d
	ld l, e
	ldh a, [hRequestOpaque1bpp]
	dec a
	jr z, .nextopaque

; # tiles to copy
.next
rept 4
	pop de
	ld a, e
	ld [hli], a
	ld [hli], a
	ld a, d
	ld [hli], a
	ld [hli], a
endr
	dec b
	jr nz, .next
	jmp WriteVTileSourceAndDestinationAndReturn

.nextopaque
rept 4
	pop de
	ld a, $ff
	ld [hli], a
	ld a, e
	ld [hli], a
	ld a, $ff
	ld [hli], a
	ld a, d
	ld [hli], a
endr
	dec b
	jr nz, .nextopaque
	jr WriteVTileSourceAndDestinationAndReturn

LYOverrideStackCopy::
	ldh a, [hLYOverrideStackCopyAmount]
	and a
	ret z
	ld b, a
	xor a
	ldh [hLYOverrideStackCopyAmount], a
	jr _Serve2bppRequest

Serve2bppRequest::
; Only call during the first fifth of VBlank

	ldh a, [hRequested2bpp]
	and a
	ret z

	ld b, a ; save tile count for later

; Back out if we're too far into VBlank
	ldh a, [rLY]
	cp 144
	ret c
	cp 146
	ret nc

	xor a
	ldh [hRequested2bpp], a

_Serve2bppRequest::
; Copy [hRequested2bpp] 2bpp tiles from [hRequestedVTileSource] to [hRequestedVTileDest]

	ld [hSPBuffer], sp
; Destination
	ld hl, hRequestedVTileDest
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
; Source
	ld sp, hl
	pop hl
	ld sp, hl
	ld h, d
	ld l, e

.next
rept 8
	pop de
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
endr
	dec b
	jr nz, .next

WriteVTileSourceAndDestinationAndReturn:
	ld [hRequestedVTileSource], sp
	ld sp, hl
	ld [hRequestedVTileDest], sp

	ld sp, hSPBuffer
	pop hl
	ld sp, hl
	ret

AnimateTileset::
; Only call during the first fifth of VBlank
	ldh a, [hMapAnims]
	and a
	ret z

;; Back out if we're too far into VBlank
;	ldh a, [rLY]
;	cp 144
;	ret c
;	cp 151
;	ret nc

	ldh a, [rWBK]
	push af

	ldh a, [rVBK]
	push af
	xor a
	ldh [rVBK], a
	inc a
	ldh [rWBK], a

	ld a, BANK(_AnimateTileset)
	rst Bankswitch

	call _AnimateTileset ; far-ok

	pop af
	ldh [rVBK], a
	pop af
	ldh [rWBK], a
	ret
