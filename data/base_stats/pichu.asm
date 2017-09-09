	db  20,  40,  15,  60,  35,  35
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, ELECTRIC
	db 190 ; catch rate
	db 42 ; base exp
	db NO_ITEM ; item 1
	db LIGHT_BALL ; item 2
	dn FEMALE_50, 1 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db STATIC ; ability 1
	db STATIC ; ability 2
	db LIGHTNING_ROD ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ATTRACT, ENDURE, FLASH, VOLT_SWITCH, THUNDER_WAVE, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, PAY_DAY, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
