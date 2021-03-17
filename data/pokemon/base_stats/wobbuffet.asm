	db 190,  33,  58,  33,  33,  58 ; 405 BST
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC
	db 45 ; catch rate
	db 177 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/wobbuffet/front.dimensions"
	abilities_for WOBBUFFET, SHADOW_TAG, SHADOW_TAG, SHADOW_TAG
	db MEDIUM_FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	ev_yield   2,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm SAFEGUARD, COUNTER
	; end
