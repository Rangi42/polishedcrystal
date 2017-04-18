	db PIKACHU ; 025

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
	db FEMALE_50 ; gender
	db 10 ; step cycles to hatch
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
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SWIFT, FACADE, WILD_CHARGE, REST, ATTRACT, ROCK_SMASH, ENDURE, THUNDER_WAVE, FLASH, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, PAY_DAY, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SUBSTITUTE, SWAGGER, THUNDERPUNCH, VOLT_SWITCH, ZAP_CANNON
	; end
