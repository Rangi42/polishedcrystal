	db  55,  95,  55, 115,  35,  75
	;   hp  atk  def  spd  sat  sdf

	db DARK, ICE
	db 60 ; catch rate
	db 132 ; base exp
	db GRIP_CLAW ; item 1
	db RAZOR_CLAW ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db INNER_FOCUS ; ability 1
	db KEEN_EYE ; ability 2
	db PICKPOCKET ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SMASH, FALSE_SWIPE, X_SCISSOR, DARK_PULSE, ENDURE, SHADOW_CLAW, POISON_JAB, AVALANCHE, SWORDS_DANCE, CUT, SURF, STRENGTH, WHIRLPOOL, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, ICE_PUNCH, ICY_WIND, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
