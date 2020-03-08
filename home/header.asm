; Small routines and data can fit in the unused rst and interrupt vector space.


; rst vectors

SECTION "rst00 EntryPoint", ROM0[$0000]
	di
	jp Start

PushWindow::
	farjp _PushWindow


SECTION "rst08 FarCall", ROM0[$0008]
	jp RstFarCall

LoadMapPart::
	farjp _LoadMapPart

	ds 1 ; free space


SECTION "rst10 Bankswitch", ROM0[$0010]
	ld [hROMBank], a
	ld [MBC3RomBank], a
	ret

	ds 2 ; free space


SECTION "rst18 AddNTimes", ROM0[$0018]
	jp _AddNTimes

_de_::
	push de
DoNothing::
	ret

FarCopyWRAM::
	call StackCallInWRAMBankA


SECTION "rst20 CopyBytes", ROM0[$0020]
	jp _CopyBytes

GetFarByte::
; retrieve a single byte from a:hl, and return it in a.
	call StackCallInBankA

.Function:
	ld a, [hl]
	ret


SECTION "rst28 JumpTable", ROM0[$0028]
	jp _Jumptable

GetFarWRAMByte::
	call StackCallInWRAMBankA

.Function:
	ld a, [hl]
	ret


SECTION "rst30 Predef", ROM0[$0030]
	jp _Predef

DisappearUser::
	farjp _DisappearUser

	ds 1 ; free space


SECTION "rst38 InfiniteLoop", ROM0[$0038]
	rst InfiniteLoop

Cosine::
; Return d * cos(a) in hl
	add $10 ; 90 degrees
Sine::
; Return d * sin(a) in hl
; a is a signed 6-bit value.
	ld e, a
	farjp _Sine


; Game Boy hardware interrupts

SECTION "vblank", ROM0[$0040]
	jp VBlank

ItemIsMail::
	ld a, d
	cp FLOWER_MAIL
	ccf
	ret


SECTION "lcd", ROM0[$0048]
	jp LCD

GetMemCGBLayout::
	xor a ; CGB_RAM
GetCGBLayout::
	farjp LoadCGBLayout


SECTION "timer", ROM0[$0050]
	reti

ExitMenu::
	push af
	farcall _ExitMenu
	pop af
	ret


SECTION "serial", ROM0[$0058]
	jp Serial

CheckOnWater::
	call GetPlayerStandingTile
	dec a ; cp WATER_TILE
	ret


SECTION "joypad", ROM0[$0060]
	reti


SECTION "High Home", ROM0[$0061]

INCLUDE "home/high_home.asm"
INCLUDE "home/delay.asm"


SECTION "Header", ROM0[$0100]

Start::
	nop
	jp _Start

; rgbfix patches the cartridge header here
rept $0150 - $0104
	db $00
endr
