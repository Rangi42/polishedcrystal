if DEF(FAITHFUL)
	db  65,  90,  40,  75,  45,  80 ; 395 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  65, 100,  40, 115,  45,  90 ; 455 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, POISON
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 159 ; base exp
else
	db 184 ; base exp
endc
	db SHED_SHELL ; item 1
	db POISON_BARB ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/beedrill/front.dimensions"
	abilities_for BEEDRILL, SWARM, SNIPER, ADAPTABILITY
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	ev_yield   0,   2,   0,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, ROCK_SMASH, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, ROOST, FALSE_SWIPE, X_SCISSOR, ACROBATICS, POISON_JAB, GIGA_IMPACT, U_TURN, FLASH, SWORDS_DANCE, CUT, DOUBLE_EDGE, ENDURE, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
