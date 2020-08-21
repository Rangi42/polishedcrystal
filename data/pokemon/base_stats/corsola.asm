if DEF(FAITHFUL)
	db  65,  55,  95,  35,  65,  95 ; 410 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  65,  55, 115,  35, 105, 115 ; 490 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, ROCK
	db 60 ; catch rate
if DEF(FAITHFUL)
	db 113 ; base exp
else
	db 128 ; base exp
endc
	db HARD_STONE ; item 1
	db LUMINOUSMOSS ; item 2
	dn FEMALE_75, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/corsola/front.dimensions"
	abilities_for CORSOLA, HUSTLE, NATURAL_CURE, REGENERATOR
	db FAST ; growth rate
	dn AMPHIBIAN, INVERTEBRATE ; egg groups

	ev_yield   0,   0,   1,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, BULLDOZE, EARTHQUAKE, RETURN, DIG, PSYCHIC, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, SCALD, WATER_PULSE, EXPLOSION, STONE_EDGE, SURF, STRENGTH, WHIRLPOOL, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, ICY_WIND, ROLLOUT, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
