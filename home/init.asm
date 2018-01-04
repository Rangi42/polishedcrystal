SoftReset:: ; 150
	di
	call MapSetup_Sound_Off
	xor a
	ld [hMapAnims], a
	call ClearPalettes
	xor a
	ld [rIF], a
	ld a, 1 ; VBlank int
	ld [rIE], a
	ei

	ld hl, InputFlags
	set 7, [hl]

	ld c, 32
	call DelayFrames

	jr Init
; 16e


_Start:: ; 16e
	cp $11
	jr z, .cgb
	xor a
	jr .load

.cgb
	ld a, $1

.load
	ld [hCGB], a


Init:: ; 17d

	di

	xor a
	ld [rIF], a
	ld [rIE], a
	ld [rRP], a
	ld [rSCX], a
	ld [rSCY], a
	ld [rSB], a
	ld [rSC], a
	ld [rWX], a
	ld [rWY], a
	ld [rBGP], a
	ld [rOBP0], a
	ld [rOBP1], a
	ld [rTMA], a
	ld [rTAC], a
	ld [wRAM1Start], a

	ld a, %100 ; Start timer at 4096Hz
	ld [rTAC], a

.wait
	ld a, [rLY]
	cp 145
	jr nz, .wait

	xor a
	ld [rLCDC], a

; Clear WRAM bank 0
	ld hl, wRAM0Start
	ld bc, wRAM0End - wRAM0Start
.ByteFill:
	ld [hl], 0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .ByteFill

	ld sp, Stack

; Clear HRAM
	ld a, [hCGB]
	push af
	xor a
	ld hl, HRAM_START
	ld bc, HRAM_END - HRAM_START
	call ByteFill
	pop af
	ld [hCGB], a

	call ClearWRAM
	ld a, 1
	ld [rSVBK], a
	call ClearVRAM
	call ClearSprites
	call ClearsScratch

; Initialize the RNG state. It can be initialized to anything but zero; this is just a simple way of doing it.
	ld hl, wRNGState
	ld a, "R"
	ld [hli], a
	ld a, "N"
	ld [hli], a
	ld a, "G"
	ld [hli], a
	ld [hl], "!"

	ld a, BANK(LoadPushOAM)
	rst Bankswitch

	call LoadPushOAM

	xor a
	ld [hMapAnims], a
	ld [hSCX], a
	ld [hSCY], a
	ld [rJOYP], a

	ld a, $8 ; HBlank int enable
	ld [rSTAT], a

	ld a, $90
	ld [hWY], a
	ld [rWY], a

	ld a, 7
	ld [hWX], a
	ld [rWX], a

	ld a, %11100011
	; LCD on
	; Win tilemap 1
	; Win on
	; BG/Win tiledata 0
	; BG Tilemap 0
	; OBJ 8x8
	; OBJ on
	; BG on
	ld [rLCDC], a

	ld a, CONNECTION_NOT_ESTABLISHED
	ld [hSerialConnectionStatus], a

	farcall InitCGBPals

	ld a, VBGMap1 / $100
	ld [hBGMapAddress + 1], a
	xor a ; VBGMap1 % $100
	ld [hBGMapAddress], a

	farcall StartClock

	xor a
	ld [MBC3LatchClock], a
	ld [MBC3SRamEnable], a

	call NormalSpeed

	xor a
	ld [rIF], a
	ld a, %1111 ; VBlank, LCDStat, Timer, Serial interrupts
	ld [rIE], a
	ei

	call DelayFrame

	call MapSetup_Sound_Off
	xor a
	ld [wMapMusic], a
	jp GameInit
; 245


ClearVRAM:: ; 245
; Wipe VRAM banks 0 and 1

	ld a, 1
	ld [rVBK], a
	call .clear

	xor a
	ld [rVBK], a
.clear
	ld hl, VTiles0
	ld bc, $2000
	xor a
	jp ByteFill
; 25a

ClearWRAM:: ; 25a
; Wipe swappable WRAM banks (1-7)

	ld a, 1
.bank_loop
	push af
	ld [rSVBK], a
	xor a
	ld hl, wRAM1Start
	ld bc, $1000
	call ByteFill
	pop af
	inc a
	cp 8
	jr c, .bank_loop
	ret
; 270

ClearsScratch:: ; 270
	xor a
	call GetSRAMBank
	ld hl, sScratch
	ld bc, $20
	xor a
	call ByteFill
	jp CloseSRAM
; 283
