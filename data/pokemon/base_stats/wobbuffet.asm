	bst 405, 190,  33,  58,  33,  58,  33
	;   bst   hp  atk  def  sat  sdf  spe

	db PSYCHIC, PSYCHIC ; type
	db 45 ; catch rate
	db 177 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for WOBBUFFET, SHADOW_TAG, SHADOW_TAG, SHADOW_TAG
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	ev_yield 2 HP

	; tm/hm learnset
	tmhm SAFEGUARD, CHARM, COUNTER
	; end
