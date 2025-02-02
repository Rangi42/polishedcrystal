if DEF(FAITHFUL)
	db  75,  80,  95,  50,  90, 100 ; 490 BST
	;   hp  atk  def  spe  sat  sdf
else
	db  75,  80,  95,  50, 100, 110 ; 510 BST
	;   hp  atk  def  spe  sat  sdf
endc

if DEF(FAITHFUL)
	db GRASS, GRASS ; type
else
	db GRASS, FAIRY ; type
endc
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 184 ; base exp
else
	db 192 ; base exp
endc
	db NO_ITEM, MIRACLE_SEED ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

if DEF(FAITHFUL)
	abilities_for BELLOSSOM, CHLOROPHYLL, CHLOROPHYLL, CHLOROPHYLL
else
	abilities_for BELLOSSOM, CHLOROPHYLL, CHLOROPHYLL, OWN_TEMPO
endc
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_PLANT, EGG_PLANT ; egg groups

	ev_yield 3 SDf

	; tm/hm learnset
	tmhm CURSE, TOXIC, VENOSHOCK, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, ENERGY_BALL, DRAIN_PUNCH, GIGA_IMPACT, FLASH, SWORDS_DANCE, CUT, BATON_PASS, CHARM, DOUBLE_EDGE, EARTH_POWER, ENDURE, HYPER_VOICE, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
