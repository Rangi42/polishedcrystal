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
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db WATER_ABSORB ; ability 1
	db DAMP ; ability 2
	db DRIZZLE ; hidden ability
	db 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn AMPHIBIAN, AMPHIBIAN ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, EARTHQUAKE, RETURN, DIG, PSYCHIC, MUD_SLAP, DOUBLE_TEAM, REST, ATTRACT, THIEF, SUBSTITUTE, BODY_SLAM, FOCUS_BLAST, ENERGY_BALL, SCALD, ENDURE, SURF, STRENGTH, WHIRLPOOL, WATERFALL, ROCK_SMASH, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, HYPER_VOICE, ICE_PUNCH, ICY_WIND, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
