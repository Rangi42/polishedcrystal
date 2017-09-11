if DEF(FAITHFUL)
	db  70,  65,  60,  90,  90,  75
	;   hp  atk  def  spd  sat  sdf
else
	db  70,  65,  60,  90, 115,  75
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, POISON
	db 75 ; catch rate
	db 138 ; base exp
	db SILVERPOWDER ; item 1
	db SHED_SHELL ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db SHIELD_DUST ; ability 1
	db TINTED_LENS ; ability 2
	db WONDER_SKIN ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, ROOST, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, ENERGY_BALL, ENDURE, ACROBATICS, GIGA_IMPACT, U_TURN, FLASH, DOUBLE_EDGE, SKILL_SWAP, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
