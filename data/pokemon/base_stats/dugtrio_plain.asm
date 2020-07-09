	db  35, 100,  50, 120,  50,  70 ; 425 BST
	;   hp  atk  def  spd  sat  sdf

	db GROUND, GROUND
	db 50 ; catch rate
	db 153 ; base exp
	db NO_ITEM ; item 1
	db SOFT_SAND ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db SAND_VEIL ; ability 1
	db ARENA_TRAP ; ability 2
	db SAND_FORCE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   2,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, PROTECT, BULLDOZE, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SLUDGE_BOMB, SANDSTORM, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, SHADOW_CLAW, GIGA_IMPACT, STONE_EDGE, CUT, AGILITY, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
