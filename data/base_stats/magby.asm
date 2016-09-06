	db MAGBY ; 240

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
	db BURNT_BERRY ; item 1
	db MAGMARIZER ; item 2
	db 63 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, IRON_TAIL, RETURN, PSYCHIC, MUD_SLAP, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, REST, ATTRACT, THIEF, SUBSTITUTE, BODY_SLAM, ENDURE, WILL_O_WISP, ROCK_SMASH, COUNTER, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
