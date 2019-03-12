; Game Boy hardware interrupts

SECTION "vblank", ROM0
	jp VBlank

GetFarWRAMByte::
	call StackCallInWRAMBankA

.Function:
	ld a, [hl]
	ret

SECTION "lcd", ROM0
	jp LCD

GetFarByte::
; retrieve a single byte from a:hl, and return it in a.
	call StackCallInBankA

.Function:
	ld a, [hl]
	ret

SECTION "timer", ROM0
	scf
	reti

SECTION "serial", ROM0
	jp Serial

SECTION "joypad", ROM0
	reti
