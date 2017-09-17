	db  61,  84,  65,  70,  70,  70
	;   hp  atk  def  spd  sat  sdf

	db DRAGON, DRAGON
	db 45 ; catch rate
	db 144 ; base exp
	db NO_ITEM ; item 1
	db DRAGON_SCALE ; item 2
	dn FEMALE_50, 7 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db SHED_SKIN ; ability 1
	db SHED_SKIN ; ability 2
	db MARVEL_SCALE ; hidden ability
	db SLOW ; growth rate
	dn AMPHIBIAN, REPTILE ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, ENDURE, DRAGON_PULSE, WATER_PULSE, THUNDER_WAVE, FLY, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, BODY_SLAM, DOUBLE_EDGE, HEADBUTT, ICY_WIND, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
