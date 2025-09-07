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
; Switches to the ROM bank in `a`
; @input `a` = ROM bank to switch to
Bankswitch::
	ldh [hROMBank], a
	ld [MBC3RomBank], a
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
; Adds `bc * a` to `hl`
; @input `hl` = Base value
; @input `bc` = Increment to add
; @input `a` = Amount of increment to add
; @output `hl` -> `hl + (bc * a)`
; @clobbers: `a`, `hl`
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
; Copies `bc` bytes from `hl` to `de`
; @input `hl` = Source
; @input `de` = Destination
; @input `bc` = Amount to copy
; @clobbers `a`, `hl`, `bc`, `de`
CopyBytes::
	jmp _CopyBytes

; Retrieves a single byte from `a:hl`, and returns it in `a`
; @input `a` = ROM Bank
; @input `hl` = Address
; @output `a` -> The value at `a:hl`
; @clobbers `a`
GetFarByte::
	call StackCallInBankA

.Function:
	ld a, [hl]
	ret


SECTION "rst28 ByteFill", ROM0[$0028]
; Fills `bc` bytes with the value of `a`, starting at `hl`.
; @input `hl` = Address to start filling from
; @input `bc` = How many bytes to fill
; @input `a` = Value to fill with
; @clobbers `hl`, `bc`
ByteFill::
	jmp _ByteFill

; Retrieves a single byte from `a:hl`, and returns it in `a`
; @input `a` = WRAM Bank
; @input `hl` = Address
; @output `a` -> The value at `a:hl`
; @clobbers `a`
GetFarWRAMByte::
	call StackCallInWRAMBankA

.Function:
	ld a, [hl]
	ret


SECTION "rst30 PlaceString", ROM0[$0030]
PlaceString::
	jmp _PlaceString

; Swaps the contents of `hl` and `de`
; @input `hl` = Value to put in `de`
; @input `de` = Value to put in `hl`
; @output `hl` -> Input `de`
; @output `de` -> Input `hl`
; @clobbers `hl`, `de`
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

; Pops, in order, `af`, `bc`, `de`, and `hl` from the stack.
; This should not be `call`ed, only jumped to.
; Calling will push the return address to the stack.
; @output `af` -> First item on the stack
; @output `bc` -> Second item on the stack
; @output `de` -> Third item on the stack
; @output `hl` -> Fourth item on the stack
; @clobbers `af`, `hl`, `bc`, `de`
PopAFBCDEHL::
	pop af
; Pops, in order, `bc`, `de`, and `hl` from the stack.
; This should not be `call`ed, only jumped to.
; Calling will push the return address to the stack.
; @output `bc` -> First item on the stack
; @output `de` -> Second item on the stack
; @output `hl` -> Third item on the stack
; @clobbers `hl`, `bc`, `de`
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

if DEF(ANALOGUE_POCKET)
	; Use specialized logo for Analogue Pocket compatibility.
	ds $0104 - @, $00
	db $01, $10, $ce, $ef, $00, $00, $44, $aa, $00, $74, $00, $18, $11, $95, $00, $34
	db $00, $1a, $00, $d5, $00, $22, $00, $69, $6f, $f6, $f7, $73, $09, $90, $e1, $10
	db $44, $40, $9a, $90, $d5, $d0, $44, $30, $a9, $21, $5d, $48, $22, $e0, $f8, $60
endc

	; The rest of the header is handled by rgbfix.
	ds $014e - @, $00

RomHeaderChecksum::
	ds 2, $00

ENDSECTION
