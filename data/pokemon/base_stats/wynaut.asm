	db  95,  23,  48,  23,  23,  48 ; 260 BST
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC ; type
	db 125 ; catch rate
	db 44 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/wynaut/front.dimensions"
	abilities_for WYNAUT, SHADOW_TAG, SHADOW_TAG, SHADOW_TAG
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	ev_yield   1,   0,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm SAFEGUARD, COUNTER
	; end
