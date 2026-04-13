	db  75,  99,  65, 101,  66,  66 ; 472 BST
	;   hp  atk  def  spe  sat  sdf

	db NORMAL, FLYING ; type
	db 90 ; catch rate
	db 169 ; base exp
	db NO_ITEM, SHARP_BEAK ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

	abilities_for CUARDHART, KEEN_EYE, KEEN_EYE, SNIPER
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	ev_yield 2 Spe

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, FALSE_SWIPE, GIGA_IMPACT, U_TURN, FLY, AGILITY, BATON_PASS, DOUBLE_EDGE, ENDURE, SLEEP_TALK, SWAGGER
	; end
