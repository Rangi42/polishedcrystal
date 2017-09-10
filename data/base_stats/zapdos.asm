	db  90,  90,  85, 100, 125,  90
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, FLYING
	db 3 ; catch rate
	db 216 ; base exp
	db LUM_BERRY ; item 1
	db LUM_BERRY ; item 2
	dn GENDERLESS, 15 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db PRESSURE ; ability 1
if DEF(FAITHFUL)
	db PRESSURE ; ability 2
else
	db DRIZZLE ; ability 2
endc
	db STATIC ; hidden ability
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, ROOST, DOUBLE_TEAM, SANDSTORM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, WILD_CHARGE, REST, STEEL_WING, ROCK_SMASH, ENDURE, GIGA_IMPACT, U_TURN, FLASH, VOLT_SWITCH, THUNDER_WAVE, FLY, DOUBLE_EDGE, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
