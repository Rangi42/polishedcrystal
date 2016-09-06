	db WARTORTLE ; 008

	db  59,  63,  80,  58,  65,  80
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 45 ; catch rate
	db 143 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 31 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, AMPHIBIAN ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, REST, ATTRACT, SUBSTITUTE, BODY_SLAM, SCALD, ENDURE, DRAGON_PULSE, SURF, STRENGTH, WHIRLPOOL, WATERFALL, ROCK_SMASH, AQUA_TAIL, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, ICE_PUNCH, ICY_WIND, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, WATER_PULSE, ZEN_HEADBUTT
	; end
