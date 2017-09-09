	db  45,  25,  50,  35,  25,  25
	;   hp  atk  def  spd  sat  sdf

	db BUG, POISON
	db 120 ; catch rate
	db 71 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db SHED_SKIN ; ability 1
	db SHED_SKIN ; ability 2
	db SHED_SKIN ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; ev_yield
	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm
	; end
