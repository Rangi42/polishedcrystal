if DEF(FAITHFUL)
	bst 385,  35,  45, 160,  30,  45,  70
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 425,  55,  65, 160,  30,  45,  70
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db ROCK, GROUND ; type
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 108 ; base exp
else
	db 128 ; base exp
endc
	db LAGGING_TAIL, HARD_STONE ; held items
	dn GENDER_F50, HATCH_MEDIUM_SLOW ; gender ratio, step cycles to hatch

	abilities_for ONIX, ROCK_HEAD, STURDY, WEAK_ARMOR
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	ev_yield 1 Def

	; tm/hm learnset
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, FLASH_CANNON, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, DRAGON_PULSE, EXPLOSION, STONE_EDGE, GYRO_BALL, STRENGTH, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, IRON_HEAD, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
