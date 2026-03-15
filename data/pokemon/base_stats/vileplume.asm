if DEF(FAITHFUL)
	bst 490,  75,  80,  85, 110,  90,  50
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 510,  75,  80,  85, 120, 100,  50
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db GRASS, POISON ; type
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 184 ; base exp
else
	db 192 ; base exp
endc
	db ALWAYS_ITEM_2, MIRACLE_SEED ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for VILEPLUME, CHLOROPHYLL, CHLOROPHYLL, EFFECT_SPORE
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_PLANT, EGG_PLANT ; egg groups

	ev_yield 3 SAt

	; tm/hm learnset
	tmhm CURSE, TOXIC, VENOSHOCK, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, ENERGY_BALL, DRAIN_PUNCH, GIGA_IMPACT, FLASH, SWORDS_DANCE, CUT, BODY_SLAM, CHARM, DOUBLE_EDGE, EARTH_POWER, ENDURE, HYPER_VOICE, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
