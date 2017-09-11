	db  65, 110, 130,  95,  60,  65
	;   hp  atk  def  spd  sat  sdf

	db GRASS, GRASS
	db 45 ; catch rate
	db 196 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 6 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db LEAF_GUARD ; ability 1
if DEF(FAITHFUL)
	db LEAF_GUARD ; ability 2
else
	db NATURAL_CURE ; ability 2
endc
	db CHLOROPHYLL ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, SOLAR_BEAM, IRON_TAIL, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SMASH, ENERGY_BALL, X_SCISSOR, ENDURE, GIGA_IMPACT, FLASH, SWORDS_DANCE, STRENGTH, EARTH_POWER, HEADBUTT, HYPER_VOICE, KNOCK_OFF, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
