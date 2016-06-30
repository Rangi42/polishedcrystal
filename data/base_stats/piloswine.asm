	db PILOSWINE ; 221

	db 100, 100,  80,  50,  60,  60
	;   hp  atk  def  spd  sat  sdf

	db ICE, GROUND
	db 75 ; catch rate
	db 160 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, ICY_WIND, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, REFLECT, SWAGGER, SANDSTORM, DEFENSE_CURL, STONE_EDGE, AVALANCHE, REST, ATTRACT, BODY_SLAM, ROCK_SLIDE, SUBSTITUTE, ENDURE, STRENGTH, ROCK_SMASH, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, SLEEP_TALK
	; end
