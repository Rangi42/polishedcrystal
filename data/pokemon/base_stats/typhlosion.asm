	db  78,  84,  78, 100, 109,  85
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db FIRE, FIRE
else
	db FIRE, GROUND
endc
	db 45 ; catch rate
	db 209 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db BLAZE ; ability 1
if DEF(FAITHFUL)
	db BLAZE ; ability 2
else
	db FLAME_BODY ; ability 2
endc
	db FLASH_FIRE ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, BULLDOZE, SOLAR_BEAM, IRON_TAIL, EARTHQUAKE, RETURN, DIG, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ATTRACT, ROCK_SLIDE, ROCK_SMASH, FOCUS_BLAST, ENDURE, WILL_O_WISP, SHADOW_CLAW, GIGA_IMPACT, GYRO_BALL, CUT, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, FIRE_PUNCH, HEADBUTT, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
