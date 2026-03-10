if DEF(FAITHFUL)
	bst 450,  80,  92,  65,  65,  80,  68
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 475,  80, 112,  65,  55,  80,  83
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db WATER, WATER ; type
	db 60 ; catch rate
if DEF(FAITHFUL)
	db 170 ; base exp
else
	db 180 ; base exp
endc
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio

	abilities_for SEAKING, SWIFT_SWIM, WATER_VEIL, LIGHTNING_ROD
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_2, EGG_WATER_2 ; egg groups

	ev_yield 2 Atk

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, SCALD, WATER_PULSE, POISON_JAB, GIGA_IMPACT, SWORDS_DANCE, SURF, WHIRLPOOL, WATERFALL, AGILITY, AQUA_TAIL, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, ICY_WIND, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
