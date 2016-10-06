	db VENUSAUR ; 003

	db  80,  82,  83,  80, 100, 100
	;   hp  atk  def  spd  sat  sdf

	db GRASS, POISON
	db 45 ; catch rate
	db 208 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 31 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db OVERGROW ; ability 1
	db CLOROPHYLL ; ability 2
	db THICK_FAT ; hidden ability
	db 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, PLANT ; egg groups

	; tmhm
	tmhm CURSE, ROAR, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, EARTHQUAKE, RETURN, MUD_SLAP, DOUBLE_TEAM, SLUDGE_BOMB, REST, ATTRACT, FURY_CUTTER, SUBSTITUTE, BODY_SLAM, ENERGY_BALL, ENDURE, CUT, STRENGTH, FLASH, ROCK_SMASH, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
