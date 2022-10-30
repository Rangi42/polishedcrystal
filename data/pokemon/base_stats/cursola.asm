	db  60,  95,  50,  30, 145, 130 ; 510 BST
	;   hp  atk  def  spe  sat  sdf

	db GHOST, GHOST ; type
	db 30 ; catch rate
	db 196 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F75, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for CURSOLA, WEAK_ARMOR, WEAK_ARMOR, PERISH_BODY
	db GROWTH_FAST ; growth rate
	dn EGG_WATER_1, EGG_WATER_3 ; egg groups

	ev_yield 2 SAt

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, GIGA_DRAIN, SAFEGUARD, BULLDOZE, EARTHQUAKE, RETURN, DIG, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, LEECH_LIFE, SCALD, WILL_O_WISP, WATER_PULSE, EXPLOSION, GIGA_IMPACT, STONE_EDGE, SURF, WHIRLPOOL, WATERFALL, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, ICY_WIND, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
