	db 100, 100, 100, 100, 100, 100
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db PSYCHIC, GRASS
else
	db GRASS, FAIRY
endc
	db 45 ; catch rate
	db 64 ; base exp
	db LUM_BERRY ; item 1
	db LUM_BERRY ; item 2
	dn GENDERLESS, 15 ; gender, step cycles to hatch
	dn 5 , 5 ; frontpic dimensions
	db NATURAL_CURE ; ability 1
	db NATURAL_CURE ; ability 2
if DEF(FAITHFUL)
	db NATURAL_CURE ; hidden ability
else
	db MAGIC_GUARD ; hidden ability
endc
	db MEDIUM_SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   3,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SANDSTORM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, DAZZLINGLEAM, ENERGY_BALL, ENDURE, WATER_PULSE, GIGA_IMPACT, U_TURN, FLASH, THUNDER_WAVE, SWORDS_DANCE, CUT, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, EARTH_POWER, SEED_BOMB, SKILL_SWAP, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, TRICK, ZEN_HEADBUTT
	; end
