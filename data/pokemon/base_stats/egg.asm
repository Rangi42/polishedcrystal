	db  10,  10,  10,  10,  10,  10 ; 60 BST
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL
	db 255 ; catch rate
	db 10 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 1 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/egg/front.dimensions"
	abilities_for EGG, NO_ABILITY, NO_ABILITY, NO_ABILITY
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	ev_yield   0,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm
	; end
