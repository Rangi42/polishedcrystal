	db  50,  50,  40,  50,  30,  30 ; 250 BST
	;   hp  atk  def  spd  sat  sdf

	db ICE, GROUND
	db 225 ; catch rate
	db 78 ; base exp
	db RAWST_BERRY ; item 1
	db SNOWBALL ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/swinub/front.dimensions"
	abilities_for SWINUB, OBLIVIOUS, SNOW_CLOAK, THICK_FAT
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	ev_yield   0,   1,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, BULLDOZE, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, STRENGTH, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, ICY_WIND, SLEEP_TALK, SWAGGER
	; end
