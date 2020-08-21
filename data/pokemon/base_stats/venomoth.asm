if DEF(FAITHFUL)
	db  70,  65,  60,  90,  90,  75 ; 450 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  70,  65,  60,  90, 115,  75 ; 475 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, POISON
	db 75 ; catch rate
	db 138 ; base exp
	db SHED_SHELL ; item 1
	db SILVERPOWDER ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/venomoth/front.dimensions"
	abilities_for VENOMOTH, SHIELD_DUST, TINTED_LENS, WONDER_SKIN
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	ev_yield   0,   0,   0,   1,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, ROOST, ENERGY_BALL, ACROBATICS, GIGA_IMPACT, U_TURN, FLASH, DOUBLE_EDGE, DREAM_EATER, ENDURE, SKILL_SWAP, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
