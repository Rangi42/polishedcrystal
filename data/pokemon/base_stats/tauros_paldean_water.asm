if DEF(FAITHFUL)
	bst 490,  75, 110, 105,  30,  70, 100
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 500,  75, 110, 105,  40,  70, 100
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db FIGHTING, WATER ; type
	db 45 ; catch rate
	db 211 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F0, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for TAUROS_PALDEAN_WATER, INTIMIDATE, ANGER_POINT, CUD_CHEW
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	ev_yield 1 Atk, 1 Spe

	; tm/hm learnset
	tmhm CURSE, TOXIC, BULK_UP, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, ROCK_SMASH, DOUBLE_TEAM, SUBSTITUTE, FACADE, REST, ATTRACT, WILD_CHARGE, WATER_PULSE, GIGA_IMPACT, SURF, STRENGTH, WHIRLPOOL, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, ICY_WIND, IRON_HEAD, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
