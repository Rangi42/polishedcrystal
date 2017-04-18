	db CHINCHOU ; 170

	db  75,  38,  38,  67,  56,  56
	;   hp  atk  def  spd  sat  sdf

	db WATER, ELECTRIC
	db 190 ; catch rate
	db 90 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db VOLT_ABSORB ; ability 1
	db ILLUMINATE ; ability 2
	db WATER_ABSORB ; hidden ability
	db SLOW ; growth rate
	dn FISH, FISH ; egg groups

	; ev_yield
	ev_yield   1,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, FACADE, WILD_CHARGE, REST, ATTRACT, SCALD, ENDURE, DAZZLINGLEAM, THUNDER_WAVE, FLASH, SURF, WATERFALL, WHIRLPOOL, DOUBLE_EDGE, ICY_WIND, SLEEP_TALK, SUBSTITUTE, SUCKER_PUNCH, SWAGGER, VOLT_SWITCH, WATER_PULSE, ZAP_CANNON
	; end
