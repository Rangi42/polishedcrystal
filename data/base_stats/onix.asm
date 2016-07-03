	db ONIX ; 095

	db  35,  45, 160,  70,  30,  45
	;   hp  atk  def  spd  sat  sdf

	db ROCK, GROUND
	db 45 ; catch rate
	db 108 ; base exp
	db NO_ITEM ; item 1
	db HARD_STONE ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	; tmhm
	tmhm CURSE, ROAR, TOXIC, ROLLOUT, HIDDEN_POWER, SUNNY_DAY, PROTECT, DRAGONBREATH, IRON_TAIL, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SANDSTORM, STONE_EDGE, REST, ATTRACT, BODY_SLAM, ROCK_SLIDE, SUBSTITUTE, FLASH_CANNON, ENDURE, DRAGON_PULSE, EXPLOSION, STRENGTH, ROCK_SMASH, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, IRON_HEAD, SLEEP_TALK
	; end
