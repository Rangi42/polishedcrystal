	db  65,  65,  60, 130, 110,  95
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, ELECTRIC
	db 45 ; catch rate
	db 197 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 6 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db VOLT_ABSORB ; ability 1
if DEF(FAITHFUL)
	db VOLT_ABSORB ; ability 2
else
	db STATIC ; ability 2
endc
	db QUICK_FEET ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   2,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ATTRACT, ROCK_SMASH, ENDURE, GIGA_IMPACT, FLASH, VOLT_SWITCH, THUNDER_WAVE, STRENGTH, BODY_SLAM, DOUBLE_EDGE, HEADBUTT, HYPER_VOICE, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
