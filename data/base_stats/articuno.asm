	db ARTICUNO ; 144

	db  90,  85, 100,  85,  95, 125
	;   hp  atk  def  spd  sat  sdf

	db ICE, FLYING
	db 3 ; catch rate
	db 215 ; base exp
	db MIRACLEBERRY ; item 1
	db MIRACLEBERRY ; item 2
	db 255 ; gender
	db 100 ; unknown
	db 80 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICY_WIND, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, MUD_SLAP, DOUBLE_TEAM, REFLECT, SWAGGER, SANDSTORM, SWIFT, AVALANCHE, REST, SUBSTITUTE, STEEL_WING, ENDURE, FLY, ROCK_SMASH, DOUBLE_EDGE, SLEEP_TALK
	; end
