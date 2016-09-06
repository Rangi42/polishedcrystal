	db ARCANINE ; 059

	db  90, 110,  80,  95, 100,  80
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 75 ; catch rate
	db 213 ; base exp
	db BURNT_BERRY ; item 1
	db BURNT_BERRY ; item 2
	db 63 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, SAFEGUARD, DRAGONBREATH, SOLAR_BEAM, IRON_TAIL, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, AERIAL_ACE, WILD_CHARGE, REST, ATTRACT, THIEF, SUBSTITUTE, BODY_SLAM, ENDURE, DRAGON_PULSE, WILL_O_WISP, STRENGTH, ROCK_SMASH, DOUBLE_EDGE, HEADBUTT, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
