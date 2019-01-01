if DEF(FAITHFUL)
	db  85,  76,  64,  90,  45,  55
	;   hp  atk  def  spd  sat  sdf
else
	db  85,  86,  64, 108,  45,  55
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, NORMAL
	db 90 ; catch rate
if DEF(FAITHFUL)
	db 116 ; base exp
else
	db 126 ; base exp
endc
	db ORAN_BERRY ; item 1
	db SITRUS_BERRY ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db RUN_AWAY ; ability 1
	db KEEN_EYE ; ability 2
	db FRISK ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   2,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SMASH, FOCUS_BLAST, ENDURE, WATER_PULSE, SHADOW_CLAW, GIGA_IMPACT, U_TURN, CUT, SURF, STRENGTH, WHIRLPOOL, AQUA_TAIL, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, HYPER_VOICE, ICE_PUNCH, KNOCK_OFF, ROLLOUT, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, THUNDERPUNCH, TRICK
	; end
