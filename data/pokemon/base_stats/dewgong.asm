if DEF(FAITHFUL)
	db  90,  70,  80,  70,  70,  95 ; 475 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  90,  70,  80,  70,  80,  95 ; 485 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, ICE ; type
	db 75 ; catch rate
	db 176 ; base exp
	db RAWST_BERRY ; item 1
	db NEVERMELTICE ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/dewgong/front.dimensions"
	abilities_for DEWGONG, THICK_FAT, HYDRATION, ICE_BODY
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_1, EGG_GROUND ; egg groups

	ev_yield   0,   0,   0,   0,   0,   2
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, RETURN, DOUBLE_TEAM, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, WATER_PULSE, AVALANCHE, GIGA_IMPACT, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, ICY_WIND, PAY_DAY, SLEEP_TALK, SWAGGER
	; end
