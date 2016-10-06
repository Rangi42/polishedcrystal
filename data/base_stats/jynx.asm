	db JYNX ; 124

if DEF(FAITHFUL)
	db  65,  50,  35,  95, 115,  95
	;   hp  atk  def  spd  sat  sdf
else
	db  70,  60,  40,  95, 120, 100
	;   hp  atk  def  spd  sat  sdf
endc

	db ICE, PSYCHIC
	db 45 ; catch rate
	db 137 ; base exp
	db ICE_BERRY ; item 1
	db ICE_BERRY ; item 2
	db 254 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db OBLIVIOUS ; ability 1
	db FOREWARN ; ability 2
	db DRY_SKIN ; hidden ability
	db 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, REFLECT, AVALANCHE, REST, ATTRACT, THIEF, SUBSTITUTE, BODY_SLAM, FOCUS_BLAST, ENERGY_BALL, ENDURE, FLASH, COUNTER, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, HYPER_VOICE, ICE_PUNCH, ICY_WIND, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, WATER_PULSE, ZEN_HEADBUTT
	; end
