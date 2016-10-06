	db BULBASAUR ; 001

	db  45,  49,  49,  45,  65,  65
	;   hp  atk  def  spd  sat  sdf

	db GRASS, POISON
	db 45 ; catch rate
	db 64 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 31 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db OVERGROW ; ability 1
	db OVERGROW ; ability 2
	db CLOROPHYLL ; hidden ability
	db 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, PLANT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, MUD_SLAP, DOUBLE_TEAM, SLUDGE_BOMB, REST, ATTRACT, FURY_CUTTER, SUBSTITUTE, BODY_SLAM, ENERGY_BALL, ENDURE, CUT, STRENGTH, FLASH, ROCK_SMASH, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
