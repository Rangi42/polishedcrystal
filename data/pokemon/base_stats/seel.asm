	db  65,  45,  55,  45,  45,  70 ; 325 BST
	;   hp  atk  def  spe  sat  sdf

	db WATER, WATER ; type
	db 190 ; catch rate
	db 100 ; base exp
	db NO_ITEM, RAWST_BERRY ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for SEEL, THICK_FAT, HYDRATION, ICE_BODY
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_1, EGG_GROUND ; egg groups

	ev_yield 1 SDf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, RETURN, DOUBLE_TEAM, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, WATER_PULSE, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, ICY_WIND, PAY_DAY, SLEEP_TALK, SWAGGER
	; end
