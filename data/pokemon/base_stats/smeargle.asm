if DEF(FAITHFUL)
	db  55,  20,  35,  75,  20,  45 ; 250 BST
	;   hp  atk  def  spe  sat  sdf
else
	db  55,  20,  35, 100,  20,  45 ; 275 BST
	;   hp  atk  def  spe  sat  sdf
endc

	db NORMAL, NORMAL ; type
	db 45 ; catch rate
	db 106 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for SMEARGLE, OWN_TEMPO, TECHNICIAN, MOODY
	db GROWTH_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	ev_yield 1 Spe

	; tm/hm learnset
	tmhm
	; end
