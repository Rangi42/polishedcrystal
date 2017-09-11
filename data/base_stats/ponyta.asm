	db  50,  85,  55,  90,  65,  65
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 190 ; catch rate
	db 152 ; base exp
	db NO_ITEM ; item 1
	db ORAN_BERRY ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db RUN_AWAY ; ability 1
	db FLASH_FIRE ; ability 2
	db FLAME_BODY ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, SOLAR_BEAM, IRON_TAIL, RETURN, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ATTRACT, ENDURE, WILL_O_WISP, STRENGTH, BODY_SLAM, DOUBLE_EDGE, HEADBUTT, PAY_DAY, SLEEP_TALK, SWAGGER
	; end
