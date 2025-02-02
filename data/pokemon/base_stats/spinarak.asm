	db  40,  60,  40,  30,  40,  40 ; 250 BST
	;   hp  atk  def  spe  sat  sdf

	db BUG, POISON ; type
	db 255 ; catch rate
	db 54 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

	abilities_for SPINARAK, SWARM, INSOMNIA, SNIPER
	db GROWTH_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	ev_yield 1 Atk

	; tm/hm learnset
	tmhm CURSE, TOXIC, VENOSHOCK, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DIG, PSYCHIC, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, X_SCISSOR, DARK_PULSE, POISON_JAB, FLASH, AGILITY, BATON_PASS, BODY_SLAM, DOUBLE_EDGE, ENDURE, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
