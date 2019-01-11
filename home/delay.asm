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
	ld c, 2

DelayFrames::
; Wait c frames
	call DelayFrame
	dec c
	jr nz, DelayFrames
	ret

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
