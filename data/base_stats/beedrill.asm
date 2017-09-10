if DEF(FAITHFUL)
	db  65,  90,  40,  75,  45,  80
	;   hp  atk  def  spd  sat  sdf
else
	db  65, 100,  40, 115,  45,  90
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, POISON
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 159 ; base exp
else
	db 184 ; base exp
endc
	db POISON_BARB ; item 1
	db SHED_SHELL ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db SWARM ; ability 1
	db SNIPER ; ability 2
	db ADAPTABILITY ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, ROOST, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SMASH, LEECH_LIFE, FALSE_SWIPE, X_SCISSOR, ENDURE, ACROBATICS, POISON_JAB, GIGA_IMPACT, U_TURN, FLASH, SWORDS_DANCE, CUT, DOUBLE_EDGE, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
