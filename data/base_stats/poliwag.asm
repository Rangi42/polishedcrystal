	db POLIWAG ; 060

	db  40,  50,  40,  90,  40,  40
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 255 ; catch rate
	db 77 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn AMPHIBIAN, AMPHIBIAN ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, ICY_WIND, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, DIG, PSYCHIC, DOUBLE_TEAM, SWAGGER, DEFENSE_CURL, REST, ATTRACT, THIEF, BODY_SLAM, SUBSTITUTE, SCALD, ENDURE, SURF, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK
	; end
