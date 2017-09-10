if DEF(FAITHFUL)
	db 100, 125,  52,  71, 105,  52
	;   hp  atk  def  spd  sat  sdf
else
	db 105, 125,  52,  71, 105,  52
	;   hp  atk  def  spd  sat  sdf
endc

	db DARK, FLYING
	db 30 ; catch rate
	db 187 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db INSOMNIA ; ability 1
	db SUPER_LUCK ; ability 2
	db MOXIE ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, ROOST, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, DARK_PULSE, ENDURE, GIGA_IMPACT, THUNDER_WAVE, FLY, DREAM_EATER, ICY_WIND, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
