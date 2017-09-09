	db  80,  82,  78,  85,  95,  80
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db WATER, WATER
else
	db WATER, PSYCHIC
endc
	db 75 ; catch rate
	db 174 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db DAMP ; ability 1
	db CLOUD_NINE ; ability 2
	db SWIFT_SWIM ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   2,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, HONE_CLAWS, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, PSYCHIC, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SMASH, FOCUS_BLAST, SCALD, ENDURE, WATER_PULSE, SHADOW_CLAW, GIGA_IMPACT, FLASH, SURF, STRENGTH, WHIRLPOOL, WATERFALL, AQUA_TAIL, BODY_SLAM, COUNTER, DOUBLE_EDGE, HEADBUTT, ICE_PUNCH, ICY_WIND, PAY_DAY, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
