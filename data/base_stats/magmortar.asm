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
	db FIRE, FIGHTING
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
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, EARTHQUAKE, RETURN, PSYCHIC, MUD_SLAP, DOUBLE_TEAM, FLASH_CANNON, FLAMETHROWER, FIRE_BLAST, REST, ATTRACT, THIEF, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, FOCUS_BLAST, ENDURE, WILL_O_WISP, STRENGTH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
