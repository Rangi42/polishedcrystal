if DEF(FAITHFUL)
	db  55,  45,  50,  80,  45,  65 ; 340 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  65,  45,  50,  80,  45,  65 ; 350 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db GRASS, FLYING ; type
	db 120 ; catch rate
	db 136 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/skiploom/front.dimensions"
	abilities_for SKIPLOOM, CHLOROPHYLL, LEAF_GUARD, INFILTRATOR
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_FAIRY, EGG_PLANT ; egg groups

	ev_yield   0,   0,   0,   2,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, REFLECT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, ENERGY_BALL, ACROBATICS, U_TURN, FLASH, SWORDS_DANCE, AGILITY, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, HEADBUTT, PAY_DAY, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
