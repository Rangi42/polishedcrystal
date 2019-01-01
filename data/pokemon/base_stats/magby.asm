if DEF(FAITHFUL)
	db  45,  75,  37,  83,  70,  55
	;   hp  atk  def  spd  sat  sdf
else
	db  50,  75,  37,  83,  70,  55
	;   hp  atk  def  spd  sat  sdf
endc

	db FIRE, FIRE
	db 45 ; catch rate
	db 117 ; base exp
	db ASPEAR_BERRY ; item 1
	db MAGMARIZER ; item 2
	dn FEMALE_25, 4 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db FLAME_BODY ; ability 1
	db FLAME_BODY ; ability 2
	db VITAL_SPIRIT ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, IRON_TAIL, RETURN, PSYCHIC, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SMASH, ENDURE, WILL_O_WISP, BODY_SLAM, COUNTER, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
