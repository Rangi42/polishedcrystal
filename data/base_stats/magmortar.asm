	db MAGMORTAR ; 467

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
	db FIRE, STEEL
endc
	db 30 ; catch rate
	db 199 ; base exp
	db BURNT_BERRY ; item 1
	db BURNT_BERRY ; item 2
	db 63 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, IRON_TAIL, RETURN, PSYCHIC, MUD_SLAP, DOUBLE_TEAM, SWAGGER, FLAMETHROWER, FIRE_BLAST, REST, ATTRACT, THIEF, BODY_SLAM, SUBSTITUTE, FOCUS_BLAST, FLASH_CANNON, ENDURE, WILL_O_WISP, STRENGTH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, THUNDERPUNCH
	; end
