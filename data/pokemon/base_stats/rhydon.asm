if DEF(FAITHFUL)
	db 105, 130, 120,  40,  45,  45
	;   hp  atk  def  spd  sat  sdf
else
	db 110, 135, 125,  40,  48,  48
	;   hp  atk  def  spd  sat  sdf
endc

	db GROUND, ROCK
	db 60 ; catch rate
	db 204 ; base exp
	db NO_ITEM ; item 1
	db PROTECTOR ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
if DEF(FAITHFUL)
	db LIGHTNING_ROD ; ability 1
	db ROCK_HEAD ; ability 2
else
	db ROCK_HEAD ; ability 1
	db SOLID_ROCK ; ability 2
endc
	db RECKLESS ; hidden ability
	db SLOW ; growth rate
	dn MONSTER, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, DIG, DOUBLE_TEAM, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, ROCK_SMASH, FOCUS_BLAST, ENDURE, DRAGON_PULSE, SHADOW_CLAW, POISON_JAB, AVALANCHE, GIGA_IMPACT, STONE_EDGE, SWORDS_DANCE, CUT, SURF, STRENGTH, WHIRLPOOL, AQUA_TAIL, BODY_SLAM, COUNTER, DOUBLE_EDGE, EARTH_POWER, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, ICY_WIND, PAY_DAY, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
