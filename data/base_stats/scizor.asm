	db  70, 130, 100,  65,  55,  80
	;   hp  atk  def  spd  sat  sdf

	db BUG, STEEL
	db 25 ; catch rate
	db 200 ; base exp
	db NO_ITEM ; item 1
	db METAL_COAT ; item 2
	dn FEMALE_50, 4 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db SWARM ; ability 1
	db TECHNICIAN ; ability 2
	db SWARM ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, RETURN, ROOST, DOUBLE_TEAM, FLASH_CANNON, SANDSTORM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROCK_SMASH, FALSE_SWIPE, X_SCISSOR, ENDURE, ACROBATICS, GIGA_IMPACT, U_TURN, SWORDS_DANCE, CUT, FLY, STRENGTH, COUNTER, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, IRON_HEAD, KNOCK_OFF, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
