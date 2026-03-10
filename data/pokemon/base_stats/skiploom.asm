if DEF(FAITHFUL)
	bst 340,  55,  45,  50,  45,  65,  80
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 360,  55,  45,  50,  55,  65,  90
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db GRASS, FLYING ; type
	db 120 ; catch rate
	db 136 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

if DEF(FAITHFUL)
	abilities_for SKIPLOOM, CHLOROPHYLL, LEAF_GUARD, INFILTRATOR
else
	abilities_for SKIPLOOM, CHLOROPHYLL, WIND_RIDER, INFILTRATOR
endc
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_FAIRY, EGG_PLANT ; egg groups

	ev_yield 2 Spe

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, REFLECT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, ENERGY_BALL, ACROBATICS, U_TURN, FLASH, SWORDS_DANCE, AGILITY, BATON_PASS, CHARM, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, HEADBUTT, PAY_DAY, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
