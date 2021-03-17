	db  75,  95,  95,  85,  95,  95 ; 540 BST
	;   hp  atk  def  spd  sat  sdf

	db WATER, DRAGON
	db 45 ; catch rate
	db 207 ; base exp
	db NO_ITEM ; item 1
	db DRAGON_SCALE ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/kingdra/front.dimensions"
	abilities_for KINGDRA, SWIFT_SWIM, SNIPER, DAMP
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, REPTILE ; egg groups

	ev_yield   0,   1,   0,   0,   1,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, FLASH_CANNON, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, SCALD, DRAGON_PULSE, WATER_PULSE, GIGA_IMPACT, SURF, WHIRLPOOL, WATERFALL, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, ICY_WIND, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
