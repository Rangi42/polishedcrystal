	db SWINUB ; 220

	db  50,  50,  40,  50,  30,  30
	;   hp  atk  def  spd  sat  sdf

	db ICE, GROUND
	db 225 ; catch rate
	db 78 ; base exp
	db NO_ITEM ; item 1
	db ICE_BERRY ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HIDDEN_POWER, ICY_WIND, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, REFLECT, SWAGGER, SANDSTORM, DEFENSE_CURL, REST, ATTRACT, BODY_SLAM, ROCK_SLIDE, SUBSTITUTE, ENDURE, STRENGTH, ROCK_SMASH, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, SLEEP_TALK
	; end
