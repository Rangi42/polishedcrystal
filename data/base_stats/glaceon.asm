	db GLACEON ; 253

	db  65,  60, 110,  65, 130,  95
	;   hp  atk  def  spd  sat  sdf

	db ICE, ICE
	db 45 ; catch rate
	db 196 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 31 ; gender
	db 100 ; unknown
	db 35 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm ROAR, TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWIFT, AVALANCHE, REST, ATTRACT, SUBSTITUTE, ENDURE, STRENGTH, ROCK_SMASH, AQUA_TAIL, DOUBLE_EDGE, HEADBUTT, HYPER_VOICE, ICY_WIND, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
