if DEF(FAITHFUL)
	db  70,  55,  55,  45,  80,  60
	;   hp  atk  def  spd  sat  sdf
else
	db  70,  60,  60,  45,  85,  65
	;   hp  atk  def  spd  sat  sdf
endc

	db ELECTRIC, ELECTRIC
if DEF(FAITHFUL)
	db 120 ; catch rate
	db 117 ; base exp
else
	db 110 ; catch rate
	db 127 ; base exp
endc
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db STATIC ; ability 1
	db STATIC ; ability 2
if DEF(FAITHFUL)
	db STATIC ; hidden ability
else
	db MOTOR_DRIVE ; hidden ability
endc
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   2,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ATTRACT, DAZZLINGLEAM, ROCK_SMASH, ENDURE, FLASH, VOLT_SWITCH, THUNDER_WAVE, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
