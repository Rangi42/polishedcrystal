	db  73,  67,  75, 109,  81, 100 ; 505 BST
	;   hp  atk  def  spe  sat  sdf

	db ICE, FAIRY ; type
	db 75 ; catch rate
	db 178 ; base exp
	db ALWAYS_ITEM_2, ASPEAR_BERRY ; held items
	dn GENDER_F75, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for NINETALES_ALOLAN, SNOW_CLOAK, SNOW_CLOAK, SNOW_WARNING
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	ev_yield 1 Spe, 1 SDf

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, SAFEGUARD, SOLAR_BEAM, IRON_TAIL, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, DARK_PULSE, AVALANCHE, GIGA_IMPACT, AGILITY, BODY_SLAM, CHARM, DOUBLE_EDGE, DREAM_EATER, ENDURE, HEADBUTT, ICY_WIND, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT, CUT, FLY, SURF, WHIRLPOOL, FLASH
	; end

