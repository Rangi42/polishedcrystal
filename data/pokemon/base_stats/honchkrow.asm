if DEF(FAITHFUL)
	db 100, 125,  52,  71, 105,  52 ; 505 BST
	;   hp  atk  def  spe  sat  sdf
else
	db 105, 125,  52,  71, 105,  52 ; 510 BST
	;   hp  atk  def  spe  sat  sdf
endc

	db DARK, FLYING ; type
	db 30 ; catch rate
	db 187 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for HONCHKROW, INSOMNIA, SUPER_LUCK, MOXIE
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	ev_yield 2 Atk

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, DARK_PULSE, GIGA_IMPACT, THUNDER_WAVE, FLY, DOUBLE_EDGE, DREAM_EATER, ENDURE, ICY_WIND, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
