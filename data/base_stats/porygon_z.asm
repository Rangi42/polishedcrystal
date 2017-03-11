	db PORYGON_Z ; 474

	db  85,  80,  70,  90, 135,  75
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL
	db 30 ; catch rate
	db 185 ; base exp
	db NO_ITEM ; item 1
	db DUBIOUS_DISC ; item 2
	db 255 ; gender
	db 20 ; step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db ADAPTABILITY ; ability 1
	db DOWNLOAD ; ability 2
	db ANALYTIC ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm TOXIC, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, SWIFT, AERIAL_ACE, FACADE, REST, THIEF, DARK_PULSE, ENDURE, THUNDER_WAVE, GIGA_IMPACT, FLASH, DREAM_EATER, ICY_WIND, SLEEP_TALK, SUBSTITUTE, SWAGGER, ZAP_CANNON, ZEN_HEADBUTT
	; end
