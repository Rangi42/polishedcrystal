DelayFrame:: ; 45a
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
; 468

Delay2::
; TODO: optimize to the point where this can do what it claims
	ld c, 3

DelayFrames:: ; 468
; Wait c frames
	call DelayFrame
	dec c
	jr nz, DelayFrames
	ret
; 46f
