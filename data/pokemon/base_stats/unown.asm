	db  48,  72,  48,  48,  72,  48
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC
	db 225 ; catch rate
	db 61 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDERLESS, 7 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db LEVITATE ; ability 1
	db LEVITATE ; ability 2
	db LEVITATE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   0,   1,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm HIDDEN_POWER
	; end
