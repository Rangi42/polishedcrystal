if DEF(FAITHFUL)
	db  48,  48,  48,  48,  48,  48 ; 288 BST
	;   hp  atk  def  spe  sat  sdf
else
	db  78,  28,  48, 108,  28,  48 ; 338 BST
	;   hp  atk  def  spe  sat  sdf
endc

	db NORMAL, NORMAL ; type
	db 35 ; catch rate
	db 61 ; base exp
	db QUICK_POWDER, METAL_POWDER ; held items
	dn GENDER_UNKNOWN, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for DITTO, LIMBER, LIMBER, IMPOSTER
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_DITTO, EGG_DITTO ; egg groups

	ev_yield 1 HP

	; tm/hm learnset
	tmhm
	; end
