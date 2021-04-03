add_predef: MACRO
	\1Predef::
	dbw BANK(\1), \1
ENDM

predef: MACRO
	rst Predef
	db (\1Predef - PredefPointers) / 3
ENDM

predef_jump: MACRO
	rst Predef
	db ((\1Predef - PredefPointers) / 3) | $80
ENDM
