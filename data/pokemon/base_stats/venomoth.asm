if DEF(FAITHFUL)
	bst 450,  70,  65,  60,  90,  75,  90
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 470,  70,  65,  60, 110,  75,  90
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db BUG, POISON ; type
	db 75 ; catch rate
	db 138 ; base exp
	db SHED_SHELL, SILVERPOWDER ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for VENOMOTH, SHIELD_DUST, TINTED_LENS, WONDER_SKIN
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	ev_yield 1 Spe, 1 SAt

	; tm/hm learnset
	tmhm CURSE, TOXIC, VENOSHOCK, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, ROOST, ENERGY_BALL, ACROBATICS, GIGA_IMPACT, U_TURN, FLASH, AGILITY, BATON_PASS, DOUBLE_EDGE, DREAM_EATER, ENDURE, SKILL_SWAP, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
