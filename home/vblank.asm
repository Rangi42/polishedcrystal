; VBlank is the interrupt responsible for updating VRAM.

; In Pokemon Crystal, VBlank has been hijacked to act as the
; main loop. After time-sensitive graphics operations have been
; performed, joypad input and sound functions are executed.

; This prevents the display and audio output from lagging.


VBlank::
	push af
	push bc
	push de
	push hl

	ld a, [hBuffer]
	push af

	ld a, [hROMBank]
	ld [hROMBankBackup], a

	ld a, [hVBlank]
	cp 7
	jr z, .skipToGameTime
	and 7
	add a
	ld e, a
	ld d, 0
	ld hl, .VBlanks
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	call _hl_

.doGameTime
	call GameTimer

	ld hl, wVBlankOccurred
	ld a, [hl]
	and a
	ld [hl], 0
	jr nz, .noVBlankLeak
	ld a, $ff
	ld [hDelayFrameLY], a
.noVBlankLeak

	pop af
	ld [hBuffer], a

	ld a, [hROMBankBackup]
	rst Bankswitch

	pop hl
	pop de
	pop bc
	pop af
	reti

.skipToGameTime
	call AnimateTileset
	jr .doGameTime

.VBlanks:
	dw VBlank0   ; 0
	dw VBlank1   ; 1
	dw VBlank2   ; 2
	dw VBlank1   ; 3
	dw DoNothing ; 4
	dw VBlank5   ; 5
	dw VBlank6   ; 6
	dw VBlank7   ; 7


VBlank0::
; normal operation

; rng
; scx, scy, wy, wx
; bg map buffer
; palettes
; dma transfer
; bg map
; tiles
; oam
; joypad
; sound

	ld a, [hSCX]
	ld [rSCX], a
	ld a, [hSCY]
	ld [rSCY], a
	ld a, [hWY]
	ld [rWY], a
	ld a, [hWX]
	ld [rWX], a

	; There's only time to call one of these in one vblank.
	; Calls are in order of priority.

	call UpdateBGMapBuffer
	jr c, .done
	call UpdateCGBPals
	jr c, .done
	call DMATransfer
	jr c, .done
	call UpdateBGMap

	; These have their own timing checks.

	call Serve2bppRequest
	call Serve1bppRequest
	call AnimateTileset

.done
	call PushOAM
	; vblank-sensitive operations are done

	; inc frame counter
	ld hl, hVBlankCounter
	inc [hl]

	; advance random variables
	call UpdateDividerCounters
	call AdvanceRNGState

	ld a, [wTextDelayFrames]
	and a
	jr z, .noDelay2
	dec a
	ld [wTextDelayFrames], a
.noDelay2
	call Joypad

	ld a, [hSeconds]
	ld [hSecondsBackup], a
	; fallthrough

VBlank2::
VBlankUpdateSound::
; sound only
	ld a, BANK(_UpdateSound)
	rst Bankswitch
	jp _UpdateSound

VBlank6::
; palettes
; tiles
; dma transfer
; sound
	; inc frame counter
	ld hl, hVBlankCounter
	inc [hl]

	call UpdateCGBPals
	jr c, VBlankUpdateSound

	call Serve2bppRequest
	call Serve1bppRequest
	call DMATransfer

	jr VBlankUpdateSound

VBlank1::
; scx, scy
; palettes
; bg map
; tiles
; oam
; sound / lcd stat
	ld a, [hSCX]
	ld [rSCX], a
	ld a, [hSCY]
	ld [rSCY], a

	call UpdateCGBPals
	jr c, .done

	call UpdateBGMap
	call Serve2bppRequest
	call LYOverrideStackCopy

.done
	call PushOAM

	; get requested ints
	ld a, [rIE]
	push af
	ld a, [rIF]
	push af

	xor a
	ld [rIF], a
	ld a, 1 << LCD_STAT
	ld [rIE], a
	ld [rIF], a

	ei
	call VBlankUpdateSound
	di

	; get requested ints
	ld a, [rIF]
	ld b, a

	; discard requested ints
	pop af
	or b
	ld b, a
	xor a
	ld [rIF], a

	; enable ints besides joypad
	pop af
	ld [rIE], a

	; rerequest ints
	ld a, b
	ld [rIF], a
	ret

VBlank5::
; scx
; palettes
; bg map
; tiles
; joypad
; sound
	ld a, [hSCX]
	ld [rSCX], a

	call UpdateCGBPals
	jr c, .done

	call UpdateBGMap
	call Serve2bppRequest

.done
	call Joypad

	xor a
	ld [rIF], a
	ld a, [rIE]
	push af
	ld a, 1 << LCD_STAT
	ld [rIE], a
	ld [rIF], a

	ei
	call VBlankUpdateSound
	di

	xor a
	ld [rIF], a

	; enable ints besides joypad
	pop af
	ld [rIE], a
	ret

VBlank7::
; special vblank routine
; copies tilemap in one frame without any tearing
; also updates oam, and pals if specified
	ld a, BANK(VBlankSafeCopyTilemapAtOnce)
	rst Bankswitch
	jp VBlankSafeCopyTilemapAtOnce
