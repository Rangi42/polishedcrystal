PrintLetterDelay::
; Wait before printing the next letter.

; The text speed setting in wOptions1 is actually a frame count:
; 	fast: 1 frame
; 	mid:  3 frames
; 	slow: 5 frames

; wTextboxFlags[!0] and A or B override text speed with a one-frame delay.
; wOptions1[4] and wTextboxFlags[!1] disable the delay.

	ld a, [wTextboxFlags]
	bit 1, a
	ret z
	bit 0, a
	jr z, .forceFastScroll

	ld a, [wOptions1]
	bit NO_TEXT_SCROLL, a
	ret nz
	and %11
	ret z
	ld a, $1
	ldh [hBGMapHalf], a
.forceFastScroll
	push hl
	push de
	push bc
; force fast scroll?
	ld a, [wTextboxFlags]
	bit 0, a
	ld a, 2
	jr z, .updateDelay
; text speed
	ld a, [wOptions1]
	and %11
	rlca
.updateDelay
	dec a
	ld [wTextDelayFrames], a
.textDelayLoop
	ld a, [wTextDelayFrames]
	and a
	jr z, .done
	call DelayFrame
	call GetJoypad
; Finish execution if A or B is pressed
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr z, .textDelayLoop
.done
	jmp PopBCDEHL

CopyDataUntil::
; Copy [hl .. bc) to de.

; In other words, the source data is
; from hl up to but not including bc,
; and the destination is de.

	ld a, [hli]
	ld [de], a
	inc de
	ld a, h
	cp b
	jr nz, CopyDataUntil
	ld a, l
	cp c
	jr nz, CopyDataUntil
	ret

PrintNumFromReg::
	homecall _PrintNumFromReg
	ret

FastPrintNum::
	homecall _FastPrintNum
	ret

FarPrintText::
	push de
	ld d, a
	ldh a, [hROMBank]
	ld e, a
	ld a, d
	rst Bankswitch
	push de
	call PrintText
	pop de
	ld a, e
	rst Bankswitch
	pop de
	ret
