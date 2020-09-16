	db  85,  80,  70,  90, 135,  75 ; 535 BST
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL
	db 30 ; catch rate
	db 185 ; base exp
	db NO_ITEM ; item 1
	db DUBIOUS_DISC ; item 2
	dn GENDERLESS, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/porygon_z/front.dimensions"
	abilities_for PORYGON_Z, ADAPTABILITY, DOWNLOAD, ANALYTIC
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, THIEF, DARK_PULSE, GIGA_IMPACT, FLASH, THUNDER_WAVE, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, ENDURE, ICY_WIND, SLEEP_TALK, SWAGGER, TRICK, ZAP_CANNON, ZEN_HEADBUTT
	; end
