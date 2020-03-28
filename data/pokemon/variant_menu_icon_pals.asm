variconpal: MACRO
	db \1, \2
	dn PAL_OW_\3, PAL_OW_\4
ENDM

VariantMenuMonIconColorsTable:
	variconpal GYARADOS, GYARADOS_RED_FORM, RED, RED
	db -1
