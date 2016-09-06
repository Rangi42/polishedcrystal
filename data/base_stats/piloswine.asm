	db PILOSWINE ; 221

	db 100, 100,  80,  50,  60,  60
	;   hp  atk  def  spd  sat  sdf

	db ICE, GROUND
	db 75 ; catch rate
	db 160 ; base exp
	db ICE_BERRY ; item 1
	db NEVERMELTICE ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, REFLECT, SANDSTORM, STONE_EDGE, AVALANCHE, REST, ATTRACT, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, ENDURE, STRENGTH, ROCK_SMASH, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, ICY_WIND, SLEEP_TALK, SWAGGER
	; end
