BadEggRLE:
	db UNOWN, 1 ; $c6
	db $00, 1
	db HIDDEN_POWER, 1 ; $ed
	db $00, 17
	db ABILITY_1 | QUIRKY, 1 ; $38
	db MALE | IS_EGG_MASK | UNOWN_QUESTION_FORM, 1 ; $68
	db $00, 9
	db EGG_LEVEL, 1 ; $01
	db $00, 16
	db "B", 1 ; $81
	db "a", 1 ; $a0
	db "d", 1 ; $a3
	db " ", 1 ; $7f
	db "E", 1 ; $84
	db "g", 2 ; $a6
	db "@", 4 ; $53
	db "?", 1 ; $9e
	db "@", 7 ; $53
	db $00, 3
	db $ff ; end
