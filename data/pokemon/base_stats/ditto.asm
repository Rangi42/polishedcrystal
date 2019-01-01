if DEF(FAITHFUL)
	db  48,  48,  48,  48,  48,  48
	;   hp  atk  def  spd  sat  sdf
else
	db  78,  28,  48, 108,  28,  48
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, NORMAL
	db 35 ; catch rate
	db 61 ; base exp
	db QUICK_POWDER ; item 1
	db METAL_POWDER ; item 2
	dn GENDERLESS, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db LIMBER ; ability 1
	db LIMBER ; ability 2
	db IMPOSTER ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn LADIES_MAN, LADIES_MAN ; egg groups

	; ev_yield
	ev_yield   1,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm
	; end
