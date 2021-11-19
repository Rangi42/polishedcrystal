BSOD:
	ldh a, [hCGB]
	and a
	ret nz

	ld de, MUSIC_NONE
	call PlayMusic

	call ClearTileMap

	ldh a, [rSVBK]
	push af
	ld a, 5
	ldh [rSVBK], a
	ld hl, BSODPalette
	ld de, wBGPals2
	ld bc, 1 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a

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
	add a
	add LOW(BSOD_ErrorStrings)
	ld l, a
	adc HIGH(BSOD_ErrorStrings)
	sub l
	ld h, a
	ld a, [hli]
	ld d, [hl]
	ld e, a
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
	add "0"
	ld [hl], a
	pop af
	ret

.print_digit:
	ld [hl], "0" - 1
.loop
	inc [hl]
	sub b
	jr nc, .loop
	add b
	inc hl
	ret

BSODPalette:
if !DEF(MONOCHROME)
	RGB 00, 00, 31
	RGB 00, 00, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
else
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
endc

BSODMessage:
	db    "      #mon"
	next1 " Polished Crystal"
	next  "       ERROR"
	next1 "------------------"
	next  "Please report this"
	next1 "crash to the deve-"
	next1 "loper, Rangi42, at"
	next1 "tinyurl.com/pkpc3."
	next  "Error:@"

VBABSODMessage:
	db    "      #mon"
	next1 " Polished Crystal"
	next  "       ERROR"
	next1 "------------------"
	next  "Please use a more"
	next1 "accurate emulator,"
	next1 "such as BGB, mGBA,"
	next1 "or Gambatte."
	next  "Error:@"

BSOD_ErrorStrings:
	table_width 2, BSOD_ErrorStrings
	dw .Rst0             ; ERR_RST_0
	dw .DivZero          ; ERR_DIV_ZERO
	dw .EggSpecies       ; ERR_EGG_SPECIES
	dw .ExecutingRAM     ; ERR_EXECUTING_RAM
	dw .StackOverflow    ; ERR_STACK_OVERFLOW
	dw .StackUnderflow   ; ERR_STACK_UNDERFLOW
	dw .OldBTState       ; ERR_BT_STATE
	dw .VersionMismatch  ; ERR_VERSION_MISMATCH
	dw .OldBox           ; ERR_OLDBOX
	dw .NewBox           ; ERR_NEWBOX
	dw .WinStackOverflow ; ERR_WINSTACK_OVERFLOW
	dw .UnknownError     ; unknown
	assert_table_length NUM_ERR_CODES + 1

.Rst0:
	db "rst 0@"

.DivZero:
	db "Division by zero@"

.EggSpecies:
	db "<PK><MN> species is Egg@"

.ExecutingRAM:
	db "Executing RAM@"

.StackOverflow:
	db "Stack overflow@"

.StackUnderflow:
	db "Stack underflow@"

.OldBTState:
	db "Old Battle Tower@"

.VersionMismatch:
	db "Version mismatch@"

.OldBox:
	db "Old PC box storage@"

.NewBox:
	db "Fatal PC box error@"

.WinStackOverflow:
	db "Win.stack overflow@"

.UnknownError:
	db "Unknown error@"
