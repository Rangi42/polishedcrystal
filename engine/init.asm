_Init::
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

; Place stack at its default location in HRAM for 'call nz, DoubleSpeed'
	ld sp, $fffe

; Enable double speed now to speed up the rest of initialization
	ldh a, [hCGB]
	and a
	call nz, DoubleSpeed

; Clear WRAM bank 0
	ld hl, wRAM0Start
	ld bc, wRAM0End - wRAM0Start
	xor a
	rst ByteFill

; Move stack to WRAM
	ld sp, wStack

; Clear HRAM
	ldh a, [hCrashCode]
	push af
	ldh a, [hCGB]
	push af
	xor a
	ld hl, HRAM_Begin
	ld bc, HRAM_End - HRAM_Begin
	rst ByteFill
	pop af
	ldh [hCGB], a
	pop af
	ldh [hCrashCode], a
	ld a, BANK(@)
	ldh [hROMBank], a

	call ClearWRAM
	ld a, 1
	ldh [rSVBK], a
	call ClearVRAM
	call ClearSprites

	; Write checksum to WRAM for save state check
	ld a, [RomHeaderChecksum]
	ld [wRomChecksum], a
	ld a, [RomHeaderChecksum + 1]
	ld [wRomChecksum + 1], a

; Initialize the RNG state. It can be initialized to anything but zero; this is just a simple way of doing it.
	ld hl, wRNGState
	ld a, "R"
	ld [hli], a
	ld a, "N"
	ld [hli], a
	ld a, "G"
	ld [hli], a
	ld [hl], "!"

	call WriteOAMDMACodeToHRAM

	xor a
	ldh [hMapAnims], a
	ldh [hSCX], a
	ldh [hSCY], a
	ldh [rJOYP], a

	ld a, 1 << rSTAT_INT_MODE_0
	ldh [rSTAT], a

	ld a, $90
	ldh [hWY], a
	ldh [rWY], a

	ld a, 7
	ldh [hWX], a
	ldh [rWX], a

	farcall InitCGBPals

	farcall InitSGBBorder

	ld a, LCDC_DEFAULT
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

	xor a
	ldh [rIF], a
	ld a, 1 << VBLANK | 1 << SERIAL
	ldh [rIE], a
	ei

	call DelayFrame

	call InitSound
	xor a
	ld [wMapMusic], a

	farcall TryLoadSaveData
	call ClearWindowData
	call ClearBGPalettes
	call ClearTileMap

	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	xor a
	ldh [hBGMapAddress], a
	ldh [hJoyDown], a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $90
	ldh [hWY], a

	call ApplyTilemapInVBlank
	jmp CrystalIntroSequence

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
