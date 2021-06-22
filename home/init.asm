SoftReset::
	di
	call InitSound
	xor a
	ldh [hMapAnims], a
	call ClearPalettes
	xor a
	ldh [rIF], a
	ld a, 1 << VBLANK
	ldh [rIE], a
	ei

	ld hl, wInputFlags
	set 7, [hl]

	ld c, 3
	call DelayFrames

	jr Init


Rst0Crash:
	xor a ; ld a, ERR_RST_0
Crash::
	ld b, b ; no-optimize nops (BGB breakpoint)

	ldh [hCrashCode], a
	xor a
	ldh [hCGB], a
	jr Init

_Start::
	cp $11
	jr z, .cgb
	xor a
	jr .load

.cgb
	ld a, $1

.load
	ldh [hCGB], a
	xor a ; ld a, ERR_RST_0
	ldh [hCrashCode], a
	; fallthrough

Init::

	di

	xor a
	ldh [rIF], a
	ldh [rIE], a
	ldh [rRP], a
	ldh [rSCX], a
	ldh [rSCY], a
	ldh [rSB], a
	ldh [rSC], a
	ldh [rWX], a
	ldh [rWY], a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	ldh [rTMA], a
	ldh [rTAC], a
	ld [wRAM1Start], a

.wait
	ldh a, [rLY]
	cp 145
	jr nz, .wait

	xor a
	ldh [rLCDC], a

; Clear WRAM bank 0
; Can't use rst ByteFill since we haven't initialized sp yet,
; and wStack is part of WRAM0.
	ld hl, wRAM0Start
	ld bc, wRAM0End - wRAM0Start
.ByteFill:
	xor a
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .ByteFill

	ld sp, wStack

; Clear HRAM
	ldh a, [hCrashCode]
	push af
	ldh a, [hCGB]
	push af
	xor a
	ld hl, HRAM_START
	ld bc, HRAM_END - HRAM_START
	rst ByteFill
	pop af
	ldh [hCGB], a
	pop af
	ldh [hCrashCode], a

	call ClearWRAM
	ld a, 1
	ldh [rSVBK], a
	call ClearVRAM
	call ClearSprites
	call ClearsScratch

	; Write game version to WRAM.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wGameVersion)
	ldh [rSVBK], a
	ld a, HIGH(SAVE_VERSION)
	ld [wGameVersion], a
	ld a, LOW(SAVE_VERSION)
	ld [wGameVersion + 1], a
	pop af
	ldh [rSVBK], a

; Initialize the RNG state. It can be initialized to anything but zero; this is just a simple way of doing it.
	ld hl, wRNGState
	ld a, "R"
	ld [hli], a
	ld a, "N"
	ld [hli], a
	ld a, "G"
	ld [hli], a
	ld [hl], "!"

	ld a, BANK(GameInit) ; aka BANK(WriteOAMDMACodeToHRAM)
	rst Bankswitch

	call WriteOAMDMACodeToHRAM ; far-ok

	xor a
	ldh [hMapAnims], a
	ldh [hSCX], a
	ldh [hSCY], a
	ldh [rJOYP], a

	ld a, $8 ; HBlank int enable
	ldh [rSTAT], a

	ld a, $90
	ldh [hWY], a
	ldh [rWY], a

	ld a, 7
	ldh [hWX], a
	ldh [rWX], a

	farcall InitCGBPals

	farcall InitSGBBorder

	ld a, %11100011
	; LCD on
	; Win tilemap 1
	; Win on
	; BG/Win tiledata 0
	; BG Tilemap 0
	; OBJ 8x8
	; OBJ on
	; BG on
	ldh [rLCDC], a

	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a

	ld a, $cb ; prefix
	ldh [hBitwisePrefix], a
	ld a, $c9 ; ret
	ldh [hBitwiseRet], a
	ldh [hSingleRet], a
	ld a, $c3 ; jp
	ldh [hFunctionJump], a
	ld a, LOW(LCDGeneric)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDGeneric)
	ldh [hFunctionTargetHi], a

	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	xor a ; LOW(vBGMap1)
	ldh [hBGMapAddress], a

	farcall StartClock

	xor a
	ld [MBC3LatchClock], a
	ld [MBC3SRamEnable], a

	ldh a, [hCGB]
	and a
	call nz, DoubleSpeed

	xor a
	ldh [rIF], a
	ld a, 1 << VBLANK | 1 << SERIAL
	ldh [rIE], a
	ei

	call DelayFrame

	call InitSound
	xor a
	ld [wMapMusic], a
	jmp GameInit ; far-ok

ClearVRAM::
; Wipe VRAM banks 0 and 1

	ld a, 1
	ldh [rVBK], a
	call .clear

	xor a
	ldh [rVBK], a
.clear
	ld hl, vTiles0
	ld bc, $2000
	xor a
	rst ByteFill
	ret

ClearWRAM::
; Wipe swappable WRAM banks (1-7)

	ld a, 1
.bank_loop
	push af
	ldh [rSVBK], a
	xor a
	ld hl, wRAM1Start
	ld bc, $1000
	rst ByteFill
	pop af
	inc a
	cp 8
	jr c, .bank_loop
	ret

ClearsScratch::
	xor a
	call GetSRAMBank
	ld hl, sScratch
	ld bc, $20
	xor a
	rst ByteFill
	jmp CloseSRAM
