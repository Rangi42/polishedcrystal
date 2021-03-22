	db  20,  10,  55,  80,  15,  20 ; 200 BST
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER ; type
	db 255 ; catch rate
	db 20 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F50, 0 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/magikarp_plain/front.dimensions"
	abilities_for MAGIKARP, SWIFT_SWIM, SWIFT_SWIM, RATTLED
	db GROWTH_SLOW ; growth rate
	dn EGG_WATER_2, EGG_DRAGON ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm
	; end
