	db ARBOK ; 024

	db  60,  85,  69,  80,  65,  79
	;   hp  atk  def  spd  sat  sdf

	db POISON, POISON
	db 90 ; catch rate
	db 147 ; base exp
	db NO_ITEM ; item 1
	db POISON_BARB ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, REPTILE ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, IRON_TAIL, EARTHQUAKE, RETURN, DIG, DOUBLE_TEAM, SWAGGER, SLUDGE_BOMB, REST, ATTRACT, THIEF, BODY_SLAM, ROCK_SLIDE, SUBSTITUTE, DARK_PULSE, ENDURE, POISON_JAB, STRENGTH, AQUA_TAIL, DOUBLE_EDGE, HEADBUTT, SEED_BOMB, SLEEP_TALK
	; end
