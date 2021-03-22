	db 190,  33,  58,  33,  33,  58 ; 405 BST
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC ; type
	db 45 ; catch rate
	db 177 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/wobbuffet/front.dimensions"
	abilities_for WOBBUFFET, SHADOW_TAG, SHADOW_TAG, SHADOW_TAG
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	ev_yield   2,   0,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm SAFEGUARD, COUNTER
	; end
