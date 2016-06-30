	db STARMIE ; 121

	db  60,  75,  85, 115, 100,  85
	;   hp  atk  def  spd  sat  sdf

	db WATER, PSYCHIC
	db 60 ; catch rate
	db 207 ; base exp
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
	tmhm CURSE, TOXIC, ROLLOUT, HIDDEN_POWER, ICY_WIND, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, DOUBLE_TEAM, REFLECT, SWAGGER, SWIFT, AVALANCHE, REST, ATTRACT, SUBSTITUTE, FLASH_CANNON, SCALD, ENDURE, DAZZLINGLEAM, THUNDER_WAVE, SURF, FLASH, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, DREAM_EATER, SLEEP_TALK, ZAP_CANNON
	; end
