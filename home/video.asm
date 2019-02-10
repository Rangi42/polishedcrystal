; Functions dealing with VRAM.

PushOAM::
	ld a, [hOAMUpdate]
	and a
	ret nz
ForcePushOAM:
	lb bc, 40 + 1, rDMA & $ff
	ld a, wSprites >> 8
	jp hPushOAM

DMATransfer:: ; 15d8
; Return carry if the transfer is completed.

	ld a, [hDMATransfer]
	and a
	ret z

; Start transfer
	ld [rHDMA5], a

; Execution is halted until the transfer is complete.

	xor a
	ld [hDMATransfer], a
	scf
	ret
; 15e3


UpdateBGMapBuffer:: ; 15e3
; Copy [hBGMapTileCount] 16x8 tiles from wBGMapBuffer
; to bg map addresses in wBGMapBufferPtrs.

; [hBGMapTileCount] must be even since this is done in pairs.

; Return carry on success.

	ld a, [hBGMapUpdate]
	and a
	ret z

	ld a, [rVBK]
	push af
	ld [hSPBuffer], sp

	ld hl, wBGMapBufferPtrs
	ld sp, hl

; We can now pop the addresses of affected spots on the BG Map

	ld hl, wBGMapPalBuffer
	ld de, wBGMapBuffer


.next
; Copy a pair of 16x8 blocks (one 16x16 block)

rept 2
; Get our BG Map address
	pop bc

; Palettes
	ld a, 1
	ld [rVBK], a

	ld a, [hli]
	ld [bc], a
	inc c
	ld a, [hli]
	ld [bc], a
	dec c

; Tiles
	xor a
	ld [rVBK], a

	ld a, [de]
	inc de
	ld [bc], a
	inc c
	ld a, [de]
	inc de
	ld [bc], a
endr

; We've done 2 16x8 blocks
	ld a, [hBGMapTileCount]
	dec a
	dec a
	ld [hBGMapTileCount], a

	jr nz, .next


	ld sp, hSPBuffer
	pop hl
	ld sp, hl

	pop af
	ld [rVBK], a

	xor a
	ld [hBGMapUpdate], a
	scf
	ret
; 163a


WaitTop::
; Wait until the top half of the BG Map is being updated.

	ld a, [hBGMapMode]
	and a
	jr nz, .handleLoop
	ret
.loop
	call DelayFrame
.handleLoop
	ld a, [hBGMapHalf]
	and a
	jr nz, .loop

	xor a
	ld [hBGMapMode], a
	ret

HALF_HEIGHT EQU SCREEN_HEIGHT / 2

UpdateBGMap:: ; 164c
; Update the BG Map, in halves, from wTileMap and wAttrMap.

	ld a, [hBGMapMode]
	and $7f
	ret z

; BG Map 0
	dec a ; 1
	jr z, .DoTiles
	dec a ; 2
	jr z, .DoAttributes

; BG Map 1
	ld hl, VBGMap1
	dec a
	jr z, .DoBGMap1Tiles
	dec a
	jr z, .DoBGMap1Attributes
; Update from a specific row
; does not update hBGMapHalf
	dec a
	coord bc, 0, 0
	jr z, .DoCustomSourceTiles
	dec a
	ret nz
	coord bc, 0, 0, wAttrMap
	ld a, 1
	ld [rVBK], a
	call .DoCustomSourceTiles
	xor a
	ld [rVBK], a
	ret

.DoCustomSourceTiles
	ld [hSPBuffer], sp
	xor a
	ld h, a
	ld d, a
	ld a, [hBGMapHalf] ; multiply by 20 to get the tilemap offset
	ld l, a
	ld e, a
	add hl, hl ; hl = hl * 2
	add hl, hl ; hl = hl * 4
	add hl, de ; hl = (hl*4) + de
	add hl, hl ; hl = (5*hl)*2
	add hl, hl ; hl = (5*hl)*4
	add hl, bc
	ld sp, hl
	ld a, [hBGMapHalf] ; multiply by 32 to get the bg map offset
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld a, [hBGMapAddress]
	add l
	ld l, a
	ld a, [hBGMapAddress + 1]
	adc h
	ld h, a
	ld a, [hTilesPerCycle]
	jr .startCustomCopy

.DoAttributes
	ld a, [hBGMapAddress + 1]
	ld h, a
	ld a, [hBGMapAddress]
	ld l, a
.DoBGMap1Attributes
	ld a, 1
	ld [rVBK], a
	call .CopyAttributes
	xor a
	ld [rVBK], a
	ret

.CopyAttributes
	ld [hSPBuffer], sp

; Which half?
	ld a, [hBGMapHalf]
	and a ; 0
	jr z, .AttributeMapTop
; bottom row
	coord sp, 0, 9, wAttrMap
	ld de, HALF_HEIGHT * BG_MAP_WIDTH
	add hl, de
; Next time: top half
	xor a
	jr .startCopy
.AttributeMapTop
	coord sp, 0, 0, wAttrMap
; Next time: bottom half
	jr .AttributeMapTopContinue

.DoTiles
	ld a, [hBGMapAddress + 1]
	ld h, a
	ld a, [hBGMapAddress]
	ld l, a

.DoBGMap1Tiles
	ld [hSPBuffer], sp
; Which half?
	ld a, [hBGMapHalf]
	and a ; 0
	jr z, .TileMapTop
; bottom row
	coord sp, 0, 9
	ld de, HALF_HEIGHT * BG_MAP_WIDTH
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
	ld [hBGMapHalf], a
; Rows of tiles in a half
	ld a, SCREEN_HEIGHT / 2
.startCustomCopy
; Discrepancy between wTileMap and BGMap
	ld bc, BG_MAP_WIDTH - (SCREEN_WIDTH - 1)
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

	ld a, [hSPBuffer]
	ld l, a
	ld a, [hSPBuffer + 1]
	ld h, a
	ld sp, hl
	ret

Serve1bppRequest:: ; 170a
; Only call during the first fifth of VBlank

	ld a, [hRequested1bpp]
	and a
	ret z

	ld b, a
; Back out if we're too far into VBlank
	ld a, [rLY]
	cp 144
	ret c
	cp 146
	ret nc

	xor a
	ld [hRequested1bpp], a

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
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld sp, hl
	ld h, d
	ld l, e
	ld a, [hRequestOpaque1bpp]
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
	jp WriteVTileSourceAndDestinationAndReturn
.nextopaque
	rept 4
	pop de
	ld a, e
	ld [hl], $ff
	inc hl
	ld [hli], a
	ld a, d
	ld [hl], $ff
	inc hl
	ld [hli], a
	endr
	dec b
	jr nz, .nextopaque
	jp WriteVTileSourceAndDestinationAndReturn

LYOverrideStackCopy::
	ld a, [hLYOverrideStackCopyAmount]
	and a
	ret z
	ld b, a
	xor a
	ld [hLYOverrideStackCopyAmount], a
	jr _Serve2bppRequest

Serve2bppRequest::
; Only call during the first fifth of VBlank

	ld a, [hRequested2bpp]
	and a
	ret z

	ld b, a ; save tile count for later

; Back out if we're too far into VBlank
	ld a, [rLY]
	cp 144
	ret c
	cp 146
	ret nc

	xor a
	ld [hRequested2bpp], a

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
	ld a, [hli]
	ld h, [hl]
	ld l, a
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

	ld a, [hSPBuffer]
	ld l, a
	ld a, [hSPBuffer + 1]
	ld h, a
	ld sp, hl
	ret

AnimateTileset::
; Only call during the first fifth of VBlank
	ld a, [hMapAnims]
	and a
	ret z

; Back out if we're too far into VBlank
	ld a, [rLY]
	cp 144
	ret c
	cp 151
	ret nc

	ld a, [rSVBK]
	push af

	ld a, [rVBK]
	push af
	xor a
	ld [rVBK], a
	inc a
	ld [rSVBK], a

	ld a, BANK(_AnimateTileset)
	call Bankswitch

	call _AnimateTileset

	pop af
	ld [rVBK], a
	pop af
	ld [rSVBK], a
	ret
