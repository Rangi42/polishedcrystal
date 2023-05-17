	db  40,  50,  40,  90,  40,  40 ; 300 BST
	;   hp  atk  def  spe  sat  sdf

	db WATER, WATER ; type
	db 255 ; catch rate
	db 77 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for POLIWAG, WATER_ABSORB, DAMP, SWIFT_SWIM
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_WATER_1, EGG_WATER_1 ; egg groups

	ev_yield 1 Spe

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, DIG, PSYCHIC, DOUBLE_TEAM, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, SCALD, WATER_PULSE, SURF, WHIRLPOOL, WATERFALL, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, ICY_WIND, SLEEP_TALK, SWAGGER
	; end
