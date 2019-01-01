	db  50,  50,  40,  50,  30,  30
	;   hp  atk  def  spd  sat  sdf

	db ICE, GROUND
	db 225 ; catch rate
	db 78 ; base exp
	db NO_ITEM ; item 1
	db RAWST_BERRY ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db OBLIVIOUS ; ability 1
	db SNOW_CLOAK ; ability 2
	db THICK_FAT ; hidden ability
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   1,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, BULLDOZE, EARTHQUAKE, RETURN, DIG, DOUBLE_TEAM, REFLECT, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, ROCK_SMASH, ENDURE, STRENGTH, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, ICY_WIND, SLEEP_TALK, SWAGGER
	; end
