	db EKANS ; 023

	db  35,  60,  44,  55,  40,  54
	;   hp  atk  def  spd  sat  sdf

	db POISON, POISON
	db 255 ; catch rate
	db 62 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, REPTILE ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, GIGA_DRAIN, IRON_TAIL, EARTHQUAKE, RETURN, DIG, DOUBLE_TEAM, SLUDGE_BOMB, REST, ATTRACT, THIEF, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, DARK_PULSE, ENDURE, POISON_JAB, STRENGTH, AQUA_TAIL, DOUBLE_EDGE, HEADBUTT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
