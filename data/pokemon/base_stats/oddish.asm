	db  45,  50,  55,  30,  75,  65 ; 320 BST
	;   hp  atk  def  spe  sat  sdf

	db GRASS, POISON ; type
	db 255 ; catch rate
	db 78 ; base exp
	db SILVER_LEAF, SILVER_LEAF ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for ODDISH, CHLOROPHYLL, CHLOROPHYLL, RUN_AWAY
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_PLANT, EGG_PLANT ; egg groups

	ev_yield 1 SAt

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, ENERGY_BALL, FLASH, SWORDS_DANCE, CUT, DOUBLE_EDGE, ENDURE, HYPER_VOICE, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
