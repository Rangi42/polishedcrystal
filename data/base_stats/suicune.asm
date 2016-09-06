	db SUICUNE ; 245

	db 100,  75, 115,  85,  90, 115
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 3 ; catch rate
	db 215 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 255 ; gender
	db 100 ; unknown
	db 80 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, REFLECT, SANDSTORM, SWIFT, AVALANCHE, REST, SUBSTITUTE, BODY_SLAM, SCALD, ENDURE, CUT, SURF, WHIRLPOOL, WATERFALL, ROCK_SMASH, DOUBLE_EDGE, HEADBUTT, ICY_WIND, IRON_HEAD, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
