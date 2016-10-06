FarCall    EQU $08
Bankswitch EQU $10
JumpTable  EQU $28

farcall: MACRO ; bank, address
	ld a, BANK(\1)
	ld hl, \1
	rst FarCall
	ENDM
