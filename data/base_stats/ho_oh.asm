	db HO_OH ; 250

	db 106, 130,  90,  90, 110, 154
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FLYING
	db 3 ; catch rate
	db 220 ; base exp
	db SACRED_ASH ; item 1
	db SACRED_ASH ; item 2
	db 255 ; gender
	db 120 ; step cycles to hatch
	dn 7 , 7 ; frontpic dimensions
	db PRESSURE ; ability 1
	db PRESSURE ; ability 2
	db REGENERATOR ; hidden ability
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   3
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, GIGA_DRAIN, SAFEGUARD, DRAGONBREATH, SOLAR_BEAM, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, REFLECT, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SWIFT, AERIAL_ACE, REST, STEEL_WING, SUBSTITUTE, ENDURE, WILL_O_WISP, THUNDER_WAVE, FLY, STRENGTH, FLASH, ROCK_SMASH, DOUBLE_EDGE, DREAM_EATER, EARTH_POWER, HYPER_VOICE, IRON_HEAD, SLEEP_TALK, SWAGGER, ZAP_CANNON, ZEN_HEADBUTT
	; end
