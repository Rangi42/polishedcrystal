FarCall    EQU $08
Bankswitch EQU $10
JumpTable  EQU $28
Predef     EQU $30

farcall: macro ; bank, address
	rst FarCall
	dbw BANK(\1), \1
endm

farjp: macro ; bank, address
	rst FarCall
	dbw BANK(\1) | $80, \1
endm

homecall: macro ; bank, address
	ld a, [hROMBank]
	push af
if _NARG == 2
	ld a, \2
else
	ld a, BANK(\1)
endc
	rst Bankswitch
	call \1
	pop af
	rst Bankswitch
endm
