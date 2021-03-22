if DEF(FAITHFUL)
	db  65,  95,  85,  85,  55,  55 ; 440 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  65, 100, 100,  85,  75,  55 ; 480 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, POISON ; type
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 100 ; base exp
else
	db 109 ; base exp
endc
	db NO_ITEM ; item 1
	db POISON_BARB ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/qwilfish/front.dimensions"
	abilities_for QWILFISH, POISON_POINT, SWIFT_SWIM, INTIMIDATE
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_2, EGG_WATER_2 ; egg groups

	ev_yield   0,   1,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, SHADOW_BALL, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, SCALD, WATER_PULSE, EXPLOSION, POISON_JAB, THUNDER_WAVE, GYRO_BALL, SWORDS_DANCE, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, HEADBUTT, ICY_WIND, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
