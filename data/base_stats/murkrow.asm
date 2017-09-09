	db  60,  85,  42,  91,  85,  42
	;   hp  atk  def  spd  sat  sdf

	db DARK, FLYING
	db 30 ; catch rate
	db 107 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db INSOMNIA ; ability 1
	db SUPER_LUCK ; ability 2
	db PRANKSTER ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, ROOST, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, DARK_PULSE, ENDURE, THUNDER_WAVE, FLY, DOUBLE_EDGE, DREAM_EATER, ICY_WIND, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
