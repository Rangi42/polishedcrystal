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
	ld hl, .Palette
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

	ld de, .Message
	hlcoord 1, 1
	rst PlaceString

	ldh a, [hCrashCode]
	call .printnum_simple

	and a ; a == ERR_RST_0?
	ld de, .Rst0
	jr z, .PrintErrorType
	dec a ; a == ERR_DIV_ZERO?
	ld de, .DivZero
	jr z, .PrintErrorType
	dec a ; a == ERR_EGG_SPECIES?
	ld de, .EggSpecies
	jr z, .PrintErrorType
	dec a ; a == ERR_EXECUTING_RAM?
	ld de, .ExecutingRAM
	jr z, .PrintErrorType
	dec a ; a == ERR_STACK_OVERFLOW?
	ld de, .StackOverflow
	jr z, .PrintErrorType
	dec a ; a == ERR_STACK_UNDERFLOW?
	ld de, .StackUnderflow
	jr z, .PrintErrorType
	dec a ; a == ERR_STACK_UNDERFLOW?
	ld de, .BTOldSave
	jr z, .PrintErrorType
	ld de, .UnknownError
.PrintErrorType
	hlcoord 1, 14
	rst PlaceString

	call ApplyTilemapInVBlank

.infiniteloop
	call DelayFrame
	jr .infiniteloop

.printnum_simple
; reimplementation of PrintNum without touching hram
	ld b, 100
	hlcoord 8, 12
	push af
	call .do_printnum
	ld b, 10
	call .do_printnum
	add "0"
	ld [hl], a
	pop af
	ret
.do_printnum
	ld [hl], "0" - 1
.printnum_loop
	inc [hl]
	sub b
	jr nc, .printnum_loop
	add b
	inc hl
	ret

.Palette:
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

.Message:
	db    "      #mon"
	next1 " Polished Crystal"
	next  "       ERROR"
	next1 "------------------"
	next  "Please report this"
	next1 "crash to the deve-"
	next1 "loper, Rangi42, at"
	next1 "tinyurl.com/pkpc3."
	next  "Error:@"

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

.BTOldSave:
	db "Old save@"

.UnknownError:
	db "Unknown error@"
