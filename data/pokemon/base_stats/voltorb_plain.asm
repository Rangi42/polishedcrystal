if DEF(FAITHFUL)
	bst 330,  40,  30,  50,  55,  55, 100
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 350,  40,  30,  50,  65,  65, 100
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db ELECTRIC, ELECTRIC ; type
	db 190 ; catch rate
	db 103 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_UNKNOWN, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for VOLTORB, SOUNDPROOF, STATIC, AFTERMATH
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	ev_yield 1 Spe

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, REFLECT, SWIFT, SUBSTITUTE, FACADE, REST, THIEF, WILD_CHARGE, EXPLOSION, FLASH, VOLT_SWITCH, THUNDER_WAVE, GYRO_BALL, AGILITY, ENDURE, HEADBUTT, ROLLOUT, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, ZAP_CANNON
	; end
