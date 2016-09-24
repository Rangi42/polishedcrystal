	db TANGROWTH ; 465

	db 100, 100, 125,  50, 110,  50
	;   hp  atk  def  spd  sat  sdf

	db GRASS, GRASS
	db 30 ; catch rate
	db 211 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db CLOROPHYLL ; ability 1
	db LEAF_GUARD ; ability 2
	db REGENERATOR ; hidden ability
	db 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn PLANT, PLANT ; egg groups

	; tmhm
	tmhm TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, EARTHQUAKE, RETURN, MUD_SLAP, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, AERIAL_ACE, REST, ATTRACT, THIEF, ROCK_SLIDE, SUBSTITUTE, FOCUS_BLAST, ENERGY_BALL, ENDURE, POISON_JAB, CUT, STRENGTH, FLASH, ROCK_SMASH, HEADBUTT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
