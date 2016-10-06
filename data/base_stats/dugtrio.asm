	db DUGTRIO ; 051

if DEF(FAITHFUL)
	db  35,  80,  50, 120,  50,  70
	;   hp  atk  def  spd  sat  sdf
else
	db  35, 100,  50, 120,  50,  70
	;   hp  atk  def  spd  sat  sdf
endc

	db GROUND, GROUND
	db 50 ; catch rate
	db 153 ; base exp
	db NO_ITEM ; item 1
	db SOFT_SAND ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db SAND_VEIL ; ability 1
	db ARENA_TRAP ; ability 2
	db SAND_FORCE ; hidden ability
	db 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, PROTECT, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SLUDGE_BOMB, SANDSTORM, AERIAL_ACE, STONE_EDGE, REST, ATTRACT, THIEF, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, ENDURE, SHADOW_CLAW, CUT, ROCK_SMASH, DOUBLE_EDGE, EARTH_POWER, SLEEP_TALK, SWAGGER
	; end
