	db  20,  10, 230,  05,  10, 230
	;   hp  atk  def  spd  sat  sdf

	db BUG, ROCK
	db 190 ; catch rate
	db 80 ; base exp
	db BERRY_JUICE ; item 1
	db BERRY_JUICE ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db STURDY ; ability 1
	db GLUTTONY ; ability 2
	db STURDY ; hidden ability (TODO: Contrary)
	db MEDIUM_SLOW ; growth rate
	dn INSECT, INSECT ; egg groups

	; ev_yield
	ev_yield   0,   0,   1,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm -- taken from scizor (TODO: fix)
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, RETURN, ROOST, DOUBLE_TEAM, FLASH_CANNON, SANDSTORM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROCK_SMASH, FALSE_SWIPE, X_SCISSOR, ENDURE, ACROBATICS, GIGA_IMPACT, U_TURN, SWORDS_DANCE, CUT, FLY, STRENGTH, COUNTER, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, IRON_HEAD, KNOCK_OFF, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
