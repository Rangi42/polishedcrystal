	db RATTATA ; 019

	db  30,  56,  35,  72,  25,  35
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL
	db 255 ; catch rate
	db 57 ; base exp
	db NO_ITEM ; item 1
	db BERRY ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 15 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICY_WIND, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SWIFT, DEFENSE_CURL, WILD_CHARGE, REST, ATTRACT, THIEF, BODY_SLAM, SUBSTITUTE, ENDURE, THUNDER_WAVE, CUT, ROCK_SMASH, COUNTER, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK, ZEN_HEADBUTT
	; end
