	db  60,  80,  50,  30,  40,  40 ; 300 BST
	;   hp  atk  def  spe  sat  sdf

	db FAIRY, FAIRY ; type
	db 190 ; catch rate
	db 63 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F75, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for SNUBBULL, INTIMIDATE, RUN_AWAY, RATTLED
	db GROWTH_FAST ; growth rate
	dn EGG_GROUND, EGG_FAIRY ; egg groups

	ev_yield 1 Atk

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, ROAR, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, BULLDOZE, SOLAR_BEAM, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, DIG, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, REFLECT, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, WILD_CHARGE, WATER_PULSE, THUNDER_WAVE, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, FIRE_PUNCH, HEADBUTT, HYPER_VOICE, ICE_PUNCH, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
