if DEF(FAITHFUL)
	db  75, 123,  67,  95,  95,  85
	;   hp  atk  def  spd  sat  sdf
else
	db  75, 123,  67, 105,  95,  85
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db ELECTRIC, ELECTRIC
else
	db ELECTRIC, FIGHTING
endc
	db 30 ; catch rate
	db 199 ; base exp
	db SITRUS_BERRY ; item 1
	db SITRUS_BERRY ; item 2
	dn FEMALE_25, 4 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db MOTOR_DRIVE ; ability 1
	db MOTOR_DRIVE ; ability 2
	db VITAL_SPIRIT ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	; ev_yield
	ev_yield   0,   3,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, BULK_UP, HIDDEN_POWER, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, DIG, PSYCHIC, DOUBLE_TEAM, FLAMETHROWER, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ATTRACT, THIEF, ROCK_SLIDE, ROCK_SMASH, FOCUS_BLAST, ENDURE, GIGA_IMPACT, FLASH, VOLT_SWITCH, THUNDER_WAVE, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
