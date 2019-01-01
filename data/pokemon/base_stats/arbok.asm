	db  60,  95,  69,  80,  65,  79
	;   hp  atk  def  spd  sat  sdf

	db POISON, POISON
	db 90 ; catch rate
	db 147 ; base exp
	db NO_ITEM ; item 1
	db POISON_BARB ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db INTIMIDATE ; ability 1
	db SHED_SKIN ; ability 2
	db UNNERVE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, REPTILE ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, DIG, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, LEECH_LIFE, DARK_PULSE, ENDURE, POISON_JAB, GIGA_IMPACT, STRENGTH, AQUA_TAIL, BODY_SLAM, DOUBLE_EDGE, HEADBUTT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
