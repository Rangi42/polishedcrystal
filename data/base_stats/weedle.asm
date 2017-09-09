	db  40,  35,  30,  50,  20,  20
	;   hp  atk  def  spd  sat  sdf

	db BUG, POISON
	db 255 ; catch rate
	db 52 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db SHIELD_DUST ; ability 1
	db SHIELD_DUST ; ability 2
	db RUN_AWAY ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm
	; end
