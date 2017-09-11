if DEF(FAITHFUL)
	db  35,  55,  40,  90,  50,  50
	;   hp  atk  def  spd  sat  sdf
else
	db  35,  65,  40,  95,  60,  50
	;   hp  atk  def  spd  sat  sdf
endc

	db ELECTRIC, ELECTRIC
	db 190 ; catch rate
if DEF(FAITHFUL)
	db 82 ; base exp
else
	db 92 ; base exp
endc
	db NO_ITEM ; item 1
	db ORAN_BERRY ; item 2
	dn FEMALE_50, 1 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db STATIC ; ability 1
	db STATIC ; ability 2
	db LIGHTNING_ROD ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FAERY ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   2,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ATTRACT, ROCK_SMASH, ENDURE, FLASH, VOLT_SWITCH, THUNDER_WAVE, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, KNOCK_OFF, PAY_DAY, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
