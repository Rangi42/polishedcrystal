	db  55,  40,  40,  35,  65,  45
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, ELECTRIC
	db 235 ; catch rate
	db 59 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
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
	ev_yield   0,   0,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ATTRACT, ENDURE, FLASH, THUNDER_WAVE, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
