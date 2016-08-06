	db MAGMAR ; 126

	db  65,  95,  57,  93, 100,  85
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 45 ; catch rate
	db 167 ; base exp
	db BURNT_BERRY ; item 1
	db MAGMARIZER ; item 2
	db 63 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, IRON_TAIL, RETURN, PSYCHIC, MUD_SLAP, DOUBLE_TEAM, SWAGGER, FLAMETHROWER, FIRE_BLAST, REST, ATTRACT, THIEF, BODY_SLAM, SUBSTITUTE, FOCUS_BLAST, ENDURE, WILL_O_WISP, STRENGTH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, THUNDERPUNCH
	; end
