	db MAMOSWINE ; 473

	db 110, 130,  80,  80,  70,  60
	;   hp  atk  def  spd  sat  sdf

	db ICE, GROUND
	db 50 ; catch rate
	db 207 ; base exp
	db ICE_BERRY ; item 1
	db NEVERMELTICE ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HIDDEN_POWER, ICY_WIND, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, REFLECT, SWAGGER, SANDSTORM, STONE_EDGE, AVALANCHE, REST, ATTRACT, ROCK_SLIDE, FURY_CUTTER, SUBSTITUTE, ENDURE, STRENGTH, ROCK_SMASH, EARTH_POWER, HEADBUTT, IRON_HEAD, SLEEP_TALK
	; end
