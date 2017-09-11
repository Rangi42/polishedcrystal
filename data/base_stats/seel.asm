	db  65,  45,  55,  45,  45,  70
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 190 ; catch rate
	db 100 ; base exp
	db NO_ITEM ; item 1
	db RAWST_BERRY ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db THICK_FAT ; ability 1
	db HYDRATION ; ability 2
	db ICE_BODY ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, RETURN, DOUBLE_TEAM, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ENDURE, WATER_PULSE, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, BODY_SLAM, DOUBLE_EDGE, HEADBUTT, ICY_WIND, PAY_DAY, SLEEP_TALK, SWAGGER
	; end
