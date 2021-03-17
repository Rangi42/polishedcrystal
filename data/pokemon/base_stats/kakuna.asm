	db  45,  25,  50,  35,  25,  25 ; 205 BST
	;   hp  atk  def  spd  sat  sdf

	db BUG, POISON
	db 120 ; catch rate
	db 71 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/kakuna/front.dimensions"
	abilities_for KAKUNA, SHED_SKIN, SHED_SKIN, SHED_SKIN
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm
	; end
