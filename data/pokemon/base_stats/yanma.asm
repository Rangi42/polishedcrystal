	db  65,  65,  45,  95,  75,  45
	;   hp  atk  def  spd  sat  sdf

	db BUG, FLYING
	db 75 ; catch rate
	db 147 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db SPEED_BOOST ; ability 1
	db COMPOUND_EYES ; ability 2
	db FRISK ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, ROOST, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, LEECH_LIFE, ENDURE, U_TURN, FLASH, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, SLEEP_TALK, SWAGGER
	; end
