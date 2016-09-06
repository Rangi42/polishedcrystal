	db PARAS ; 046

	db  35,  70,  55,  25,  45,  55
	;   hp  atk  def  spd  sat  sdf

	db BUG, GRASS
	db 190 ; catch rate
	db 70 ; base exp
	db TINYMUSHROOM ; item 1
	db BIG_MUSHROOM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INSECT, PLANT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DIG, DOUBLE_TEAM, SLUDGE_BOMB, AERIAL_ACE, REST, ATTRACT, THIEF, FURY_CUTTER, SUBSTITUTE, BODY_SLAM, ENERGY_BALL, FALSE_SWIPE, X_SCISSOR, ENDURE, CUT, FLASH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
