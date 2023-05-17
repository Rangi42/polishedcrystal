	db  30,  65, 100,  40,  45,  25 ; 305 BST
	;   hp  atk  def  spe  sat  sdf

	db WATER, WATER ; type
	db 190 ; catch rate
	db 97 ; base exp
	db PEARL, BIG_PEARL ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for SHELLDER, SHELL_ARMOR, SKILL_LINK, OVERCOAT
	db GROWTH_SLOW ; growth rate
	dn EGG_WATER_3, EGG_WATER_3 ; egg groups

	ev_yield 1 Def

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, WATER_PULSE, EXPLOSION, AVALANCHE, SURF, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, ENDURE, ICY_WIND, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
