	db  50,  20,  55,  30,  25,  25 ; 205 BST
	;   hp  atk  def  spd  sat  sdf

	db BUG, BUG
	db 120 ; catch rate
	db 72 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/metapod/front.dimensions"
	abilities_for METAPOD, SHED_SKIN, SHED_SKIN, SHED_SKIN
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm
	; end
