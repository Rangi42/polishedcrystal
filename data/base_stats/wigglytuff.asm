	db WIGGLYTUFF ; 040

if DEF(FAITHFUL)
	db 140,  70,  45,  45,  85,  50
	;   hp  atk  def  spd  sat  sdf
else
	db 148,  70,  55,  45,  85,  65
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, FAIRY
	db 50 ; catch rate
if DEF(FAITHFUL)
	db 109 ; base exp
else
	db 129 ; base exp
endc
	db BERRY ; item 1
	db BERRY ; item 2
	db 191 ; gender
	db 100 ; unknown
	db 10 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db CUTE_CHARM ; ability 1
	db COMPETITIVE ; ability 2
	db FRISK ; hidden ability
	db 0 ; padding
	db FAST ; growth rate
	dn FAERY, FAERY ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, SOLAR_BEAM, THUNDERBOLT, THUNDER, RETURN, DIG, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, REFLECT, FLAMETHROWER, FIRE_BLAST, WILD_CHARGE, REST, ATTRACT, SUBSTITUTE, BODY_SLAM, FOCUS_BLAST, ENDURE, DAZZLINGLEAM, THUNDER_WAVE, STRENGTH, FLASH, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, FIRE_PUNCH, HEADBUTT, HYPER_VOICE, ICE_PUNCH, ICY_WIND, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, WATER_PULSE, ZAP_CANNON
	; end
