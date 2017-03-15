	db DIGLETT ; 050

if DEF(FAITHFUL)
	db  10,  55,  25,  95,  35,  45
	;   hp  atk  def  spd  sat  sdf
else
	db  10,  55,  30,  90,  35,  45
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db GROUND, GROUND
else
	db GROUND, STEEL
endc
	db 255 ; catch rate
	db 81 ; base exp
	db NO_ITEM ; item 1
	db SOFT_SAND ; item 2
	db 127 ; gender
	db 20 ; step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db SAND_VEIL ; ability 1
if DEF(FAITHFUL)
	db ARENA_TRAP ; ability 2
else
	db TANGLING_HAIR ; ability 2
endc
	db SAND_FORCE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, PROTECT, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, FLASH_CANNON, SLUDGE_BOMB, SANDSTORM, AERIAL_ACE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, ROCK_SMASH, ENDURE, SHADOW_CLAW, CUT, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, SLEEP_TALK, SUBSTITUTE, SUCKER_PUNCH, SWAGGER
	; end
