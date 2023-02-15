	db  65,  90, 120,  60,  85,  70 ; 490 BST
	;   hp  atk  def  spe  sat  sdf

	db POISON, FAIRY ; type
	db 60 ; catch rate
	db 173 ; base exp
	db NO_ITEM, SMOKE_BALL ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for WEEZING_GALARIAN, LEVITATE, NEUTRALIZING_GAS, WHITE_SMOKE
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	ev_yield 2 Def

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, DARK_PULSE, WILL_O_WISP, EXPLOSION, GIGA_IMPACT, FLASH, GYRO_BALL, ENDURE, ROLLOUT, SLEEP_TALK, SWAGGER, ZAP_CANNON, CUT, FLY, SURF, WHIRLPOOL, FLASH
	; end
