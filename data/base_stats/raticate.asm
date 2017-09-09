if DEF(FAITHFUL)
	db  55,  81,  60,  97,  50,  70
	;   hp  atk  def  spd  sat  sdf
else
	db  65,  91,  60, 107,  50,  70
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, NORMAL
	db 90 ; catch rate
	db 116 ; base exp
	db NO_ITEM ; item 1
	db SITRUS_BERRY ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db RUN_AWAY ; ability 1
	db GUTS ; ability 2
	db HUSTLE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   2,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ATTRACT, THIEF, ROCK_SMASH, DARK_PULSE, ENDURE, SHADOW_CLAW, GIGA_IMPACT, U_TURN, THUNDER_WAVE, SWORDS_DANCE, CUT, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, ICY_WIND, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, ZEN_HEADBUTT
	; end
