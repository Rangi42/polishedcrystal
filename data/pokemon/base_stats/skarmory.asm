if DEF(FAITHFUL)
	bst 465,  65,  80, 140,  40,  70,  70
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 485,  85,  80, 140,  40,  70,  70
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db STEEL, FLYING ; type
	db 25 ; catch rate
	db 168 ; base exp
	db NO_ITEM, SHARP_BEAK ; held items
	dn GENDER_F50, HATCH_MEDIUM_SLOW ; gender ratio, step cycles to hatch

	abilities_for SKARMORY, KEEN_EYE, STURDY, WEAK_ARMOR
	db GROWTH_SLOW ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	ev_yield 2 Def

	; tm/hm learnset
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RETURN, ROCK_SMASH, DOUBLE_TEAM, FLASH_CANNON, SANDSTORM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROCK_SLIDE, ROOST, X_SCISSOR, DARK_PULSE, FLASH, SWORDS_DANCE, CUT, FLY, AGILITY, COUNTER, DOUBLE_EDGE, ENDURE, ICY_WIND, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
