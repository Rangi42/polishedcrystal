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

	and a ; a == ERR_RST_0?
	ld de, BSOD_Rst0
	jr z, .done
	dec a ; a == ERR_DIV_ZERO?
	ld de, BSOD_DivZero
	jr z, .done
	dec a ; a == ERR_EGG_SPECIES?
	ld de, BSOD_EggSpecies
	jr z, .done
	dec a ; a == ERR_EXECUTING_RAM?
	ld de, BSOD_ExecutingRAM
	jr z, .done
	dec a ; a == ERR_STACK_OVERFLOW?
	ld de, BSOD_StackOverflow
	jr z, .done
	dec a ; a == ERR_STACK_UNDERFLOW?
	ld de, BSOD_StackUnderflow
	jr z, .done
	dec a ; a == ERR_BT_STATE?
	ld de, BSOD_OldBTState
	jr z, .done
	dec a ; a == ERR_VERSION_MISMATCH?
	ld de, BSOD_VersionMismatch
	jr z, .done
	dec a ; a == ERR_OLDBOX?
	ld de, BSOD_OldBox
	jr z, .done
	dec a ; a == ERR_NEWBOX?
	ld de, BSOD_NewBox
	jr z, .done
	dec a ; a == ERR_WINSTACK_OVERFLOW?
	ld de, BSOD_WinStackOverflow
	jr z, .done
	ld de, BSOD_UnknownError
.done
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

BSOD_Rst0:
	db "rst 0@"

BSOD_DivZero:
	db "Division by zero@"

BSOD_EggSpecies:
	db "<PK><MN> species is Egg@"

BSOD_ExecutingRAM:
	db "Executing RAM@"

BSOD_StackOverflow:
	db "Stack overflow@"

BSOD_StackUnderflow:
	db "Stack underflow@"

BSOD_OldBTState:
	db "Old Battle Tower@"

BSOD_VersionMismatch:
	db "Version mismatch@"

BSOD_OldBox:
	db "Old PC box storage@"

BSOD_NewBox:
	db "Fatal PC box error@"

BSOD_WinStackOverflow:
	db "Win.stack overflow@"

BSOD_UnknownError:
	db "Unknown error@"
