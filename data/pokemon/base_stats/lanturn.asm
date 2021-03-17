if DEF(FAITHFUL)
	db 125,  58,  58,  67,  76,  76 ; 460 BST
	;   hp  atk  def  spd  sat  sdf
else
	db 125,  58,  58,  67,  86,  86 ; 480 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, ELECTRIC
	db 75 ; catch rate
	db 156 ; base exp
	db NO_ITEM ; item 1
	db BRIGHTPOWDER ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/lanturn/front.dimensions"
	abilities_for LANTURN, VOLT_ABSORB, ILLUMINATE, WATER_ABSORB
	db SLOW ; growth rate
	dn FISH, FISH ; egg groups

	ev_yield   2,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, FLASH_CANNON, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, SCALD, WILD_CHARGE, WATER_PULSE, GIGA_IMPACT, FLASH, VOLT_SWITCH, THUNDER_WAVE, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, DOUBLE_EDGE, ENDURE, ICY_WIND, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, ZAP_CANNON
	; end
