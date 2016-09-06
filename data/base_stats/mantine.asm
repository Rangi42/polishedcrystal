	db MANTINE ; 226

	db  65,  40,  70,  70,  80, 140
	;   hp  atk  def  spd  sat  sdf

	db WATER, FLYING
	db 25 ; catch rate
	db 168 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn AMPHIBIAN, AMPHIBIAN ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, EARTHQUAKE, RETURN, MUD_SLAP, DOUBLE_TEAM, SWIFT, AERIAL_ACE, REST, ATTRACT, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, SCALD, ENDURE, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, DOUBLE_EDGE, HEADBUTT, ICY_WIND, IRON_HEAD, SEED_BOMB, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
