MACRO add_predef
	\1Predef::
	dbw BANK(\1), \1
ENDM

MACRO predef
	rst Predef
	db (\1Predef - PredefPointers) / 3
ENDM

MACRO predef_jump
	rst Predef
	db ((\1Predef - PredefPointers) / 3) | $80
ENDM
