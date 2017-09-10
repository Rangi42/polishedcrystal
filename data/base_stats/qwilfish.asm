if DEF(FAITHFUL)
	db  65,  95,  85,  85,  55,  55
	;   hp  atk  def  spd  sat  sdf
else
	db  65, 100, 100,  85,  75,  55
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, POISON
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 100 ; base exp
else
	db 109 ; base exp
endc
	db NO_ITEM ; item 1
	db POISON_BARB ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db POISON_POINT ; ability 1
	db SWIFT_SWIM ; ability 2
	db INTIMIDATE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FISH, FISH ; egg groups

	; ev_yield
	ev_yield   0,   1,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, SHADOW_BALL, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, SCALD, ENDURE, WATER_PULSE, EXPLOSION, POISON_JAB, THUNDER_WAVE, GYRO_BALL, SWORDS_DANCE, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, ICY_WIND, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
