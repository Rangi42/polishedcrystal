FarCall    EQU $08
Bankswitch EQU $10
JumpTable  EQU $28

farcall: MACRO ; bank, address
	rst FarCall
	dbw BANK(\1), \1
	ENDM
