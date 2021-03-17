if DEF(FAITHFUL)
	db  75,  95,  67,  83, 125,  95 ; 540 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  75,  95,  67,  93, 125,  95 ; 550 BST
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
	db MAGMARIZER ; item 2
	dn FEMALE_25, 4 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/magmortar/front.dimensions"
	abilities_for MAGMORTAR, FLAME_BODY, FLAME_BODY, VITAL_SPIRIT
	db MEDIUM_FAST ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, BULLDOZE, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, EARTHQUAKE, RETURN, PSYCHIC, ROCK_SMASH, DOUBLE_TEAM, FLASH_CANNON, FLAMETHROWER, FIRE_BLAST, SUBSTITUTE, FACADE, FLAME_CHARGE, REST, ATTRACT, THIEF, ROCK_SLIDE, FOCUS_BLAST, WILL_O_WISP, GIGA_IMPACT, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, ENDURE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
