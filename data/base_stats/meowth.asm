if DEF(FAITHFUL)
	db  40,  45,  35,  90,  40,  40
	;   hp  atk  def  spd  sat  sdf
else
	db  40,  35,  35,  90,  50,  40
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db NORMAL, NORMAL
else
	db DARK, DARK
endc
	db 255 ; catch rate
	db 69 ; base exp
	db NO_ITEM ; item 1
	db AMULET_COIN ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db PICKUP ; ability 1
	db TECHNICIAN ; ability 2
	db UNNERVE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, FALSE_SWIPE, DARK_PULSE, ENDURE, WATER_PULSE, SHADOW_CLAW, U_TURN, FLASH, CUT, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, HYPER_VOICE, ICY_WIND, KNOCK_OFF, PAY_DAY, SEED_BOMB, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
