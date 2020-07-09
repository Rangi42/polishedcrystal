	db 100,  75, 115,  85,  90, 115 ; 580 BST
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 3 ; catch rate
	db 215 ; base exp
	db ALWAYS_ITEM_2 ; item 1
	db MYSTIC_WATER ; item 2
	dn GENDERLESS, 15 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db PRESSURE ; ability 1
if DEF(FAITHFUL)
	db PRESSURE ; ability 2
	db INNER_FOCUS ; hidden ability
else
	db INNER_FOCUS ; ability 2
	db WATER_ABSORB ; hidden ability
endc
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   0,   0,   1,   0,   0,   2
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, RETURN, DIG, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SANDSTORM, SWIFT, SUBSTITUTE, FACADE, REST, SCALD, WATER_PULSE, AVALANCHE, GIGA_IMPACT, CUT, SURF, WHIRLPOOL, WATERFALL, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, ICY_WIND, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
