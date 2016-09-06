	db STARYU ; 120

	db  30,  45,  55,  85,  70,  55
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 225 ; catch rate
	db 106 ; base exp
	db STARDUST ; item 1
	db STAR_PIECE ; item 2
	db 255 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn INVERTEBRATE, INVERTEBRATE ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, DOUBLE_TEAM, REFLECT, FLASH_CANNON, SWIFT, REST, ATTRACT, SUBSTITUTE, SCALD, ENDURE, DAZZLINGLEAM, THUNDER_WAVE, SURF, FLASH, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, ICY_WIND, ROLLOUT, SLEEP_TALK, SWAGGER, WATER_PULSE, ZAP_CANNON
	; end
