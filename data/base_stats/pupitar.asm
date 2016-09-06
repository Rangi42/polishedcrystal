	db PUPITAR ; 247

	db  70,  84,  70,  51,  65,  70
	;   hp  atk  def  spd  sat  sdf

	db ROCK, GROUND
	db 45 ; catch rate
	db 144 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 40 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn MONSTER, MONSTER ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, IRON_TAIL, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SANDSTORM, STONE_EDGE, REST, ATTRACT, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, DARK_PULSE, ENDURE, ROCK_SMASH, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
