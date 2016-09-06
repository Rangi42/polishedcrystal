	db NIDORINO ; 033

	db  61,  72,  57,  65,  55,  55
	;   hp  atk  def  spd  sat  sdf

	db POISON, POISON
	db 120 ; catch rate
	db 118 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 0 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, FIELD ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SLUDGE_BOMB, REST, ATTRACT, THIEF, SUBSTITUTE, BODY_SLAM, ENDURE, POISON_JAB, SHADOW_CLAW, CUT, STRENGTH, ROCK_SMASH, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
