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
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn FISH, FISH ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, FLASH_CANNON, WILD_CHARGE, REST, ATTRACT, SUBSTITUTE, SCALD, ENDURE, DAZZLINGLEAM, THUNDER_WAVE, SURF, FLASH, WHIRLPOOL, WATERFALL, AQUA_TAIL, DOUBLE_EDGE, ICY_WIND, SLEEP_TALK, SWAGGER, WATER_PULSE, ZAP_CANNON
	; end
