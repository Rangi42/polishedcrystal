if DEF(FAITHFUL)
	db  48,  48,  48,  48,  48,  48 ; 288 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  78,  28,  48, 108,  28,  48 ; 338 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, NORMAL ; type
	db 35 ; catch rate
	db 61 ; base exp
	db QUICK_POWDER ; item 1
	db METAL_POWDER ; item 2
	dn GENDER_UNKNOWN, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/ditto/front.dimensions"
	abilities_for DITTO, LIMBER, LIMBER, IMPOSTER
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_DITTO, EGG_DITTO ; egg groups

	ev_yield   1,   0,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm
	; end
