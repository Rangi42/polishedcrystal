	db  40,  65,  95,  35,  60,  45
	;   hp  atk  def  spd  sat  sdf

	db POISON, POISON
	db 190 ; catch rate
	db 114 ; base exp
	db NO_ITEM ; item 1
	db SMOKE_BALL ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db LEVITATE ; ability 1
	db LEVITATE ; ability 2
	db LEVITATE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; ev_yield
	ev_yield   0,   0,   1,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DARK_PULSE, ENDURE, WILL_O_WISP, EXPLOSION, FLASH, GYRO_BALL, ROLLOUT, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
