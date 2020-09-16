if DEF(FAITHFUL)
	db  90,  75,  85,  55, 115,  90 ; 510 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  95,  75,  90,  65, 125,  95 ; 545 BST
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db ELECTRIC, ELECTRIC
	db 45 ; catch rate
	db 194 ; base exp
else
	db ELECTRIC, DRAGON
	db 40 ; catch rate
	db 204 ; base exp
endc
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/ampharos/front.dimensions"
	abilities_for AMPHAROS, STATIC, STATIC, MOLD_BREAKER
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, FIELD ; egg groups

	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, BULLDOZE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, ROCK_SMASH, DOUBLE_TEAM, FLASH_CANNON, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, FOCUS_BLAST, WILD_CHARGE, DRAGON_PULSE, GIGA_IMPACT, FLASH, VOLT_SWITCH, THUNDER_WAVE, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
