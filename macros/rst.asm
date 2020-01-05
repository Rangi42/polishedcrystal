FarCall    EQU $08
Bankswitch EQU $10
AddNTimes  EQU $18
CopyBytes  EQU $20
JumpTable  EQU $28
Predef     EQU $30

anonbankpush: MACRO
	call AnonBankPush
	db BANK(\1)
ENDM

farcall: MACRO ; bank, address
	rst FarCall
	dbw BANK(\1), \1
ENDM

farjp: MACRO ; bank, address
	rst FarCall
	dbw BANK(\1) | $80, \1
ENDM

homecall: MACRO ; bank, address
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
ENDM
