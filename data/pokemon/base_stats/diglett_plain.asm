	db  10,  55,  25,  95,  35,  45
	;   hp  atk  def  spd  sat  sdf

	db GROUND, GROUND
	db 255 ; catch rate
	db 81 ; base exp
	db NO_ITEM ; item 1
	db SOFT_SAND ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
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
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, PROTECT, BULLDOZE, EARTHQUAKE, RETURN, DIG, DOUBLE_TEAM, SLUDGE_BOMB, SANDSTORM, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, ROCK_SMASH, ENDURE, SHADOW_CLAW, CUT, AGILITY, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
