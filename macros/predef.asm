MACRO add_predef
\1Predef::
	dwb \1, BANK(\1)
	assert warn, BANK(\1) != 0, "Predef in ROM0 \1"
ENDM

MACRO predef
	rst Predef
	db (\1Predef - PredefPointers) / 3
ENDM

MACRO predef_jump
	rst Predef
	db ((\1Predef - PredefPointers) / 3) | $80
ENDM
