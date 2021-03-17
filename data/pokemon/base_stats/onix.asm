if DEF(FAITHFUL)
	db  35,  45, 160,  70,  30,  45 ; 385 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  35,  80, 160,  70,  30,  45 ; 420 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db ROCK, GROUND
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 108 ; base exp
else
	db 128 ; base exp
endc
	db LAGGING_TAIL ; item 1
	db HARD_STONE ; item 2
	dn FEMALE_50, 4 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/onix/front.dimensions"
	abilities_for ONIX, ROCK_HEAD, STURDY, WEAK_ARMOR
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	ev_yield   0,   0,   1,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, FLASH_CANNON, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, DRAGON_PULSE, EXPLOSION, STONE_EDGE, GYRO_BALL, STRENGTH, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, IRON_HEAD, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
