MACRO anonbankpush
	call AnonBankPush
	db BANK(\1)
	assert warn, BANK(\1) != 0, "unnecessary `anonbankpush \1`"
ENDM

MACRO farcall ; bank, address
	assert !(\1 & $8000), "cannot `farcall \1` in RAM"
	rst FarCall
	dwb \1, BANK(\1)
	assert warn, BANK(\1) != 0 && BANK(\1) != BANK(@), "unnecessary `farcall \1`"
ENDM

MACRO farjp ; bank, address
	assert !(\1 & $8000), "cannot `farjp \1` in RAM"
	rst FarCall
	dwb \1 | $8000, BANK(\1)
	assert warn, BANK(\1) != 0 && BANK(\1) != BANK(@), "unnecessary `farjp \1`"
ENDM

MACRO homecall ; bank, address
	ldh a, [hROMBank]
	push af
	if _NARG == 2
		if STRFIND("\2", "[h") == 0 || STRFIND("\2", "[r") == 0
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
	if _NARG == 1
		assert warn, BANK(\1) != 0, "unnecessary `homecall \1`"
	endc
ENDM
