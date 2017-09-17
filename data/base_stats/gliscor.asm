	db  75,  95, 125,  95,  45,  75
	;   hp  atk  def  spd  sat  sdf

	db GROUND, FLYING
	db 30 ; catch rate
	db 192 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db HYPER_CUTTER ; ability 1
	db SAND_VEIL ; ability 2
	db POISON_HEAL ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn INSECT, INSECT ; egg groups

	; ev_yield
	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, DIG, ROOST, DOUBLE_TEAM, SLUDGE_BOMB, SANDSTORM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROCK_SLIDE, ROCK_SMASH, FALSE_SWIPE, X_SCISSOR, DARK_PULSE, ENDURE, ACROBATICS, POISON_JAB, GIGA_IMPACT, U_TURN, STONE_EDGE, SWORDS_DANCE, CUT, FLY, STRENGTH, AQUA_TAIL, EARTH_POWER, HEADBUTT, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
