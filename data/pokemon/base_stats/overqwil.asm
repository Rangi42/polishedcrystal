	db  85, 115,  95,  85,  65,  65 ; 510 BST
	;   hp  atk  def  spd  sat  sdf

	db DARK, POISON ; type
	db 30 ; catch rate
	db 179 ; base exp
	db NO_ITEM ; item 1
	db POISON_BARB ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/overqwil/front.dimensions"
	abilities_for OVERQWIL, POISON_POINT, SWIFT_SWIM, INTIMIDATE
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_2, EGG_WATER_2 ; egg groups

	ev_yield   0,   2,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, SHADOW_BALL, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, SCALD, DARK_PULSE, WATER_PULSE, EXPLOSION, POISON_JAB, THUNDER_WAVE, GYRO_BALL, SWORDS_DANCE, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, HEADBUTT, ICY_WIND, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
