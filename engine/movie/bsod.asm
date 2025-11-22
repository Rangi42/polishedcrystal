BSOD:
	ldh a, [hCGB]
	and a
	ret nz

	ld e, MUSIC_NONE
	call PlayMusic

	call ClearTileMap

	ldh a, [rWBK]
	push af
	ld a, 5
	ldh [rWBK], a
	ld hl, BSODPalette
	ld de, wBGPals2
	ld bc, 1 palettes
	rst CopyBytes
	pop af
	ldh [rWBK], a

	ld a, 1
	ldh [hCGBPalUpdate], a

	xor a
	ldh [hBGMapHalf], a
	call DelayFrame

	ld de, FontNormal
	ld hl, vTiles1
	lb bc, BANK(FontNormal), 111
	call Get1bpp

	ld de, BSODMessage
	call CheckVBA
	jr z, .message
	ld de, VBABSODMessage
.message
	hlcoord 1, 1
	rst PlaceString

	ldh a, [hCrashCode]
	call PrintNum_NoHRAM

	cp NUM_ERR_CODES
	jr c, .valid
	ld a, NUM_ERR_CODES
.valid
	ld e, a
	ld d, 0
	ld hl, BSODErrorStrings
	add hl, de
	ld e, [hl]
	add hl, de
	ld e, l
	ld d, h
	hlcoord 1, 14
	rst PlaceString

	call ApplyTilemapInVBlank

.infinite_loop
	call DelayFrame
	jr .infinite_loop

PrintNum_NoHRAM:
; reimplementation of PrintNum without touching hram
	ld b, 100
	hlcoord 8, 12
	push af
	call .print_digit
	ld b, 10
	call .print_digit
	add '0'
	ld [hl], a
	pop af
	ret

.print_digit:
	ld [hl], '0' - 1
.loop
	inc [hl]
	sub b
	jr nc, .loop
	add b
	inc hl
	ret

BSODPalette:
INCLUDE "gfx/splash/bsod.pal"

BSODMessage:
	text  "      #mon"
	next1 " Polished Crystal"
	next  "       ERROR"
	next1 "------------------"
	next  "Please report this"
	next1 "crash to the deve-"
	next1 "loper, Rangi42, at"
	next1 "tinyurl.com/pkpc3."
	next  "Error:"
	done

VBABSODMessage:
	text  "      #mon"
	next1 " Polished Crystal"
	next  "       ERROR"
	next1 "------------------"
	next  "Please use a more"
	next1 "accurate emulator,"
	next1 "such as BGB, mGBA,"
	next1 "or Gambatte."
	next  "Error:"
	done

BSODErrorStrings:
	table_width 1
	dr .Rst0             ; ERR_RST_0
	dr .DivZero          ; ERR_DIV_ZERO
	dr .EggSpecies       ; ERR_EGG_SPECIES
	dr .ExecutingRAM     ; ERR_EXECUTING_RAM
	dr .StackOverflow    ; ERR_STACK_OVERFLOW
	dr .StackUnderflow   ; ERR_STACK_UNDERFLOW
	dr .OldBTState       ; ERR_BT_STATE
	dr .ChecksumMismatch ; ERR_CHECKSUM_MISMATCH
	dr .OldBox           ; ERR_OLDBOX
	dr .NewBox           ; ERR_NEWBOX
	dr .WinStackOverflow ; ERR_WINSTACK_OVERFLOW
	dr .SRAMMismatch     ; ERR_SRAM_MISMATCH
	dr .UnknownError     ; unknown
	assert_table_length NUM_ERR_CODES + 1

.Rst0:             text "rst 0@"
.DivZero:          text "Division by zero@"
.EggSpecies:       text "<PK><MN> species is Egg@"
.ExecutingRAM:     text "Executing RAM@"
.StackOverflow:    text "Stack overflow@"
.StackUnderflow:   text "Stack underflow@"
.OldBTState:       text "Old Battle Tower@"
.ChecksumMismatch: text "Checksum mismatch@"
.OldBox:           text "Old PC Box storage@"
.NewBox:           text "Fatal PC Box error@"
.WinStackOverflow: text "Win.stack overflow@"
.SRAMMismatch:     text "SRAM/WRAM mismatch@"
.UnknownError:     text "Unknown error@"
