; Small routines and data can fit in the unused rst and interrupt vector space.


; rst vectors

SECTION "rst00 EntryPoint", ROM0[$0000]
EntryPoint::
	di
	xor a ; ld a, ERR_RST_0
	jmp Crash

SwitchToMapScriptsBank::
	ld a, [wMapScriptsBank]
	assert @ == Bankswitch, "cannot fall through to Bankswitch"
	; fallthrough

SECTION "rst08 Bankswitch", ROM0[$0008]
Bankswitch::
	ldh [hROMBank], a
	ld [rROMB], a
	ret

_de_::
	push de
DoNothing:: ; no-optimize stub function
	ret


SECTION "rst10 FarCall", ROM0[$0010]
FarCall::
; Call the following dab pointer.
; Preserves af, bc, de, hl.
	dec sp ; push space for the return bank
; Stack layout:
; +1 pointer to function address and bank followed by return location
; +0 nothing
	call _RstFarCall
; Stack layout:
; +1 return address
; +0 return bank
	jmp _ReturnFarCall

	ds 1 ; unused


SECTION "rst18 AddNTimes", ROM0[$0018]
AddNTimes::
	jmp _AddNTimes

FarCopyColorWRAM::
	ld a, BANK("GBC Video")
	; fallthrough

FarCopyWRAM::
	call StackCallInWRAMBankA
	assert @ == CopyBytes, "cannot fall through to CopyBytes"
	; fallthrough

SECTION "rst20 CopyBytes", ROM0[$0020]
CopyBytes::
	jmp _CopyBytes

GetFarByte::
; retrieve a single byte from a:hl, and return it in a.
	call StackCallInBankA

.Function:
	ld a, [hl]
	ret


SECTION "rst28 ByteFill", ROM0[$0028]
ByteFill::
	jmp _ByteFill

GetFarWRAMByte::
	call StackCallInWRAMBankA

.Function:
	ld a, [hl]
	ret


SECTION "rst30 PlaceString", ROM0[$0030]
PlaceString::
	jmp _PlaceString

SwapHLDE::
	push de
	ld d, h
	ld e, l
	pop hl
	ret


SECTION "rst38 Predef", ROM0[$0038]
Predef::
	jmp _Predef

IsAPokemon::
; For functions using EGG as sentinel, use "and a" instead (EGG is $ff)
; Returns carry if species a is not a Pokemon (including $ff)
	inc a
	cp 2 ; sets carry for $0 (inc'ed to $1) and $ff (inc'ed to $0)
	dec a
	ret


; Game Boy hardware interrupts

SECTION "vblank", ROM0[$0040]
	jmp VBlank

ItemIsMail::
; Returns carry if item d is a mail.
	assert FIRST_MAIL + NUM_MAILS - 1 == NUM_ITEMS, \
		"Not all items after FIRST_MAIL are mail"
	ld a, d
ItemIsMail_a::
	cp FIRST_MAIL
	ccf
	ret


SECTION "lcd", ROM0[$0048]
	push af
	jr hLCDInterruptFunction

GetMemCGBLayout::
	xor a ; CGB_RAM
GetCGBLayout::
	farjp LoadCGBLayout


SECTION "timer", ROM0[$0050]
; TIMER is never enabled

	reti ; just in case

PopAFBCDEHL::
	pop af
PopBCDEHL::
	pop bc
	pop de
	pop hl
	ret

ClearText::
	done


SECTION "serial", ROM0[$0058]
	jmp Serial


SECTION "High Home", ROM0[$005b]
;SECTION "joypad", ROM0[$0060]
; JOYPAD is never enabled

INCLUDE "home/jumptable.asm"


SECTION "Header", ROM0[$0100]

Start::
	nop ; no-optimize nops
	jr _Start

	; The rest of the header is handled by rgbfix.
	ds $014e - @, $00

RomHeaderChecksum::
	ds 2, $00

ENDSECTION
