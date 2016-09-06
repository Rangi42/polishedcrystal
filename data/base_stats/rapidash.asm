	db RAPIDASH ; 078

	db  65, 100,  70, 105,  80,  80
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 60 ; catch rate
	db 192 ; base exp
	db NO_ITEM ; item 1
	db GOLD_BERRY ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, SOLAR_BEAM, IRON_TAIL, RETURN, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, WILD_CHARGE, REST, ATTRACT, SUBSTITUTE, BODY_SLAM, ENDURE, WILL_O_WISP, POISON_JAB, STRENGTH, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK, SWAGGER
	; end
