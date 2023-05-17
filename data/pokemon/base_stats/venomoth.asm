if DEF(FAITHFUL)
	db  70,  65,  60,  90,  90,  75 ; 450 BST
	;   hp  atk  def  spe  sat  sdf
else
	db  70,  65,  60,  90, 115,  75 ; 475 BST
	;   hp  atk  def  spe  sat  sdf
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
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, ROOST, ENERGY_BALL, ACROBATICS, GIGA_IMPACT, U_TURN, FLASH, DOUBLE_EDGE, DREAM_EATER, ENDURE, SKILL_SWAP, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
