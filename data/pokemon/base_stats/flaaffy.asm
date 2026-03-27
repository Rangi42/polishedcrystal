if DEF(FAITHFUL)
	bst 365,  70,  55,  55,  80,  60,  45
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 390,  75,  55,  60,  85,  65,  50
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db ELECTRIC, ELECTRIC ; type
if DEF(FAITHFUL)
	db 120 ; catch rate
	db 117 ; base exp
else
	db 110 ; catch rate
	db 127 ; base exp
endc
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

if DEF(FAITHFUL)
	abilities_for FLAAFFY, STATIC, STATIC, STATIC
else
	abilities_for FLAAFFY, STATIC, FLUFFY, MOTOR_DRIVE
endc
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_GROUND ; egg groups

	ev_yield 2 SAt

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, ROCK_SMASH, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, WILD_CHARGE, FLASH, VOLT_SWITCH, THUNDER_WAVE, STRENGTH, AGILITY, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
