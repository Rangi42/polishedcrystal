	db PARASECT ; 047

	db  60,  95,  80,  30,  60,  80
	;   hp  atk  def  spd  sat  sdf

	db BUG, GRASS
	db 75 ; catch rate
	db 128 ; base exp
	db TINYMUSHROOM ; item 1
	db BIG_MUSHROOM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INSECT, PLANT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DIG, DOUBLE_TEAM, SWAGGER, SLUDGE_BOMB, REST, ATTRACT, THIEF, BODY_SLAM, FURY_CUTTER, SUBSTITUTE, FALSE_SWIPE, X_SCISSOR, ENDURE, CUT, FLASH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, SEED_BOMB, SLEEP_TALK
	; end
