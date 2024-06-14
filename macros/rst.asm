MACRO anonbankpush
	call AnonBankPush
	db BANK(\1)
ENDM

MACRO farcall ; bank, address
	rst FarCall
	dbw BANK(\1), \1
ENDM

MACRO farjp ; bank, address
	rst FarCall
	dbw BANK(\1) | $80, \1
ENDM

MACRO homecall ; bank, address
	ldh a, [hROMBank]
	push af
	if _NARG == 2
		if STRIN("\2", "[h") == 1 || STRIN("\2", "[r") == 1
			ldh a, \2
		else
			ld a, \2
		endc
	else
		ld a, BANK(\1)
	endc
	rst Bankswitch
	call \1
	pop af
	rst Bankswitch
ENDM
