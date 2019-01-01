if DEF(FAITHFUL)
	db  75,  95,  67,  83, 125,  95
	;   hp  atk  def  spd  sat  sdf
else
	db  75,  95,  67,  93, 125,  95
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db FIRE, FIRE
else
	db FIRE, FIGHTING
endc
	db 30 ; catch rate
	db 199 ; base exp
	db ASPEAR_BERRY ; item 1
	db ASPEAR_BERRY ; item 2
	dn FEMALE_25, 4 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db FLAME_BODY ; ability 1
	db FLAME_BODY ; ability 2
	db VITAL_SPIRIT ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, BULLDOZE, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, EARTHQUAKE, RETURN, PSYCHIC, DOUBLE_TEAM, FLASH_CANNON, FLAMETHROWER, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, ROCK_SMASH, FOCUS_BLAST, ENDURE, WILL_O_WISP, GIGA_IMPACT, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
