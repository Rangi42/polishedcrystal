	db 106, 130,  90,  90, 110, 154
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FLYING
	db 3 ; catch rate
	db 220 ; base exp
	db SACRED_ASH ; item 1
	db SACRED_ASH ; item 2
	dn GENDERLESS, 15 ; gender, step cycles to hatch
	dn 7 , 7 ; frontpic dimensions
	db PRESSURE ; ability 1
if DEF(FAITHFUL)
	db PRESSURE ; ability 2
else
	db CLOUD_NINE ; ability 2
endc
	db REGENERATOR ; hidden ability
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   3
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, GIGA_DRAIN, SAFEGUARD, BULLDOZE, SOLAR_BEAM, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, PSYCHIC, SHADOW_BALL, ROOST, DOUBLE_TEAM, REFLECT, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, STEEL_WING, ROCK_SMASH, ENDURE, WILL_O_WISP, GIGA_IMPACT, FLASH, THUNDER_WAVE, FLY, STRENGTH, DOUBLE_EDGE, DREAM_EATER, EARTH_POWER, HYPER_VOICE, IRON_HEAD, SLEEP_TALK, SWAGGER, ZAP_CANNON, ZEN_HEADBUTT
	; end
