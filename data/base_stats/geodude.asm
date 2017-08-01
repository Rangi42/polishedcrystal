	db GEODUDE ; 074

	db  40,  80, 100,  20,  30,  30
	;   hp  atk  def  spd  sat  sdf

	db ROCK, GROUND
	db 255 ; catch rate
	db 86 ; base exp
	db NO_ITEM ; item 1
	db EVERSTONE ; item 2
	db FEMALE_50 ; gender
	db 15 ; step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db ROCK_HEAD ; ability 1
	db STURDY ; ability 2
	db SAND_VEIL ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	; ev_yield
	ev_yield   0,   0,   1,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, EARTHQUAKE, RETURN, DIG, DOUBLE_TEAM, FLAMETHROWER, SANDSTORM, FIRE_BLAST, STONE_EDGE, FACADE, REST, ATTRACT, ROCK_SLIDE, ROCK_SMASH, ENDURE, EXPLOSION, STRENGTH, BODY_SLAM, BULLDOZE, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, FIRE_PUNCH, HEADBUTT, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SUBSTITUTE, SUCKER_PUNCH, SWAGGER, THUNDERPUNCH
	; end
