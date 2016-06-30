	db SMOOCHUM ; 238

	db  45,  30,  15,  65,  85,  65
	;   hp  atk  def  spd  sat  sdf

	db ICE, PSYCHIC
	db 45 ; catch rate
	db 87 ; base exp
	db ICE_BERRY ; item 1
	db ICE_BERRY ; item 2
	db 254 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, ICY_WIND, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, REFLECT, SWAGGER, AVALANCHE, REST, ATTRACT, THIEF, BODY_SLAM, SUBSTITUTE, ENDURE, FLASH, COUNTER, DOUBLE_EDGE, DREAM_EATER, ICE_PUNCH, SEISMIC_TOSS, SLEEP_TALK, ZEN_HEADBUTT
	; end
