	db  40,  50,  40,  90,  40,  40 ; 300 BST
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 255 ; catch rate
	db 77 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/poliwag/front.dimensions"
	abilities_for POLIWAG, WATER_ABSORB, DAMP, SWIFT_SWIM
	db MEDIUM_SLOW ; growth rate
	dn AMPHIBIAN, AMPHIBIAN ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, DIG, PSYCHIC, DOUBLE_TEAM, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, SCALD, WATER_PULSE, SURF, WHIRLPOOL, WATERFALL, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, ICY_WIND, SLEEP_TALK, SWAGGER
	; end
