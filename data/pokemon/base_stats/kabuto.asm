	db  30,  80,  90,  55,  55,  45 ; 355 BST
	;   hp  atk  def  spd  sat  sdf

	db ROCK, WATER
	db 45 ; catch rate
	db 119 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 5 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/kabuto/front.dimensions"
	abilities_for KABUTO, SWIFT_SWIM, BATTLE_ARMOR, WEAK_ARMOR
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, INVERTEBRATE ; egg groups

	ev_yield   0,   0,   1,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, HONE_CLAWS, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, GIGA_DRAIN, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SANDSTORM, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, LEECH_LIFE, SCALD, WATER_PULSE, SURF, WHIRLPOOL, WATERFALL, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, ENDURE, ICY_WIND, IRON_HEAD, KNOCK_OFF, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
