if DEF(FAITHFUL)
	db  65,  55,  95,  35,  65,  95
	;   hp  atk  def  spd  sat  sdf
else
	db  65,  55, 115,  35, 105, 115
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, ROCK
	db 60 ; catch rate
if DEF(FAITHFUL)
	db 113 ; base exp
else
	db 128 ; base exp
endc
	db NO_ITEM ; item 1
	db HARD_STONE ; item 2
	dn FEMALE_75, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db HUSTLE ; ability 1
	db NATURAL_CURE ; ability 2
	db REGENERATOR ; hidden ability
	db FAST ; growth rate
	dn AMPHIBIAN, INVERTEBRATE ; egg groups

	; ev_yield
	ev_yield   0,   0,   1,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, BULLDOZE, EARTHQUAKE, RETURN, DIG, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, ROCK_SMASH, SCALD, ENDURE, WATER_PULSE, EXPLOSION, STONE_EDGE, SURF, STRENGTH, WHIRLPOOL, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, ICY_WIND, ROLLOUT, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
