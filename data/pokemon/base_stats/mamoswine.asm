	db 110, 130,  80,  80,  70,  60 ; 530 BST
	;   hp  atk  def  spd  sat  sdf

	db ICE, GROUND
	db 50 ; catch rate
	db 207 ; base exp
	db RAWST_BERRY ; item 1
	db NEVERMELTICE ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/mamoswine/front.dimensions"
	abilities_for MAMOSWINE, OBLIVIOUS, SNOW_CLOAK, THICK_FAT
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	ev_yield   0,   3,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, BULLDOZE, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, AVALANCHE, GIGA_IMPACT, STONE_EDGE, STRENGTH, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, ICY_WIND, IRON_HEAD, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
