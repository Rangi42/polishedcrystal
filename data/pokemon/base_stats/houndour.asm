	db  45,  60,  30,  65,  80,  50 ; 330 BST
	;   hp  atk  def  spd  sat  sdf

	db DARK, FIRE
	db 120 ; catch rate
	db 114 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/houndour/front.dimensions"
	abilities_for HOUNDOUR, EARLY_BIRD, FLASH_FIRE, UNNERVE
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	ev_yield   0,   0,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, SOLAR_BEAM, IRON_TAIL, RETURN, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, SWIFT, SUBSTITUTE, FACADE, FLAME_CHARGE, REST, ATTRACT, THIEF, DARK_PULSE, WILL_O_WISP, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, ENDURE, HEADBUTT, HYPER_VOICE, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
