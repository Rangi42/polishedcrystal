	db EXEGGUTOR ; 103

	db  95,  95,  85,  55, 125,  65
	;   hp  atk  def  spd  sat  sdf

	db GRASS, PSYCHIC
	db 45 ; catch rate
	db 212 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db CLOROPHYLL ; ability 1
	db CLOROPHYLL ; ability 2
	db HARVEST ; hidden ability
	db 0 ; padding
	db SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, REST, ATTRACT, THIEF, SUBSTITUTE, ENERGY_BALL, ENDURE, EXPLOSION, STRENGTH, FLASH, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, ROLLOUT, SEED_BOMB, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
