if DEF(FAITHFUL)
	db  80, 105,  65,  70, 100,  70 ; 490 BST
	;   hp  atk  def  spe  sat  sdf
else
	db  80, 115,  65,  70, 110,  70 ; 510 BST
	;   hp  atk  def  spe  sat  sdf
endc

	db GRASS, POISON ; type
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 191 ; base exp
else
	db 199 ; base exp
endc
	db ALWAYS_ITEM_2, BIG_ROOT ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for VICTREEBEL, CHLOROPHYLL, CHLOROPHYLL, GLUTTONY
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_PLANT, EGG_PLANT ; egg groups

	ev_yield 3 Atk

	; tm/hm learnset
	tmhm CURSE, TOXIC, VENOSHOCK, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, ENERGY_BALL, POISON_JAB, GIGA_IMPACT, FLASH, SWORDS_DANCE, CUT, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, ENDURE, KNOCK_OFF, SEED_BOMB, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
