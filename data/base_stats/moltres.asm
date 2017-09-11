	db  90, 100,  90,  90, 125,  85
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FLYING
	db 3 ; catch rate
	db 217 ; base exp
	db LUM_BERRY ; item 1
	db LUM_BERRY ; item 2
	dn GENDERLESS, 15 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db PRESSURE ; ability 1
if DEF(FAITHFUL)
	db PRESSURE ; ability 2
else
	db DROUGHT ; ability 2
endc
	db FLAME_BODY ; hidden ability
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, SAFEGUARD, SOLAR_BEAM, RETURN, ROOST, DOUBLE_TEAM, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, STEEL_WING, ROCK_SMASH, ENDURE, WILL_O_WISP, GIGA_IMPACT, U_TURN, FLY, DOUBLE_EDGE, SLEEP_TALK, SWAGGER
	; end
