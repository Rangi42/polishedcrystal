	db ELECTABUZZ ; 125

if DEF(FAITHFUL)
	db  65,  83,  57, 105,  95,  85
	;   hp  atk  def  spd  sat  sdf
else
	db  65,  88,  57, 105,  95,  85
	;   hp  atk  def  spd  sat  sdf
endc

	db ELECTRIC, ELECTRIC
	db 45 ; catch rate
	db 156 ; base exp
	db SITRUS_BERRY ; item 1
	db ELECTIRIZER ; item 2
	db 63 ; gender
	db 25 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db STATIC ; ability 1
	db STATIC ; ability 2
	db VITAL_SPIRIT ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   2,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, BULK_UP, HIDDEN_POWER, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, MUD_SLAP, DOUBLE_TEAM, SWIFT, FACADE, WILD_CHARGE, REST, ATTRACT, THIEF, ROCK_SMASH, FOCUS_BLAST, ENDURE, THUNDER_WAVE, GIGA_IMPACT, FLASH, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, SEISMIC_TOSS, SLEEP_TALK, SUBSTITUTE, SWAGGER, THUNDERPUNCH, VOLT_SWITCH, ZAP_CANNON
	; end
