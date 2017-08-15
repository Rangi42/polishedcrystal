	db MANTINE ; 226

	db  85,  40,  70,  70,  80, 140
	;   hp  atk  def  spd  sat  sdf

	db WATER, FLYING
	db 25 ; catch rate
	db 168 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_50 ; gender
	db 25 ; step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db SWIFT_SWIM ; ability 1
	db WATER_ABSORB ; ability 2
	db WATER_VEIL ; hidden ability
	db SLOW ; growth rate
	dn AMPHIBIAN, AMPHIBIAN ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   2
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, EARTHQUAKE, RETURN, ROOST, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, SCALD, ENDURE, ACROBATICS, WATER_PULSE, GIGA_IMPACT, BULLDOZE, FLY, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, BODY_SLAM, DOUBLE_EDGE, HEADBUTT, ICY_WIND, IRON_HEAD, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
