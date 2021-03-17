	db  75,  38,  38,  67,  56,  56 ; 330 BST
	;   hp  atk  def  spd  sat  sdf

	db WATER, ELECTRIC
	db 190 ; catch rate
	db 90 ; base exp
	db NO_ITEM ; item 1
	db BRIGHTPOWDER ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/chinchou/front.dimensions"
	abilities_for CHINCHOU, VOLT_ABSORB, ILLUMINATE, WATER_ABSORB
	db SLOW ; growth rate
	dn FISH, FISH ; egg groups

	ev_yield   1,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, SCALD, WILD_CHARGE, WATER_PULSE, FLASH, VOLT_SWITCH, THUNDER_WAVE, SURF, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, ENDURE, ICY_WIND, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, ZAP_CANNON
	; end
