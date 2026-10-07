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
	ld [wSPBuffer], sp

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

	ld sp, wSPBuffer
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
	assert NO_BG_MAP_TRANSFER == 0
	ldh [hBGMapMode], a
	ret

DEF HALF_HEIGHT EQU SCREEN_HEIGHT / 2

UpdateBGMap::
; Update the BG Map, in halves, from wTilemap and wAttrmap.

	ldh a, [hBGMapMode]
	and a
	ret z

	dec a
_UpdateBGMap::
	ldh [rVBK], a ; Load the appropriate VRAM bank (only bit 0 gets used).
	ld [wSPBuffer], sp ; Since we're about to use the stack as the copy source, save it for restoring later.
	ld sp, wTilemap
	rra ; Bit 0 (now in carry) encodes which bank to use.
	jr nc, :+
	ld sp, wAttrmap
:
	rra ; Bit 1 (now in carry) encodes whether to use `hBGMapAddress` or vBGMap1.
	ld hl, vBGMap1
	jr c, :+
	ldh a, [hBGMapAddress]
	ld l, a
	ldh a, [hBGMapAddress + 1]
	ld h, a
:

	ldh a, [hBGMapHalf]
	xor 1
	jr nz, :+
	; Bottom half!
	add sp, 127 :: add sp, HALF_HEIGHT * SCREEN_WIDTH - 127 ; Source.
	ld de, HALF_HEIGHT * TILEMAP_WIDTH :: add hl, de ; Destination.
:
	ldh [hBGMapHalf], a

	ld a, HALF_HEIGHT

_CopyTilemapRows:
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

	ld sp, wSPBuffer
	pop hl
	ld sp, hl

	; Keep VRA0 loaded for the rest of the game, in case we just copied attributes.
	xor a
	ldh [rVBK], a
	ret

CopyTop3MapRows:: ; Called from `CopyTilemapAtOnce`.
	ld [wSPBuffer], sp
	; Load the destination address, which is always at the top of the map.
	ld sp, hBGMapAddress
	pop de
	; Load the source address...
	ld sp, hl
	; Transfer the destination to `hl`.
	ld l, e
	ld h, d
	; The number of rows to be copied. For why 3, see this function's caller.
	ld a, 3
	jr _CopyTilemapRows

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
	ld [wSPBuffer], sp
	ld sp, hRequestedVTileDest
	pop de ; de = [hRequestedVTileDest]
	assert hRequestedVTileDest + 2 == hRequestedVTileSource
	pop hl ; hl = [hRequestedVTileSource]
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

	ld sp, wSPBuffer
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
	ld [wSPBuffer], sp
	ld sp, hRequestedVTileDest
	pop de ; de = [hRequestedVTileDest]
	assert hRequestedVTileDest + 2 == hRequestedVTileSource
	pop hl ; hl = [hRequestedVTileSource]
	ld sp, hl
	ld h, d
	ld l, e

	ldh a, [hRequestOpaque1bpp]
	dec a
	jr z, .nextopaque

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
	jr WriteVTileSourceAndDestinationAndReturn

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

	ldh a, [rVBK]
	rra ; stores VRAM bank in carry flag to be pushed
	ldh a, [rWBK]
	push af

	ld a, BANK(wTilesetAnim)
	ldh [rWBK], a

	ld a, BANK(_AnimateTileset)
	rst Bankswitch
	call _AnimateTileset ; far-ok

	pop af
	ldh [rWBK], a
	rla ; retrieves VRAM bank from popped carry flag
	ldh [rVBK], a
	ret
