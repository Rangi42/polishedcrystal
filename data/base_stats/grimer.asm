	db GRIMER ; 088

	db  80,  80,  50,  25,  40,  50
	;   hp  atk  def  spd  sat  sdf

	db POISON, POISON
	db 190 ; catch rate
	db 90 ; base exp
	db NO_ITEM ; item 1
	db NUGGET ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, GIGA_DRAIN, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWAGGER, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, REST, ATTRACT, THIEF, BODY_SLAM, ROCK_SLIDE, SUBSTITUTE, ENDURE, POISON_JAB, EXPLOSION, STRENGTH, FIRE_PUNCH, ICE_PUNCH, SLEEP_TALK, THUNDERPUNCH, ZAP_CANNON
	; end
