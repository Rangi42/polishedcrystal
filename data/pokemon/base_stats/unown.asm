	db  48,  72,  48,  48,  72,  48 ; 336 BST
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC
	db 225 ; catch rate
	db 61 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDERLESS, 7 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/unown_a/front.dimensions"
	abilities_for UNOWN, LEVITATE, LEVITATE, LEVITATE
	db MEDIUM_FAST ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	ev_yield   0,   1,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm HIDDEN_POWER
	; end
