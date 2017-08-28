tilepal: MACRO
; vram bank, pals
x = \1 << 3
rept (_NARG +- 1) / 2
	dn (x | PAL_BG_\3), (x | PAL_BG_\2)
	shift
	shift
endr
endm

tilepal_skip: MACRO
	tilepal 0, TEXT, TEXT, TEXT, TEXT, TEXT, TEXT, TEXT, TEXT
endm

tilecoll: MACRO
	db COLL_\1, COLL_\2, COLL_\3, COLL_\4
endm
