	db  20,  10, 230,  05,  10, 230 ; 505 BST
	;   hp  atk  def  spd  sat  sdf

	db BUG, ROCK
	db 190 ; catch rate
	db 80 ; base exp
	db ALWAYS_ITEM_2 ; item 1
	db BERRY_JUICE ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/shuckle/front.dimensions"
	abilities_for SHUCKLE, STURDY, GLUTTONY, CONTRARY
	db MEDIUM_SLOW ; growth rate
	dn INSECT, INSECT ; egg groups

	ev_yield   0,   0,   1,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, SAFEGUARD, BULLDOZE, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SLUDGE_BOMB, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, FLASH, STONE_EDGE, GYRO_BALL, STRENGTH, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, KNOCK_OFF, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
