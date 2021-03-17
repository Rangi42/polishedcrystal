if DEF(FAITHFUL)
	db  60,  85,  50, 110,  95,  80 ; 480 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  60,  95,  50, 121, 105,  85 ; 516 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db ELECTRIC, PSYCHIC
	db 75 ; catch rate
if DEF(FAITHFUL)
	db 122 ; base exp
else
	db 179 ; base exp
endc
	db ORAN_BERRY ; item 1
	db LIGHT_BALL ; item 2
	dn FEMALE_50, 1 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/raichu_alolan/front.dimensions"
	abilities_for RAICHU_ALOLAN, STATIC, STATIC, MOTOR_DRIVE
	db MEDIUM_FAST ; growth rate
	dn FIELD, FAERY ; egg groups

	ev_yield   0,   0,   0,   3,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, PSYCHIC, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, FOCUS_BLAST, WILD_CHARGE, GIGA_IMPACT, FLASH, VOLT_SWITCH, THUNDER_WAVE, SURF, STRENGTH, AGILITY, BODY_SLAM, CHARM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, HEADBUTT, KNOCK_OFF, PAY_DAY, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
