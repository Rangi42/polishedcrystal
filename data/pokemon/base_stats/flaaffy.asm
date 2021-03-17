if DEF(FAITHFUL)
	db  70,  55,  55,  45,  80,  60 ; 365 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  70,  60,  60,  50,  85,  65 ; 390 BST
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
	INCBIN "gfx/pokemon/flaaffy/front.dimensions"
if DEF(FAITHFUL)
	abilities_for FLAAFFY, STATIC, STATIC, STATIC
else
	abilities_for FLAAFFY, STATIC, STATIC, MOTOR_DRIVE
endc
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, FIELD ; egg groups

	ev_yield   0,   0,   0,   0,   2,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, ROCK_SMASH, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, WILD_CHARGE, FLASH, VOLT_SWITCH, THUNDER_WAVE, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
