	db LANTURN ; 171

if DEF(FAITHFUL)
	db 125,  58,  58,  67,  76,  76
	;   hp  atk  def  spd  sat  sdf
else
	db 125,  58,  58,  67,  86,  86
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, ELECTRIC
	db 75 ; catch rate
	db 156 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 20 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db VOLT_ABSORB ; ability 1
	db ILLUMINATE ; ability 2
	db WATER_ABSORB ; hidden ability
	db SLOW ; growth rate
	dn FISH, FISH ; egg groups

	; ev_yield
	ev_yield   2,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, FLASH_CANNON, WILD_CHARGE, REST, ATTRACT, SCALD, ENDURE, DAZZLINGLEAM, THUNDER_WAVE, VOLT_SWITCH, GIGA_IMPACT, FLASH, SURF, WATERFALL, WHIRLPOOL, AQUA_TAIL, DOUBLE_EDGE, ICY_WIND, SLEEP_TALK, SUBSTITUTE, SUCKER_PUNCH, SWAGGER, WATER_PULSE, ZAP_CANNON
	; end
