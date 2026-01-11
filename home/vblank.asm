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

	ld hl, sp + 0
	ld a, h
	cp HIGH(wStackBottom)
	ld a, ERR_STACK_OVERFLOW
	jr c, .crash
	ld a, ERR_STACK_UNDERFLOW
	jr nz, .crash

	ld hl, sp + 9
	ld a, [hl]
	inc a
	cp HIGH(STARTOF(VRAM)) + 1
	ld a, ERR_EXECUTING_RAM
	jr nc, .crash

	ld a, [RomHeaderChecksum]
	ld hl, wRomChecksum
	cp [hl]
if !DEF(DEBUG)
	jr nz, .checksum_crash
else
	nop ; no-optimize nops
	nop ; no-optimize nops
endc
	ld a, [RomHeaderChecksum + 1]
	inc hl ; wRomChecksum + 1
	cp [hl]
if !DEF(DEBUG)
	jr nz, .checksum_crash
else
	nop ; no-optimize nops
	nop ; no-optimize nops
endc

.skip_crash
	ldh a, [hVBlank]
	and %1111
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
	dec [hl]
	jr nz, .noVBlankLeak
	ld a, $ff
	ldh [hDelayFrameLY], a
.noVBlankLeak
	ld [hl], TRUE

	ldh a, [hROMBankBackup]
	rst Bankswitch

	pop af
	pop bc
	pop de
	pop hl
	reti

.checksum_crash
	ld a, ERR_CHECKSUM_MISMATCH
.crash
	di
	jmp Crash

.skipToGameTime
	call AnimateTileset
	call PlaceFootprints
	jr .doGameTime

.VBlanks:
	dw VBlank0 ; 0
	dw VBlank1 ; 1
	dw VBlank2 ; 2
	dw VBlank1 ; 3
	dw VBlank4 ; 4 (pokédex)
	dw VBlank5 ; 5
	dw VBlank6 ; 6
	dw VBlank7 ; 7
	dw VBlank8 ; 8

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
	call PlaceFootprints

.done
	call UpdateCGBPalsLYTimed
	call PushOAM
	; vblank-sensitive operations are done

	; inc frame counter
	ld hl, hVBlankCounter
	inc [hl]

	; Increment time since text printing.
	ld hl, wTimeSinceText
	inc [hl]
	jr nz, .no_overflow
	dec [hl]

.no_overflow
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
	; fallthrough

VBlank2::
VBlankUpdateSound::
; sound only
	ei
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

VBlank4::
; pokédex

; rng
; scx, scy, wy, wx
; dma transfer
; dex map (also updates palettes and oam)
; tiles
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

	ld a, BANK(PVB_UpdateDexMap)
	rst Bankswitch
	call PVB_UpdateDexMap ; far-ok

	; These have their own timing checks.

	; Ensure we're loading graphics from the correct bank.
	ldh a, [hROMBankBackup]
	rst Bankswitch

	call Serve2bppRequest
	call Serve1bppRequest

.done
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

	jr VBlankUpdateSound


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

	jmp VBlankUpdateSound


VBlank7::
; special vblank routine
; copies tilemap in one frame without any tearing
; also updates oam, and pals if specified
	ld a, BANK(VBlankSafeCopyTilemapAtOnce)
	rst Bankswitch
	jmp VBlankSafeCopyTilemapAtOnce ; far-ok

VBlank8:
	; bg map
	; tiles
	; oam
	; joypad
	; serial
	; sound

	ldh a, [hROMBank]
	ldh [hROMBankBackup], a

	call UpdateBGMap
	call Serve2bppRequest

	call PushOAM

	call Joypad

	farcall AskSerial

	call VBlankUpdateSound

	ldh a, [hROMBankBackup]
	rst Bankswitch
	ret
