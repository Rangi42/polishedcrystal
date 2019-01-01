	db  20,  10,  55,  80,  15,  20
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 255 ; catch rate
	db 20 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 0 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db SWIFT_SWIM ; ability 1
	db SWIFT_SWIM ; ability 2
	db RATTLED ; hidden ability
	db SLOW ; growth rate
	dn FISH, REPTILE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm
	; end
