if DEF(FAITHFUL)
	bst 390,  55,  35,  50,  55, 110,  85
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 450,  60,  95,  50,  50, 110,  85
	;   bst   hp  atk  def  sat  sdf  spe
endc

if DEF(FAITHFUL)
	db BUG, FLYING ; type
else
	db BUG, FIGHTING ; type
endc
	db 90 ; catch rate
	db 134 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

	abilities_for LEDIAN, SWARM, EARLY_BIRD, IRON_FIST
	db GROWTH_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	ev_yield 2 SDf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROOST, FOCUS_BLAST, DRAIN_PUNCH, ACROBATICS, GIGA_IMPACT, U_TURN, FLASH, SWORDS_DANCE, STRENGTH, AGILITY, BATON_PASS, DOUBLE_EDGE, ENDURE, HEADBUTT, ICE_PUNCH, KNOCK_OFF, ROLLOUT, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
