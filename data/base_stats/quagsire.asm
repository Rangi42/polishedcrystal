	db QUAGSIRE ; 195

if DEF(FAITHFUL)
	db  95,  85,  85,  35,  65,  65
	;   hp  atk  def  spd  sat  sdf
else
	db  95,  95,  95,  35,  65,  65
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, GROUND
	db 90 ; catch rate
	db 137 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db DAMP ; ability 1
	db WATER_ABSORB ; ability 2
	db UNAWARE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, FIELD ; egg groups

	; ev_yield
	ev_yield   2,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, EARTHQUAKE, RETURN, DIG, DOUBLE_TEAM, SLUDGE_BOMB, SANDSTORM, STONE_EDGE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, ROCK_SMASH, FOCUS_BLAST, SCALD, ENDURE, GIGA_IMPACT, FLASH, SURF, STRENGTH, WATERFALL, WHIRLPOOL, AQUA_TAIL, BODY_SLAM, BULLDOZE, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, ICE_PUNCH, ICY_WIND, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SUBSTITUTE, SWAGGER, WATER_PULSE
	; end
