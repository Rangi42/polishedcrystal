	db  80, 120, 130,  45,  55,  65 ; 495 BST
	;   hp  atk  def  spe  sat  sdf

	db ROCK, ELECTRIC ; type
	db 45 ; catch rate
	db 177 ; base exp
	db EVERSTONE, LINKING_CORD ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

	abilities_for GOLEM_ALOLAN, MAGNET_PULL, STURDY, GALVANIZE
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	ev_yield 3 Def

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, BULLDOZE, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, FOCUS_BLAST, WILD_CHARGE, EXPLOSION, GIGA_IMPACT, STONE_EDGE, VOLT_SWITCH, THUNDER_WAVE, GYRO_BALL, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, FIRE_PUNCH, HEADBUTT, IRON_HEAD, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, THUNDERPUNCH, CUT, FLY, SURF, WHIRLPOOL, FLASH
	; end
