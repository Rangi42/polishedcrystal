	db ELECTIVIRE ; 466

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
	db 63 ; gender
	db 25 ; step cycles to hatch
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
	tmhm DYNAMICPUNCH, CURSE, TOXIC, BULK_UP, HIDDEN_POWER, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, DIG, PSYCHIC, MUD_SLAP, DOUBLE_TEAM, FLAMETHROWER, SWIFT, WILD_CHARGE, REST, ATTRACT, THIEF, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, FOCUS_BLAST, ENDURE, THUNDER_WAVE, STRENGTH, FLASH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
