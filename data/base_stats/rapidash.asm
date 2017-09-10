	db  65, 100,  70, 105,  80,  80
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db FIRE, FIRE
else
	db FIRE, FAIRY
endc
	db 60 ; catch rate
	db 192 ; base exp
	db NO_ITEM ; item 1
	db SITRUS_BERRY ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db RUN_AWAY ; ability 1
	db FLASH_FIRE ; ability 2
	db FLAME_BODY ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   2,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, SOLAR_BEAM, IRON_TAIL, RETURN, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ATTRACT, ENDURE, WILL_O_WISP, POISON_JAB, GIGA_IMPACT, STRENGTH, BODY_SLAM, DOUBLE_EDGE, HEADBUTT, PAY_DAY, SLEEP_TALK, SWAGGER
	; end
