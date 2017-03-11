	db BEEDRILL ; 015

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
	db NO_ITEM ; item 1
	db POISON_BARB ; item 2
	db 127 ; gender
	db 15 ; step cycles to hatch
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
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, AERIAL_ACE, FACADE, REST, ATTRACT, THIEF, FURY_CUTTER, ROCK_SMASH, LEECH_LIFE, FALSE_SWIPE, X_SCISSOR, ENDURE, ACROBATICS, POISON_JAB, GIGA_IMPACT, U_TURN, FLASH, CUT, DOUBLE_EDGE, SLEEP_TALK, SUBSTITUTE, SWAGGER
	; end
