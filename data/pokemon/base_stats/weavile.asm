	db  70, 120,  65, 125,  45,  85
	;   hp  atk  def  spd  sat  sdf

	db DARK, ICE
	db 45 ; catch rate
	db 199 ; base exp
	db GRIP_CLAW ; item 1
	db QUICK_CLAW ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db PRESSURE ; ability 1
if DEF(FAITHFUL)
	db PRESSURE ; ability 2
else
	db TECHNICIAN ; ability 2
endc
	db PICKPOCKET ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   1,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SMASH, FOCUS_BLAST, FALSE_SWIPE, X_SCISSOR, DARK_PULSE, ENDURE, SHADOW_CLAW, POISON_JAB, AVALANCHE, GIGA_IMPACT, SWORDS_DANCE, CUT, SURF, STRENGTH, WHIRLPOOL, DREAM_EATER, HEADBUTT, ICE_PUNCH, ICY_WIND, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
