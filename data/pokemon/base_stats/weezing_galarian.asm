	db  65,  90, 120,  60,  85,  70 ; 490 BST
	;   hp  atk  def  spd  sat  sdf

	db POISON, FAIRY ; type
	db 60 ; catch rate
	db 173 ; base exp
	db NO_ITEM ; item 1
	db SMOKE_BALL ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/weezing_galarian/front.dimensions"
	abilities_for WEEZING_GALARIAN, LEVITATE, NEUTRALIZING_GAS, WHITE_SMOKE
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	ev_yield   0,   0,   2,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, DARK_PULSE, WILL_O_WISP, EXPLOSION, GIGA_IMPACT, FLASH, GYRO_BALL, ENDURE, ROLLOUT, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
