; VBlank is the interrupt responsible for updating VRAM.

; In Pokemon Crystal, VBlank has been hijacked to act as the
; main loop. After time-sensitive graphics operations have been
; performed, joypad input and sound functions are executed.

; This prevents the display and audio output from lagging.

VBlank::
	push hl
	push de
	push bc
	push af

	ldh a, [hTempBank]
	push af

	ldh a, [hROMBank]
	ldh [hROMBankBackup], a

	; Skip the .VBlanks table if [hVBlank] is just 7.
	; _SafeCopyTilemapAtOnce sets it to 1 << 7 | 7 to execute actual VBlank7.
	ldh a, [hVBlank]
	cp 7
	jr z, .skipToGameTime

	; Avoid chaining crashes as a rule. This is especially for vblank ones.
	; Thus, the fact that this doesn't avoid chaining rst0 (error code 0) is ok.
	ldh a, [hCrashCode]
	and a
	jr nz, .skip_crash

	ld hl, sp+$0
	ld a, h
	cp HIGH(wStackBottom)
	ld a, ERR_STACK_OVERFLOW
	jr c, .crash
	ld a, ERR_STACK_UNDERFLOW
	jr nz, .crash

	ld hl, sp+$b
	ld a, [hl]
	inc a
	cp HIGH(VRAM_Begin) + 1
	ld a, ERR_EXECUTING_RAM
	jr nc, .crash

	ldh a, [rSVBK]
	ld e, a
	ld a, BANK(wGameVersion)
	ldh [rSVBK], a
	ld hl, wGameVersion
	ld a, [hli]
	cp HIGH(SAVE_VERSION)
	jr nz, .version_crash
	ld a, [hl]
	cp LOW(SAVE_VERSION)
	ld a, ERR_VERSION_MISMATCH
	jr nz, .version_crash
	ld a, e
	ldh [rSVBK], a

.skip_crash
	ldh a, [hVBlank]
	and %111
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

	ld hl, hVBlankOccurred
	ld a, [hl]
	and a
	ld [hl], FALSE
	jr nz, .noVBlankLeak
	ld a, $ff
	ldh [hDelayFrameLY], a
.noVBlankLeak

	pop af
	ldh [hTempBank], a

	ldh a, [hROMBankBackup]
	rst Bankswitch

	pop af
	pop bc
	pop de
	pop hl
	reti

.version_crash
	ld a, e
	ldh [rSVBK], a
	ld a, ERR_VERSION_MISMATCH
.crash
	di
	jmp Crash

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

	ldh a, [hSCX]
	ldh [rSCX], a
	ldh a, [hSCY]
	ldh [rSCY], a
	ldh a, [hWY]
	ldh [rWY], a
	ldh a, [hWX]
	ldh [rWX], a

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

	ldh a, [hSeconds]
	ldh [hSecondsBackup], a
	; fallthrough

VBlank2::
VBlankUpdateSound::
; sound only
	ld a, BANK(_UpdateSound)
	rst Bankswitch
	jmp _UpdateSound ; far-ok

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
	ldh a, [hSCX]
	ldh [rSCX], a
	ldh a, [hSCY]
	ldh [rSCY], a

	call UpdateCGBPals
	jr c, .done

	call UpdateBGMap
	call Serve2bppRequest
	call LYOverrideStackCopy

.done
	call PushOAM

	; get requested ints
	ldh a, [rIE]
	push af
	ldh a, [rIF]
	push af

	xor a
	ldh [rIF], a
	ld a, 1 << LCD_STAT
	ldh [rIE], a
	ldh [rIF], a

	ei
	call VBlankUpdateSound
	di

	; get requested ints
	ldh a, [rIF]
	ld b, a

	; discard requested ints
	pop af
	or b
	ld b, a
	xor a
	ldh [rIF], a

	; enable ints besides joypad
	pop af
	ldh [rIE], a

	; rerequest ints
	ld a, b
	ldh [rIF], a
	ret

VBlank5::
; scx
; palettes
; bg map
; tiles
; joypad
; sound
	ldh a, [hSCX]
	ldh [rSCX], a

	call UpdateCGBPals
	jr c, .done

	call UpdateBGMap
	call Serve2bppRequest

.done
	call Joypad

	xor a
	ldh [rIF], a
	ldh a, [rIE]
	push af
	ld a, 1 << LCD_STAT
	ldh [rIE], a
	ldh [rIF], a

	ei
	call VBlankUpdateSound
	di

	xor a
	ldh [rIF], a

	; enable usual interrupts
	pop af
	ldh [rIE], a
	ret

VBlank7::
; special vblank routine
; copies tilemap in one frame without any tearing
; also updates oam, and pals if specified
	ld a, BANK(VBlankSafeCopyTilemapAtOnce)
	rst Bankswitch
	jmp VBlankSafeCopyTilemapAtOnce ; far-ok
