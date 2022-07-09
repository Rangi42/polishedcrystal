	db  55,  45,  45,  15,  25,  25 ; 210 BST
	;   hp  atk  def  spd  sat  sdf

	db WATER, GROUND ; type
	db 255 ; catch rate
	db 52 ; base exp
	db NO_ITEM, CHESTO_BERRY ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/wooper/front.dimensions"
	abilities_for WOOPER, DAMP, WATER_ABSORB, UNAWARE
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_1, EGG_GROUND ; egg groups

	ev_yield   1,   0,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, SAFEGUARD, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SLUDGE_BOMB, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, SCALD, WATER_PULSE, FLASH, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, ICE_PUNCH, ICY_WIND, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
