	db  60,  50,  70, 150,  80,  80 ; 490 BST
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, ELECTRIC ; type
	db 60 ; catch rate
	db 150 ; base exp
	db NO_ITEM ; item 1
	db CELL_BATTERY ; item 2
	dn GENDER_UNKNOWN, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/electrode/front.dimensions"
	abilities_for ELECTRODE, SOUNDPROOF, STATIC, AFTERMATH
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	ev_yield   0,   0,   0,   2,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, REFLECT, SWIFT, SUBSTITUTE, FACADE, REST, THIEF, WILD_CHARGE, EXPLOSION, GIGA_IMPACT, FLASH, VOLT_SWITCH, THUNDER_WAVE, GYRO_BALL, ENDURE, HEADBUTT, ROLLOUT, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, ZAP_CANNON
	; end
