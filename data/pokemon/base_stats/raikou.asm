	db  90,  85,  75, 115, 115, 100 ; 580 BST
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, ELECTRIC
	db 3 ; catch rate
	db 216 ; base exp
	db ALWAYS_ITEM_2 ; item 1
	db MAGNET ; item 2
	dn GENDERLESS, 15 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/raikou/front.dimensions"
if DEF(FAITHFUL)
	abilities_for RAIKOU, PRESSURE, PRESSURE, INNER_FOCUS
else
	abilities_for RAIKOU, PRESSURE, INNER_FOCUS, VOLT_ABSORB
endc
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	ev_yield   0,   0,   0,   2,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SANDSTORM, SWIFT, SUBSTITUTE, FACADE, REST, WILD_CHARGE, GIGA_IMPACT, FLASH, VOLT_SWITCH, THUNDER_WAVE, CUT, STRENGTH, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, IRON_HEAD, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
