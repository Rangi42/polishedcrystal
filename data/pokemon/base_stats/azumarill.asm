if DEF(FAITHFUL)
	db 100,  50,  80,  50,  60,  80
	;   hp  atk  def  spd  sat  sdf
else
	db 100,  50,  80,  50,  90,  80
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, FAIRY
	db 75 ; catch rate
if DEF(FAITHFUL)
	db 153 ; base exp
else
	db 183 ; base exp
endc
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db THICK_FAT ; ability 1
	db HUGE_POWER ; ability 2
	db SAP_SIPPER ; hidden ability
	db FAST ; growth rate
	dn AMPHIBIAN, FAERY ; egg groups

	; ev_yield
	ev_yield   3,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, RETURN, DIG, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SMASH, FOCUS_BLAST, SCALD, ENDURE, WATER_PULSE, GIGA_IMPACT, SURF, STRENGTH, WHIRLPOOL, WATERFALL, AQUA_TAIL, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, HYPER_VOICE, ICE_PUNCH, ICY_WIND, KNOCK_OFF, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER
	; end
