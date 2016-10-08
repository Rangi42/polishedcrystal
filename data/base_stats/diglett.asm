	db DIGLETT ; 050

	db  10,  55,  25,  95,  35,  45
	;   hp  atk  def  spd  sat  sdf

	db GROUND, GROUND
	db 255 ; catch rate
	db 81 ; base exp
	db NO_ITEM ; item 1
	db SOFT_SAND ; item 2
	db 127 ; gender
	db 20 ; step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db SAND_VEIL ; ability 1
	db ARENA_TRAP ; ability 2
	db SAND_FORCE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, PROTECT, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SLUDGE_BOMB, SANDSTORM, AERIAL_ACE, REST, ATTRACT, THIEF, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, ENDURE, SHADOW_CLAW, CUT, ROCK_SMASH, DOUBLE_EDGE, EARTH_POWER, SLEEP_TALK, SWAGGER
	; end
