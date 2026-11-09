	bst 205,  45,  25,  50,  25,  25,  35
	;   bst   hp  atk  def  sat  sdf  spe

	db BUG, POISON ; type
	db 120 ; catch rate
	db 71 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

	abilities_for KAKUNA, SHED_SKIN, SHED_SKIN, SHED_SKIN
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	ev_yield 2 Def

	; tm/hm learnset
	tmhm
	; end
