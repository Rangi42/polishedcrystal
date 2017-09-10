	db  30,  56,  35,  72,  25,  35
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL
	db 255 ; catch rate
	db 57 ; base exp
	db NO_ITEM ; item 1
	db ORAN_BERRY ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db RUN_AWAY ; ability 1
	db GUTS ; ability 2
	db HUSTLE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ATTRACT, THIEF, ROCK_SMASH, ENDURE, U_TURN, THUNDER_WAVE, CUT, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, ICY_WIND, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, ZEN_HEADBUTT
	; end
