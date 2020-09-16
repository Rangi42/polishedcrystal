	db  30,  45,  55,  85,  70,  55 ; 340 BST
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 225 ; catch rate
	db 106 ; base exp
	db STARDUST ; item 1
	db STAR_PIECE ; item 2
	dn GENDERLESS, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/staryu/front.dimensions"
	abilities_for STARYU, ILLUMINATE, NATURAL_CURE, ANALYTIC
	db SLOW ; growth rate
	dn INVERTEBRATE, INVERTEBRATE ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, DOUBLE_TEAM, REFLECT, FLASH_CANNON, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, SCALD, WATER_PULSE, FLASH, THUNDER_WAVE, GYRO_BALL, SURF, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, ENDURE, ICY_WIND, ROLLOUT, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
