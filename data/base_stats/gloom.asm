	db GLOOM ; 044

	db  60,  65,  70,  40,  85,  75
	;   hp  atk  def  spd  sat  sdf

	db GRASS, POISON
	db 120 ; catch rate
	db 132 ; base exp
	db SILVER_LEAF ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db CLOROPHYLL ; ability 1
	db CLOROPHYLL ; ability 2
	db STENCH ; hidden ability
	db 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SLUDGE_BOMB, REST, ATTRACT, SUBSTITUTE, ENERGY_BALL, ENDURE, DAZZLINGLEAM, CUT, FLASH, DOUBLE_EDGE, HYPER_VOICE, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
