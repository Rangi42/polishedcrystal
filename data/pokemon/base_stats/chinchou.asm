	db  75,  38,  38,  67,  56,  56 ; 330 BST
	;   hp  atk  def  spd  sat  sdf

	db WATER, ELECTRIC ; type
	db 190 ; catch rate
	db 90 ; base exp
	db NO_ITEM, BRIGHTPOWDER ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/chinchou/front.dimensions"
	abilities_for CHINCHOU, VOLT_ABSORB, ILLUMINATE, WATER_ABSORB
	db GROWTH_SLOW ; growth rate
	dn EGG_WATER_2, EGG_WATER_2 ; egg groups

	ev_yield   1,   0,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, SCALD, WILD_CHARGE, WATER_PULSE, FLASH, VOLT_SWITCH, THUNDER_WAVE, SURF, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, ENDURE, ICY_WIND, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, ZAP_CANNON
	; end
