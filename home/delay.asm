ClearBGPalettes::
	call ClearPalettes
	jr ApplyTilemapInVBlank

ApplyAttrAndTilemapInVBlank::
	ld a, 2
	ld [hBGMapMode], a
	call Delay2

ApplyTilemapInVBlank::
; Tell VBlank to update BG Map
	ld a, 1
	ld [hBGMapMode], a

SFXDelay2::
Delay2::
	ld c, 2

SFXDelayFrames::
DelayFrames::
; Wait c frames
	call DelayFrame
	dec c
	jr nz, DelayFrames
	ret

SFXDelayFrame::
DelayFrame::
; Wait for one frame
	ld a, [rLY]
	ld [hDelayFrameLY], a
	ld a, 1
	ld [wVBlankOccurred], a

; Wait for the next VBlank, halting to conserve battery
.halt
	halt ; rgbasm adds a nop after this instruction by default
	ld a, [wVBlankOccurred]
	and a
	jr nz, .halt
	ret
