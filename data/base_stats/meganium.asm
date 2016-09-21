	db MEGANIUM ; 154

	db  80,  82, 100,  80,  83, 100
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db GRASS, GRASS
else
	db GRASS, FAIRY
endc
	db 45 ; catch rate
	db 208 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 31 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db OVERGROW ; ability 1
	db OVERGROW ; ability 2
	db LEAF_GUARD ; hidden ability
	db 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, PLANT ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, IRON_TAIL, EARTHQUAKE, RETURN, MUD_SLAP, DOUBLE_TEAM, REFLECT, REST, ATTRACT, FURY_CUTTER, SUBSTITUTE, BODY_SLAM, ENERGY_BALL, ENDURE, DAZZLINGLEAM, CUT, STRENGTH, FLASH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, HEADBUTT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
