	db  90, 100,  90,  90, 125,  85 ; 580 BST
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FLYING
	db 3 ; catch rate
	db 217 ; base exp
	db ALWAYS_ITEM_2 ; item 1
	db LUM_BERRY ; item 2
	dn GENDERLESS, 15 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/moltres/front.dimensions"
if DEF(FAITHFUL)
	abilities_for MOLTRES, PRESSURE, PRESSURE, FLAME_BODY
else
	abilities_for MOLTRES, PRESSURE, DROUGHT, FLAME_BODY
endc
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, SAFEGUARD, SOLAR_BEAM, RETURN, ROCK_SMASH, DOUBLE_TEAM, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, FLAME_CHARGE, REST, STEEL_WING, ROOST, WILL_O_WISP, GIGA_IMPACT, U_TURN, FLY, DOUBLE_EDGE, ENDURE, SLEEP_TALK, SWAGGER
	; end
