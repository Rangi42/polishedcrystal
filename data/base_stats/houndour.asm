	db HOUNDOUR ; 228

	db  45,  60,  30,  65,  80,  50
	;   hp  atk  def  spd  sat  sdf

	db DARK, FIRE
	db 120 ; catch rate
	db 114 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, SOLAR_BEAM, IRON_TAIL, RETURN, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWAGGER, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, SWIFT, REST, ATTRACT, THIEF, BODY_SLAM, SUBSTITUTE, DARK_PULSE, ENDURE, WILL_O_WISP, ROCK_SMASH, COUNTER, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, HYPER_VOICE, SLEEP_TALK
	; end
