tilepal: MACRO
; vram bank, pals
x = \1 << 3
rept _NARG +- 1
	db (x | PAL_BG_\2)
	shift
endr
endm

tilecoll: MACRO
	db COLL_\1, COLL_\2, COLL_\3, COLL_\4
endm
