ClearBGPalettes::
	call ClearPalettes
	jr WaitBGMap

WaitBGMap2::
	ld a, 2
	ld [hBGMapMode], a
	call Delay2

WaitBGMap::
; Tell VBlank to update BG Map
	ld a, 1
	ld [hBGMapMode], a

Delay2::
; TODO: optimize to the point where this can do what it claims
	ld c, 3

DelayFrames::
; Wait c frames
	call DelayFrame
	dec c
	jr nz, DelayFrames
	ret

ApplyTilemap::
; Tell VBlank to update BG Map
	ld a, 1
	ld [hBGMapMode], a
	ld a, [wSpriteUpdatesEnabled]
	and a
	ld b, 3
	jr nz, SafeCopyTilemapAtOnce
	ld b, 1 << 3 | 3

; fallthrough
SafeCopyTilemapAtOnce::
; copies the tile&attr map at once
; without any tearing
; input:
; b: 0 = no palette copy
;    1 = copy raw palettes
;    2 = set palettes and copy
;    3 = use whatever was in hCGBPalUpdate
; bit 2: if set, clear hOAMUpdate
; bit 3: if set, only update tilemap
	farjp _SafeCopyTilemapAtOnce

CopyTilemapAtOnce::
	farjp _CopyTilemapAtOnce

DelayFrame::
; Wait for one frame
	ld a, 1
	ld [wVBlankOccurred], a

; Wait for the next VBlank, halting to conserve battery
.halt
	halt ; rgbasm adds a nop after this instruction by default
	ld a, [wVBlankOccurred]
	and a
	jr nz, .halt
	ret
