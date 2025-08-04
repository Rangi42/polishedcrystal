HDMATransferTileMapToWRAMBank3::
	call StackCallInSafeGFXMode

.Function:
	decoord 0, 0
	ld hl, wScratchTileMap
	call CutAndPasteTilemap
	xor a
	ldh [rVBK], a
	ld hl, wScratchTileMap
	jr HDMATransferToWRAMBank3

HDMATransferAttrMapToWRAMBank3:
	call StackCallInSafeGFXMode

.Function:
	decoord 0, 0, wAttrmap
	ld hl, wScratchAttrMap
	call CutAndPasteAttrMap
	ld a, $1
	ldh [rVBK], a
	ld hl, wScratchAttrMap
	jr HDMATransferToWRAMBank3

ReloadMapPart::
	call StackCallInSafeGFXMode

.Function:
	decoord 0, 0, wAttrmap
	ld hl, wScratchAttrMap
	call CutAndPasteAttrMap
	decoord 0, 0
	ld hl, wScratchTileMap
	call CutAndPasteTilemap

	di
	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a
	ld hl, wScratchAttrMap
	call DoHBlankHDMATransfer_toBGMap
	xor a
	ldh [rVBK], a
	ld hl, wScratchTileMap
	call DoHBlankHDMATransfer_toBGMap
	pop af
	ldh [rVBK], a
	reti

HDMATransferToWRAMBank3:
	ld a, h
	ldh [rVDMA_SRC_HIGH], a
	ld a, l
	ldh [rVDMA_SRC_LOW], a
	ldh a, [hBGMapAddress + 1]
	and $1f
	ldh [rVDMA_DEST_HIGH], a
	ldh a, [hBGMapAddress]
	ldh [rVDMA_DEST_LOW], a
	ld a, $23
	ldh [hDMATransfer], a
	jr .handleLoop
.loop
	call DelayFrame
.handleLoop
	ldh a, [hDMATransfer]
	and a
	jr nz, .loop
	ret

StackCallInSafeGFXMode:
	pop hl

	ldh a, [hBGMapMode]
	push af
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hBGMapMode], a
	ldh [hMapAnims], a
	ldh a, [rWBK]
	push af
	ld a, BANK(wScratchTileMap)
	ldh [rWBK], a
	ldh a, [rVBK]
	push af

	call _hl_

	pop af
	ldh [rVBK], a
	pop af
	ldh [rWBK], a
	pop af
	ldh [hMapAnims], a
	pop af
	ldh [hBGMapMode], a
	ret

DoHBlankHDMATransfer_toBGMap:
	ldh a, [hBGMapAddress + 1]
	ld d, a
	ldh a, [hBGMapAddress]
	ld e, a
	ld c, $23
	ld a, h
	ldh [rVDMA_SRC_HIGH], a
	ld a, l
	and $f0
	ldh [rVDMA_SRC_LOW], a
	ld a, d
	and $1f
	ldh [rVDMA_DEST_HIGH], a
	ld a, e
	and $f0
	ldh [rVDMA_DEST_LOW], a
	di
	ldh a, [rLY]
	add c ; calculate end LY
	cp $80 ; is the end LY greater than the max LY
	call nc, DI_DelayFrame ; if so, delay a frame to reset the LY
	set 7, c
.waitHBlank
	ldh a, [rSTAT]
	and STAT_MODE
	jr nz, .waitHBlank
	ld hl, rVDMA_LEN
	ld [hl], c
	ld a, $ff
.waitHDMALoop
	cp [hl]
	jr nz, .waitHDMALoop
	reti

DoHBlankHDMATransfer:
	ld b, $7f
; a lot of waiting around for hardware registers
	; [rVDMA_SRC_HIGH, rVDMA_SRC_LOW] = hl & $fff0
	ld a, h
	ldh [rVDMA_SRC_HIGH], a
	ld a, l
	and $f0 ; high nybble
	ldh [rVDMA_SRC_LOW], a
	; [rVDMA_DEST_HIGH, rVDMA_DEST_LOW] = de & $1ff0
	ld a, d
	and $1f ; lower 5 bits
	ldh [rVDMA_DEST_HIGH], a
	ld a, e
	and $f0 ; high nybble
	ldh [rVDMA_DEST_LOW], a
	; e = c | %10000000
	dec c ; c = number of LYs needed
	ld e, c
	set 7, e ; hblank dma transfers
	ldh a, [rLY]
	add c ; calculate end LY
	cp b ; is the end LY greater than the max LY
	call nc, DI_DelayFrame ; if so, delay a frame to reset the LY

	lb bc, STAT_MODE, LOW(rSTAT)
.noHBlankWait
	ldh a, [c]
	and b
	jr z, .noHBlankWait
.hBlankWaitLoop
	ldh a, [c]
	and b
	jr nz, .hBlankWaitLoop
	ld hl, rVDMA_LEN
	ld [hl], e
	ld a, $ff
.waitForHDMA
	cp [hl]
	jr nz, .waitForHDMA
	ret

CutAndPasteTilemap:
	ld c, ' '
	jr CutAndPasteMap

CutAndPasteAttrMap:
	ld c, $0

CutAndPasteMap:
; back up the value of c to hMapObjectIndexBuffer
	ldh a, [hMapObjectIndexBuffer]
	push af
	ld a, c
	ldh [hMapObjectIndexBuffer], a

; for each row on the screen
	ld c, SCREEN_HEIGHT
.loop1
; for each tile in the row
	ld b, SCREEN_WIDTH
.loop2
; copy from de to hl
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop2

; load the original value of c into hl 12 times
	ldh a, [hMapObjectIndexBuffer]
	ld b, 12
.loop3
	ld [hli], a
	dec b
	jr nz, .loop3

	dec c
	jr nz, .loop1

; restore the original value of hMapObjectIndexBuffer
	pop af
	ldh [hMapObjectIndexBuffer], a
	ret

HDMATransfer_OnlyTopFourRows:
	call StackCallInSafeGFXMode

.Function:
	ld hl, wScratchTileMap
	decoord 0, 0
	call .Copy
	ld hl, wScratchTileMap + $80
	decoord 0, 0, wAttrmap
	call .Copy
	di
	ld a, $1
	ldh [rVBK], a
	ld c, $8
	ld hl, wScratchTileMap + $80
	debgcoord 0, 0, vBGMap1
	call DoHBlankHDMATransfer
	xor a
	ldh [rVBK], a
	ld c, $8
	ld hl, wScratchTileMap
	debgcoord 0, 0, vBGMap1
	call DoHBlankHDMATransfer

	reti

.Copy:
	ld b, 4
.outer_loop
	ld c, SCREEN_WIDTH
.inner_loop
	ld a, [de]
	ld [hli], a
	inc de
	dec c
	jr nz, .inner_loop
	ld a, $20 - SCREEN_WIDTH
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	dec b
	jr nz, .outer_loop
	ret

DI_DelayFrame:
	ldh a, [rLY]
	push bc
	ld b, a
.loop
	ldh a, [rLY]
	and a
	jr z, .done
	cp b
	jr nc, .loop
.done
	pop bc
	ret
