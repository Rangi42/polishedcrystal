	db  65,  80, 140,  70,  40,  70
	;   hp  atk  def  spd  sat  sdf

	db STEEL, FLYING
	db 25 ; catch rate
	db 168 ; base exp
	db NO_ITEM ; item 1
	db SHARP_BEAK ; item 2
	dn FEMALE_50, 4 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db KEEN_EYE ; ability 1
	db STURDY ; ability 2
	db WEAK_ARMOR ; hidden ability
	db SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; ev_yield
	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RETURN, ROOST, DOUBLE_TEAM, FLASH_CANNON, SANDSTORM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROCK_SLIDE, ROCK_SMASH, X_SCISSOR, DARK_PULSE, ENDURE, FLASH, SWORDS_DANCE, CUT, FLY, COUNTER, DOUBLE_EDGE, ICY_WIND, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
