if DEF(FAITHFUL)
	db  45,  63,  37,  95,  65,  55 ; 360 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  50,  63,  37, 100,  65,  55 ; 370 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db ELECTRIC, ELECTRIC
	db 45 ; catch rate
	db 106 ; base exp
	db PERSIM_BERRY ; item 1
	db ELECTIRIZER ; item 2
	dn FEMALE_25, 4 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/elekid/front.dimensions"
	abilities_for ELEKID, STATIC, STATIC, VITAL_SPIRIT
	db MEDIUM_FAST ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, BULK_UP, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, ROCK_SMASH, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, WILD_CHARGE, FLASH, VOLT_SWITCH, THUNDER_WAVE, BODY_SLAM, COUNTER, DOUBLE_EDGE, ENDURE, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
