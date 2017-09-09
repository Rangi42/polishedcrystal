	db  45,  60,  30,  65,  80,  50
	;   hp  atk  def  spd  sat  sdf

	db DARK, FIRE
	db 120 ; catch rate
	db 114 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db EARLY_BIRD ; ability 1
	db FLASH_FIRE ; ability 2
	db UNNERVE ; hidden ability
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, SOLAR_BEAM, IRON_TAIL, RETURN, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SMASH, DARK_PULSE, ENDURE, WILL_O_WISP, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, HYPER_VOICE, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
