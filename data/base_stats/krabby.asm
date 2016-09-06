	db KRABBY ; 098

	db  30, 105,  90,  50,  25,  25
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 225 ; catch rate
	db 115 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INVERTEBRATE, INVERTEBRATE ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HAIL, SWORDS_DANCE, HIDDEN_POWER, HONE_CLAWS, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, REST, ATTRACT, THIEF, ROCK_SLIDE, FURY_CUTTER, SUBSTITUTE, BODY_SLAM, FALSE_SWIPE, SCALD, X_SCISSOR, ENDURE, SHADOW_CLAW, CUT, SURF, STRENGTH, WHIRLPOOL, ROCK_SMASH, DOUBLE_EDGE, ICY_WIND, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
