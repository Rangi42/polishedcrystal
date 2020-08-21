if DEF(FAITHFUL)
	db  75,  85, 200,  30,  55,  65 ; 510 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  75,  90, 200,  30,  55,  65 ; 515 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db STEEL, GROUND
	db 25 ; catch rate
	db 196 ; base exp
	db NO_ITEM ; item 1
	db METAL_COAT ; item 2
	dn FEMALE_50, 4 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/steelix/front.dimensions"
	abilities_for STEELIX, SHEER_FORCE, STURDY, SAND_FORCE
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, FLASH_CANNON, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, DARK_PULSE, DRAGON_PULSE, EXPLOSION, GIGA_IMPACT, STONE_EDGE, GYRO_BALL, CUT, STRENGTH, AQUA_TAIL, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, IRON_HEAD, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
