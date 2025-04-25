ClearBGPalettes::
	call ClearPalettes
	jr ApplyTilemapInVBlank

ApplyAttrmapInVBlank::
; Tell VBlank to update Attr Map
	ld a, 2
	jr _ApplyAttrOrTilemapInVBlank

ApplyAttrAndTilemapInVBlank::
	call ApplyAttrmapInVBlank

ApplyTilemapInVBlank::
; Tell VBlank to update BG Map
	ld a, 1
_ApplyAttrOrTilemapInVBlank:
	ldh [hBGMapMode], a

; TODO: Update the audio engine so we can remove the calls to SFXDelay* routines,
; without causing odd button sounds when the artifical delays are gone.

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

DelayFrame::
; Wait for one frame
	ldh a, [rLY]
	ldh [hDelayFrameLY], a
	xor a ; ld a, FALSE
	ldh [hVBlankOccurred], a

; Wait for the next VBlank, halting to conserve battery
DelayFrameHalt:
	halt
	nop
	; fallthrough
MaybeDelayFrame:
; Used in place of DelayFrame for special cases.
	ldh a, [hVBlankOccurred]
	and a
	jr z, DelayFrameHalt
	ret

ConsumeGenericDelay::
	ld a, [wGenericDelay]
	and a
	ret z
	ld c, a
	jr DelayFrames
