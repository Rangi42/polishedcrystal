if DEF(FAITHFUL)
	db  90,  95,  95,  70,  70,  90
	;   hp  atk  def  spd  sat  sdf
else
	db  90,  95, 100,  70,  70,  90
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, FIGHTING
	db 45 ; catch rate
	db 185 ; base exp
	db NO_ITEM ; item 1
	db KINGS_ROCK ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db WATER_ABSORB ; ability 1
	db DAMP ; ability 2
	db SWIFT_SWIM ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn AMPHIBIAN, AMPHIBIAN ; egg groups

	; ev_yield
	ev_yield   0,   0,   3,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HAIL, BULK_UP, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, EARTHQUAKE, RETURN, DIG, PSYCHIC, DOUBLE_TEAM, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, ROCK_SMASH, FOCUS_BLAST, SCALD, ENDURE, WATER_PULSE, POISON_JAB, GIGA_IMPACT, SURF, STRENGTH, WHIRLPOOL, WATERFALL, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, ICE_PUNCH, ICY_WIND, SEISMIC_TOSS, SLEEP_TALK, SWAGGER
	; end
