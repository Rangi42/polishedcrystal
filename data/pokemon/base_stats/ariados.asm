if DEF(FAITHFUL)
	db  70,  90,  70,  40,  60,  70 ; 400 BST
	;   hp  atk  def  spe  sat  sdf
else
	db  70,  90,  70,  80,  60,  70 ; 440 BST
	;   hp  atk  def  spe  sat  sdf
endc

if DEF(FAITHFUL)
	db BUG, POISON ; type
else
	db BUG, DARK ; type
endc
	db 90 ; catch rate
	db 134 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

	abilities_for ARIADOS, SWARM, INSOMNIA, SNIPER
	db GROWTH_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	ev_yield 2 Atk

	; tm/hm learnset
	tmhm CURSE, TOXIC, VENOSHOCK, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DIG, PSYCHIC, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, X_SCISSOR, DARK_PULSE, POISON_JAB, GIGA_IMPACT, FLASH, SWORDS_DANCE, AGILITY, BATON_PASS, BODY_SLAM, DOUBLE_EDGE, ENDURE, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
