	db  62, 135,  95,  65,  68,  82 ; 507 BST
	;   hp  atk  def  spe  sat  sdf

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 178 ; base exp
	db NO_ITEM, LEEK ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for SIRFETCH_D, STEADFAST, STEADFAST, SCRAPPY
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_FLYING, EGG_GROUND ; egg groups

	ev_yield 2 Atk

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RETURN, ROCK_SMASH, DOUBLE_TEAM, SUBSTITUTE, FACADE, REST, ATTRACT, STEEL_WING, POISON_JAB, GIGA_IMPACT, SWORDS_DANCE, CUT, BODY_SLAM, COUNTER, DOUBLE_EDGE, ENDURE, HEADBUTT, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
