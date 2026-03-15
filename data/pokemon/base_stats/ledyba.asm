if DEF(FAITHFUL)
	bst 265,  40,  20,  30,  40,  80,  55
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 300,  40,  50,  30,  45,  80,  55
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db BUG, FLYING ; type
	db 255 ; catch rate
	db 54 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

	abilities_for LEDYBA, SWARM, EARLY_BIRD, RATTLED
	db GROWTH_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	ev_yield 1 SDf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROOST, DRAIN_PUNCH, ACROBATICS, U_TURN, FLASH, SWORDS_DANCE, AGILITY, BATON_PASS, DOUBLE_EDGE, ENDURE, HEADBUTT, ICE_PUNCH, KNOCK_OFF, ROLLOUT, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
