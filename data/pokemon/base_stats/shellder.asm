	db  30,  65, 100,  40,  45,  25
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 190 ; catch rate
	db 97 ; base exp
	db PEARL ; item 1
	db BIG_PEARL ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db SHELL_ARMOR ; ability 1
	db SKILL_LINK ; ability 2
	db OVERCOAT ; hidden ability
	db SLOW ; growth rate
	dn INVERTEBRATE, INVERTEBRATE ; egg groups

	; ev_yield
	ev_yield   0,   0,   1,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, ENDURE, WATER_PULSE, EXPLOSION, AVALANCHE, SURF, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, ICY_WIND, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
