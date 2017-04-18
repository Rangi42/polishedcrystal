	db POLITOED ; 186

if DEF(FAITHFUL)
	db  90,  75,  75,  70,  90, 100
	;   hp  atk  def  spd  sat  sdf
else
	db  90,  75,  80,  80,  90, 100
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db WATER, WATER
else
	db WATER, GRASS
endc
	db 45 ; catch rate
	db 185 ; base exp
	db NO_ITEM ; item 1
	db KINGS_ROCK ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db WATER_ABSORB ; ability 1
	db DAMP ; ability 2
	db DRIZZLE ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn AMPHIBIAN, AMPHIBIAN ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   3
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, EARTHQUAKE, RETURN, DIG, PSYCHIC, MUD_SLAP, DOUBLE_TEAM, FACADE, REST, ATTRACT, THIEF, ROCK_SMASH, FOCUS_BLAST, ENERGY_BALL, SCALD, ENDURE, GIGA_IMPACT, SURF, STRENGTH, WATERFALL, WHIRLPOOL, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, HYPER_VOICE, ICE_PUNCH, ICY_WIND, SEISMIC_TOSS, SLEEP_TALK, SUBSTITUTE, SWAGGER, WATER_PULSE
	; end
